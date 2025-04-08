//
//  HealthVaultSettings.h
//  CHBase Mobile Library for iOS
//
//

#import <Foundation/Foundation.h>

/// Provides settings management functionality.
@interface HealthVaultSettings : NSObject {

	NSString *_version;
	NSString *_applicationId;
	NSString *_applicationCreationToken;
	NSString *_authorizationSessionToken;
	NSString *_sharedSecret;
	NSString *_country;
	NSString *_language;
	NSString *_sessionSharedSecret;
	NSString *_personId;
	NSString *_recordId;
	NSString *_name;
    NSString *_userAuthToken;
}

/// Gets or sets the settings name.
@property (retain) NSString *name;

/// Gets or sets application version.
@property (retain) NSString *version;

/// Gets or sets the application Id. 
@property (retain) NSString *applicationId;

/// Gets or sets the application creation token.
@property (retain) NSString *applicationCreationToken;

/// Gets or sets the authorization session token.
@property (retain) NSString *authorizationSessionToken;

/// Gets or sets the shared secret.
@property (retain) NSString *sharedSecret;

/// Gets or sets country.
@property (retain) NSString *country;

/// Gets or sets language.
@property (retain) NSString *language;

/// Gets or sets session shared secret.
@property (retain) NSString *sessionSharedSecret;

/// Gets or sets person Id.
@property (retain) NSString *personId;

/// Gets or sets record Id.
@property (retain) NSString *recordId;

// Gets or sets the user-auth-token, if any
@property (retain) NSString* userAuthToken;

/// Initializes settings with specific name.
/// @param name - settings file name.
- (id)initWithName: (NSString *)name;

/// Saves settings.
- (void)save;

/// Loads settings with specified name.
/// @param name - settings file name.
/// @returns settings instance loaded with specific name.
+ (HealthVaultSettings *)loadWithName: (NSString *)name;

@end
