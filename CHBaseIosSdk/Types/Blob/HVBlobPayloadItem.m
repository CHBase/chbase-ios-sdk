//
//  HVBlobPayloadItem.m
//  HVLib
//
//
//

#import "HVCommon.h"
#import "HVBlobPayloadItem.h"

static NSString* const c_element_blobInfo = @"blob-info";
static NSString* const c_element_length = @"content-length";
static NSString* const c_element_blobUrl = @"blob-ref-url";
static NSString* const c_element_legacyEncoding = @"legacy-content-encoding";
static NSString* const c_element_currentEncoding = @"current-content-encoding";

@implementation HVBlobPayloadItem

@synthesize blobInfo = m_blobInfo;
@synthesize length = m_length;
@synthesize blobUrl = m_blobUrl;

-(NSString *)name
{
    return (m_blobInfo) ? m_blobInfo.name : c_emptyString;
}

-(NSString *)contentType
{
    return (m_blobInfo) ? m_blobInfo.contentType : c_emptyString;
}

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    m_length = -1;
    
    return self;

LError:
    HVALLOC_FAIL;
}

-(id)initWithBlobName:(NSString *)name contentType:(NSString *)contentType length:(NSInteger)length andUrl:(NSString *)blobUrl
{
    HVCHECK_STRING(blobUrl);
    
    self = [self init];
    HVCHECK_SELF;
    
    m_blobInfo = [[HVBlobInfo alloc] initWithName:name andContentType:contentType];
    HVCHECK_NOTNULL(m_blobInfo);
    
    m_length = length;
   
    HVRETAIN(m_blobUrl, blobUrl);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_blobInfo release];
    [m_blobUrl release];
    [m_legacyEncoding release];
    [m_encoding release];
    
    [super dealloc];
}

-(HVHttpResponse *)createDownloadTaskWithCallback:(HVTaskCompletion)callback
{
    NSURL* url = [NSURL URLWithString:m_blobUrl];
    HVCHECK_NOTNULL(url);
    
    return [[[HVHttpResponse alloc] initWithUrl:url andCallback:callback] autorelease];

LError:
    return nil;
}

-(HVHttpResponse *)downloadWithCallback:(HVTaskCompletion)callback
{
    HVHttpResponse* response = [self createDownloadTaskWithCallback:callback];
    HVCHECK_NOTNULL(response);
    
    [response start];
    
    return response;

LError:
    return nil;
}

-(HVHttpDownload *)downloadToFilePath:(NSString *)path andCallback:(HVTaskCompletion)callback
{
    return [self downloadToFile:[NSFileHandle fileHandleForWritingAtPath:path] andCallback:callback];
}

-(HVHttpDownload *)downloadToFile:(NSFileHandle *)file andCallback:(HVTaskCompletion)callback
{
    NSURL* url = [NSURL URLWithString:m_blobUrl];
    HVCHECK_NOTNULL(url);
    
    HVHttpDownload* response = [[[HVHttpDownload alloc] initWithUrl:url fileHandle:file andCallback:callback] autorelease];
    [response start];
    
    return response;
    
LError:
    return nil;    
}

-(HVClientResult *)validate
{   
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_blobInfo, HVClientError_InvalidBlobInfo);
    HVVALIDATE_STRING(m_blobUrl, HVClientError_InvalidBlobInfo);
    
    HVVALIDATE_FAIL

LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_blobInfo, c_element_blobInfo);
    HVSERIALIZE_INT(m_length, c_element_length);
    HVSERIALIZE_STRING(m_blobUrl, c_element_blobUrl);
    HVSERIALIZE_STRING(m_legacyEncoding, c_element_legacyEncoding);
    HVSERIALIZE_STRING(m_encoding, c_element_currentEncoding);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_blobInfo, c_element_blobInfo, HVBlobInfo);
    HVDESERIALIZE_INT(m_length, c_element_length);
    HVDESERIALIZE_STRING(m_blobUrl, c_element_blobUrl);
    HVDESERIALIZE_STRING(m_legacyEncoding, c_element_legacyEncoding);
    HVDESERIALIZE_STRING(m_encoding, c_element_currentEncoding);
}

@end

@implementation HVBlobPayloadItemCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVBlobPayloadItem class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVBlobPayloadItem *)itemAtIndex:(NSUInteger)index
{
    return (HVBlobPayloadItem *) [self objectAtIndex:index];
}

-(NSUInteger)indexofDefaultBlob
{
    return [self indexOfBlobNamed:c_emptyString];
}

-(NSUInteger)indexOfBlobNamed:(NSString *)name
{
    for (NSUInteger i = 0, count = self.count; i < count; ++i)
    {
        HVBlobPayloadItem* item = [self itemAtIndex:i];
        NSString* blobName = item.name;
        if ([blobName isEqualToString:name])
        {
            return i;
        }
    }
    
    return NSNotFound;
}

-(HVBlobPayloadItem *)getDefaultBlob
{
    NSUInteger index = [self indexofDefaultBlob];
    if (index != NSNotFound)
    {
        return [self itemAtIndex:index];
    }
    
    return nil;
}

-(HVBlobPayloadItem *)getBlobNamed:(NSString *)name
{
    NSUInteger index = [self indexOfBlobNamed:name];
    if (index != NSNotFound)
    {
        return [self itemAtIndex:index];
    }
    
    return nil;    
}

@end