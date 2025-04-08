//
//  HVURLRequestExtensions.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVHttp.h"


//-------------------------
//
// HVHttpResponse
// Typically used just for a Get
//
//-------------------------

@interface HVHttpResponse : HVHttp
{
@protected
    NSURLResponse* m_response;
    NSMutableData* m_responseBody;
}

@property (readonly, nonatomic) NSURLResponse* response;
@property (readonly, nonatomic) NSMutableData* responseBody;

@end

//-------------------------
//
// HVHttpRequestResponse - use for REST style operations
//
//-------------------------

@interface HVHttpRequestResponse : HVHttpResponse
{
@protected
    NSData* m_requestBody;
}

@property (readwrite, nonatomic, retain) NSData* requestBody;

@end
