//
//  HVURLRequestExtensions.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVHttpRequestResponse.h"

@implementation HVHttpResponse

@synthesize response = m_response;

-(NSMutableData *)responseBody
{
    return (NSMutableData *) self.result;
}

-(void)dealloc
{
    [m_response release];
    [m_responseBody release];
    
    [super dealloc];
}

-(void)start
{
    HVENSURE(m_responseBody, NSMutableData);
    [m_responseBody setLength:0];
    
    self.result = m_responseBody;
    
    [super start];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    HVRETAIN(m_response, response);
    [m_responseBody setLength:0];    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [m_responseBody appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    int statusCode = [((NSHTTPURLResponse *)m_response) statusCode];
    if (statusCode != 200)
    {       
        HVHttpException* ex = [[HVHttpException alloc] initWithStatusCode:statusCode];
        [super handleError:ex];
        [ex release];
    }
    
    [self complete];
}

@end

@implementation HVHttpRequestResponse

@synthesize requestBody = m_requestBody;

-(void)dealloc
{
    [m_requestBody release];
    [super dealloc];
}

-(void)start
{
    if (m_requestBody)
    {
        [m_request setContentLength:m_requestBody.length];
        [m_request setHTTPBody:m_requestBody];
    }
    
    [super start];
}

@end
