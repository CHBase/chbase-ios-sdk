//
//  WebResponse.h
//  CHBase Mobile Library for iOS
//
//

#import <Foundation/Foundation.h>


/// Represents xml response from HealthVault server.
/// The data related to a request.
@interface WebResponse : NSObject {

	NSString *_responseData;
	NSString *_errorText;
    int _webStatusCode;
}

/// Gets or sets the response data.
@property (retain) NSString *responseData;

/// Gets or sets the error text.
@property (retain) NSString *errorText;

/// Gets error status for response. Returns YES if request has been failed.
@property (readonly, getter = getHasError) BOOL hasError;

@property (readwrite) int webStatusCode;

@end
