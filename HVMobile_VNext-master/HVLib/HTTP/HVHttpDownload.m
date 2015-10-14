//
//  HVHttpDownload.m
//  HVLib
//
//
//

#import "HVCommon.h"
#import "HVHttpDownload.h"
#import "HVDirectory.h"

@implementation HVHttpDownload

@synthesize file = m_file;

-(id)initWithUrl:(NSURL *)url filePath:(NSString *)path andCallback:(HVTaskCompletion)callback
{
    return [self initWithUrl:url fileHandle:[NSFileHandle createOrOpenForWriteAtPath:path] andCallback:callback];
}

-(id)initWithUrl:(NSURL *)url fileHandle:(NSFileHandle *)file andCallback:(HVTaskCompletion)callback
{
    HVCHECK_NOTNULL(file);
  
    self = [super initWithUrl:url andCallback:callback];
    HVCHECK_SELF;
    
    HVRETAIN(m_file, file);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_file release];
    [m_response release];
    [super dealloc];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    HVRETAIN(m_response, response);

    if (m_file)
    {
        [m_file truncateFileAtOffset:0];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [m_file writeData:data];
    m_totalBytesWritten += data.length;
    if (m_delegate)
    {
        [m_delegate totalBytesWritten:m_totalBytesWritten];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    int statusCode = [((NSHTTPURLResponse *)m_response) statusCode];
    if (statusCode >= 400)
    {       
        HVHttpException* ex = [[HVHttpException alloc] initWithStatusCode:statusCode];
        [super handleError:ex];
        [ex release];
    }

    [self complete];
}

@end
