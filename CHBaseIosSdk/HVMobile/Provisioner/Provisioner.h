//
//  Provisioner.h
//  CHBase Mobile Library for iOS
//
//

#import <Foundation/Foundation.h>

@class HealthVaultService;

/// Implements the application authorization process.
@interface Provisioner : NSObject

/// Authorizes other records.
/// @param service - the HealthVaultService instance.
/// @param target - callback method owner.
/// @param authCompleted - method that is called when the authentication process is complete.
/// @param shellAuthRequired - method that is called when the application needs to perform authorization.
-(void)authorizeRecords: (HealthVaultService *)service
                  target: (NSObject *)target
 authenticationCompleted: (SEL)authCompleted
       shellAuthRequired: (SEL)shellAuthRequired;

/// Checks that the application is authenticated.
/// @param service - the HealthVaultService instance.
/// @param target - callback method owner.
/// @param authCompleted - method that is called when the authentication process is complete.
/// @param shellAuthRequired - method that is called when the application needs to perform authorization.
-(void)performAuthenticationCheck: (HealthVaultService *)service
                            target: (NSObject *)target
           authenticationCompleted: (SEL)authCompleted
                 shellAuthRequired: (SEL)shellAuthRequired;

@end
