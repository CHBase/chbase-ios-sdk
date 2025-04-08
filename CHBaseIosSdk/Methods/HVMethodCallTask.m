//
//  HVMethodCall.m
//  HVLib
//

#import "HVCommon.h"
#import "HVMethodCallTask.h"
#import "HVClient.h"
#import "HVRecordReference.h"
#import "HealthVaultRequest.h"
#import "HealthVaultResponse.h"

@interface HVMethodCallTask (HVPrivate)

-(void) sendRequest;
-(void) handleResponse:(HealthVaultResponse *) response;

-(NSString *) serializeRequestBody;
-(id) deserializeResponse:(HealthVaultResponse *) response;

-(BOOL) shouldRetry:(HealthVaultResponse *) response;

@end

@implementation HVMethodCallTask

@synthesize status = m_status;
@synthesize record = m_record;
@synthesize useMasterAppID = m_useMasterAppID;

-(NSString *)name
{
    return c_emptyString;
}

-(float) version
{
    return 1;
}

-(BOOL)hasError
{
    @synchronized(self)
    {
        return (m_status.hasError || super.hasError);
    }
}

-(id)initWithCallback:(HVTaskCompletion)callback
{
    self = [super initWithCallback:callback];
    HVCHECK_SELF;
    
    m_status = [[HVServerResponseStatus alloc] init];
    HVCHECK_NOTNULL(m_status);
    
    m_useMasterAppID = FALSE;
    
    return self;
    
LError:
    HVALLOC_FAIL;    
}

-(void)dealloc
{
    [m_status release];
    [m_record release];
    [super dealloc];
}

-(void)clearError
{
    [super clearError];
    [m_status clear];
}

-(void)checkSuccess
{
    if (m_status.hasError)
    {
        [HVServerException throwExceptionWithStatus:m_status];
    }
    [super checkSuccess];
}

-(void)start
{
    [self prepare];
    [super start:^{
        [self sendRequest];
    }];
}

-(void) validateObject:(id)obj
{
    if ([obj respondsToSelector:@selector(validate)])
    {
        HVClientResult* validationResult = [obj validate];
        if (validationResult.isError)
        {
            NSLog(@"%@", validationResult.description);
            [HVClientException throwExceptionWithError:validationResult];
        }
    }
}

-(void) prepare
{
    
}

-(void)ensureRecord
{
    //
    // We need to make sure the caller specified exactly which record they are using
    // Can't use [HVClient current].currentRecord - which won't necessarily be the one the
    // user intended to use - in multi-threaded cases
    //
    if (!m_record)
    {
        [HVClientException throwExceptionWithError:HVMAKE_ERROR(HVClientError_InvalidRecordReference)];
    }
}

-(void)serializeRequestBodyToWriter:(XWriter *)writer
{
    
}

-(id)deserializeResponseBodyFromReader:(XReader *)reader
{
    if ([reader isStartElement])
    {
        [reader skipElement:reader.localName];
    }
    
    return nil;
}

-(id)deserializeResponseBodyFromReader:(XReader *)reader asClass:(Class)cls
{
    return [NSObject newFromReader:reader withRoot:@"info" asClass:cls];
}

@end

@implementation HVMethodCallTask (HVPrivate)

-(void)sendRequest
{
    ++m_attempt;
    HealthVaultRequest* request = nil;    
    NSString* xml = [self serializeRequestBody];
    @try 
    {
        request = [[HealthVaultRequest alloc] 
                   initWithMethodName:self.name 
                   methodVersion:self.version 
                   infoSection:xml 
                   target:self 
                   callBack:@selector(handleResponse:)];
        HVCHECK_OOM(request);
        
        self.operation = request;        
        if (m_record)
        {
            request.recordId = m_record.ID;
            request.personId = m_record.personID;
        }
        
        if (m_useMasterAppID)
        {
            request.appIdInstance = [HVClient current].settings.masterAppID;
        }
        
        [[HVClient current].service sendRequest:request];
    }
    @finally 
    {
        [request release];
        [xml release];
    }
}

-(void)handleResponse:(HealthVaultResponse *)response
{
    BOOL isDone = TRUE;
    @try 
    {
        @synchronized(self)
        {
            if ([self shouldRetry:response])
            {
                isDone = FALSE;
                NSLog(@"Retrying request \r\n%@", response.request.infoXml);
                [self sendRequest];
                return;
            }
            
            m_status.statusCode = response.statusCode;
            m_status.errorText = response.errorText;
            m_status.errorDetailsXml = response.errorContextXml;    
            m_status.webStatusCode = response.webStatusCode;
            
            if (m_status.hasError)
            {
                NSLog(@"Error for \r\n%@", response.request.infoXml);
                return;
            }
            
            id resultObj = [self deserializeResponse:response]; 
            self.result = resultObj;
            [resultObj release];
        }
    }
    @catch (id ex) 
    {
        [self handleError:ex];
    }
    @finally 
    {
        if (isDone)
        {
            [self complete];
        }
    }
}

-(NSString *)serializeRequestBody
{
    XWriter *writer = [[XWriter alloc] initWithBufferSize:2048];
    HVCHECK_NOTNULL(writer);
    
    @try 
    {
        HVCHECK_XWRITE([writer writeStartElement:@"info"]);
        {
            [self serializeRequestBodyToWriter:writer];
        }
        HVCHECK_XWRITE([writer writeEndElement]);
        
        return [writer newXmlString];
    }
    @finally 
    {
        [writer release];
    }
    
LError:
    return nil;
}

-(id)deserializeResponse:(HealthVaultResponse *)response
{
    NSString* infoXml = response.infoXml;
    if ([NSString isNilOrEmpty:infoXml])
    {
        return nil;
    }

#ifdef LOGXML
    NSLog(@"%@", response.infoXml);
#endif
    
    XReader *reader = [[XReader alloc] initFromString:response.infoXml];
    HVCHECK_OOM(reader);
    @try
    {
        return [self deserializeResponseBodyFromReader:reader];
    }
    @finally 
    {
        [reader release];
    }
}

-(BOOL)shouldRetry:(HealthVaultResponse *) response
{
    return (m_attempt < [HVClient current].settings.maxAttemptsPerRequest && response.webStatusCode >= 500);
}
@end