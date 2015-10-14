//
//  HVHttpTransport.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVHttpTransport.h"
#import "WebTransport.h"

@implementation HVHttpTransport

-(NSURLConnection *)sendRequestForURL:(NSString *)url withData:(NSString *)data context:(NSObject *)context target:(NSObject *)target callBack:(SEL)callBack
{
    return [WebTransport sendRequestForURL:url withData:data context:context target:target callBack:callBack];
}

@end
