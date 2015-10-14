//
//  AuthenticationCheckState.h
//  CHBase Mobile Library for iOS
//
//

#import <Foundation/Foundation.h>


@class HealthVaultService;

/// The data required to perform the authentication flow.
@interface AuthenticationCheckState : NSObject {

    HealthVaultService *_service;
    NSObject *_target;
    SEL _authCompletedCallBack;
    SEL _shellAuthRequiredCallBack;
}

/// Gets or sets the service.
@property (retain) HealthVaultService *service;

/// Gets or sets the callback handler.
@property (retain) NSObject *target;

/// Gets or sets the authentication completed handler.
@property (assign) SEL authCompletedCallBack;

// Gets or sets the Shell Authorization required handler.
@property (assign) SEL shellAuthRequiredCallBack;

/// Initializes a new instance of the AuthenticationCheckState class.
/// @param service - the HealthVaultService instance.
/// @param target - callBack method owner.
/// @param authCallBack - callback if shell authorization is completed.
/// @param authRequiredCallBack - callBack if shell authorization is required.
- (id)initWithService: (HealthVaultService *)service
			   target: (NSObject *)target
authCompletedCallBack: (SEL)authCallBack
shellAuthRequiredCallBack: (SEL)authRequiredCallBack;

@end
