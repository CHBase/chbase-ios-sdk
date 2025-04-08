//
//  WebTransport.h
//  CHBase Mobile Library for iOS
//
//

#import <Foundation/Foundation.h>


/// Class to simplify making POSTs and obtaining the responses.
@interface WebTransport : NSObject {

    NSURLResponse* _response;
    NSMutableData *_responseBody;
    NSObject *_context;
    NSObject *_target;
    SEL _callBack;
    
    NSURLConnection* _connection;
}

/// Returns whether all requests and responses should be logged.
+ (BOOL)isRequestResponseLogEnabled;

/// Sets current logging status. 
/// @param enabled - If YES then both request and response will be logged.
+ (void)setRequestResponseLogEnabled: (BOOL)enabled;

/// Sends a post request to a specific URL.
/// @param url - string which contains server address.
/// @param data - string will be sent in POST header.
/// @param context - any object will be passed to callBack with response.
/// @param target - callback method owner.
/// @param callBack - the method to call when the request has completed.
+ (NSURLConnection *)sendRequestForURL: (NSString *)url
                 withData: (NSString *)data
                  context: (NSObject *)context
                   target: (NSObject *)target
                 callBack: (SEL)callBack;

@end
