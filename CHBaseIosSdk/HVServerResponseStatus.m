//
//  HVServerResult.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVServerResponseStatus.h"

@implementation HVServerResponseStatus

@synthesize statusCode = m_statusCode;
@synthesize errorText  = m_errorText;
@synthesize errorDetailsXml = m_errorDetails;

-(BOOL)hasError
{
    return (m_statusCode != 0 ||
            m_errorText != nil ||
            m_webStatusCode >= 400);
}

-(BOOL)isHVError
{
    return (m_statusCode > 0);
}

@synthesize webStatusCode = m_webStatusCode;

-(BOOL)isWebError
{
    return (m_webStatusCode >= 400);
}

-(BOOL)isAccessDenied
{
    switch (m_statusCode)
    {
        default:
            return FALSE;

        case HVServerStatusCodeAccessDenied:
        case HVServerStatusCodeInvalidApp:
        case HVServerStatusCodeInvalidApplicationAuthorization:
            break;
    }
    
    return TRUE;
}

-(BOOL)isServerTokenError
{
    switch (m_statusCode)
    {
        default:
            return FALSE;
            
        case HVServerStatusCodeAuthSessionTokenExpired:
        case HVServerStatusCodeCredentialTokenExpired:
            break;
    }
    
    return TRUE;
}

-(BOOL)isInvalidTarget
{
    switch (m_statusCode)
    {
        default:
            return FALSE;
            
        case HVServerStatusCodeInvalidRecord:
        case HVServerStatusCodeInvalidPerson:
            break;
    }
    
    return TRUE;
}

-(BOOL)isItemNotFound
{
    return (m_statusCode == HVServerStatusCodeInvalidItem);
}

-(BOOL)isVersionStampMismatch
{
    return (m_statusCode == HVServerStatusCodeVersionStampMismatch);
}

-(BOOL)isItemKeyNotFound
{
    switch (m_statusCode)
    {
        default:
            return FALSE;
            
        case HVServerStatusCodeInvalidItem:
        case HVServerStatusCodeVersionStampMismatch:
        case HVServerStatusCodeInvalidXml:
            break;
    }
    
    return TRUE;
}

-(BOOL)isServerError
{
    switch (m_statusCode)
    {
        default:
            return FALSE;
            
        case HVServerStatusCodeFailed:
        case HVServerStatusCodeRequestTimedOut:
            break;
    }
    
    return TRUE;
}

-(id)initWithStatusCode:(enum HVServerStatusCode)code
{
    self = [super init];
    HVCHECK_SELF;
    
    m_statusCode = code;
    
    return self;

LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_errorText release];
    [m_errorDetails release];
    [super dealloc];
}

-(BOOL)isStatusCode:(enum HVServerStatusCode)code
{
    return (m_statusCode == (int) code);
}

-(NSString *)description
{
    if (self.isHVError)
    {
        return [NSString stringWithFormat:@"[StatusCode=%d], %@", m_statusCode, m_errorText];
    }
    
    return m_errorText;
}

-(void)clear
{
    m_statusCode = HVServerStatusCodeOK;
    HVCLEAR(m_errorText);
    HVCLEAR(m_errorDetails);
    m_webStatusCode = 0;
}

@end

@implementation HVServerException

@synthesize status = m_status;

-(id)initWithStatus:(HVServerResponseStatus *)status
{
    HVCHECK_NOTNULL(status);
    
    self = [super initWithName:@"HVServerException" reason:c_emptyString userInfo:nil];
    HVCHECK_SELF;
    
    self.status = status;
    
    return self;

LError:
    HVALLOC_FAIL;
}

-(NSString *)description
{
    return m_status.description;
}
                                
-(void)dealloc
{
    [m_status release];
    [super dealloc];
}

+(void)throwExceptionWithStatus:(HVServerResponseStatus *)status
{
    @throw [[[HVServerException alloc] initWithStatus:status] autorelease];
}

@end