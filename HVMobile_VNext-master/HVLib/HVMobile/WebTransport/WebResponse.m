//
//  WebResponse.m
//  CHBase Mobile Library for iOS
//
//

#import "WebResponse.h"


@implementation WebResponse

@synthesize responseData = _responseData;
@synthesize errorText = _errorText;
@synthesize webStatusCode = _webStatusCode;

- (void)dealloc {

	self.responseData = nil;
	self.errorText = nil;

	[super dealloc];
}

- (BOOL)getHasError {

    return self.errorText != nil;
}

@end
