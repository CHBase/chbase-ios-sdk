//
//  HealthVaultSettings.m
//  CHBase Mobile Library for iOS
//
//

#import "HVCommon.h"
#import "HealthVaultSettings.h"
#import "HVKeyChain.h"

/// Used for unique identification setting in preferences.
#define HEALTHVAULT_SETTINGS_PREFIX @"HealthVault"

/// Used for storing settings when name is not specified.
#define DEFAULT_SETTINGS_NAME @""

@interface HealthVaultSettings (Private)

/// Makes special prefix for settings stored in user defaults on the device.
/// @param name - name for which to make a prefix. If nil then default name is used (DEFAULT_SETTINGS_NAME).
/// @returns special prefix for settings.
+ (NSString *)makePrefixForName: (NSString *)name;

@end

@implementation HealthVaultSettings

@synthesize name = _name;
@synthesize version = _version;
@synthesize applicationId = _applicationId;
@synthesize applicationCreationToken = _applicationCreationToken;
@synthesize authorizationSessionToken = _authorizationSessionToken;
@synthesize sharedSecret = _sharedSecret;
@synthesize country = _country;
@synthesize language = _language;
@synthesize sessionSharedSecret = _sessionSharedSecret;
@synthesize personId = _personId;
@synthesize recordId = _recordId;
@synthesize userAuthToken = _userAuthToken;

- (id)initWithName: (NSString *)name {

	if (self = [super init]) {

		self.name = name;
	}

	return self;
}

- (void)dealloc {

	self.name = nil;
	self.version = nil;
	self.applicationId = nil;
	self.applicationCreationToken = nil;
	self.authorizationSessionToken = nil;
	self.sharedSecret = nil;
	self.applicationCreationToken = nil;
	self.country = nil;
	self.language = nil;
	self.sessionSharedSecret = nil;
	self.personId = nil;
	self.recordId = nil;
    self.userAuthToken = nil;
    
	[super dealloc];
}

- (void)save {

	NSUserDefaults *perfs = [NSUserDefaults standardUserDefaults];
	NSString *prefix = [HealthVaultSettings makePrefixForName: self.name];

	[perfs setObject: self.version 
			  forKey: [NSString stringWithFormat: @"%@version", prefix]];

	[perfs setObject: self.applicationId
			  forKey: [NSString stringWithFormat: @"%@applicationId", prefix]];

	[perfs setObject: self.applicationCreationToken
			  forKey: [NSString stringWithFormat: @"%@applicationCreationToken", prefix]];
    
	[perfs setObject: self.authorizationSessionToken
			  forKey: [NSString stringWithFormat: @"%@authorizationSessionToken", prefix]];
    
    [perfs setObject: self.userAuthToken
			  forKey: [NSString stringWithFormat: @"%@userAuthToken", prefix]];
    
    [HVKeyChain setPassword:self.sharedSecret forName:[NSString stringWithFormat:@"%@sharedSecret", prefix]];
    [HVKeyChain setPassword:self.sessionSharedSecret forName:[NSString stringWithFormat:@"%@sessionSharedSecret", prefix]];
    
	[perfs setObject: self.country
			  forKey: [NSString stringWithFormat: @"%@country", prefix]];

	[perfs setObject: self.language
			  forKey: [NSString stringWithFormat: @"%@language", prefix]];
        
	[perfs setObject: self.personId
			  forKey: [NSString stringWithFormat: @"%@personId", prefix]];
	
	[perfs setObject: self.recordId
			  forKey: [NSString stringWithFormat: @"%@recordId", prefix]];

	[perfs synchronize];
}

+ (HealthVaultSettings *)loadWithName: (NSString *)name {

	NSUserDefaults *perfs = [NSUserDefaults standardUserDefaults];
	NSString *prefix = [HealthVaultSettings makePrefixForName: name];

	HealthVaultSettings *settings = [HealthVaultSettings new];

	settings.version = [perfs objectForKey: [NSString stringWithFormat: @"%@version", prefix]];

	settings.applicationId = [perfs objectForKey: [NSString stringWithFormat: @"%@applicationId", prefix]];

	settings.applicationCreationToken = [perfs objectForKey: [NSString stringWithFormat: @"%@applicationCreationToken", prefix]];
    settings.authorizationSessionToken = [perfs objectForKey: [NSString stringWithFormat: @"%@authorizationSessionToken", prefix]];
    settings.userAuthToken = [perfs objectForKey: [NSString stringWithFormat: @"%@userAuthToken", prefix]];

    NSString* sessionToken = settings.authorizationSessionToken;
    if ([NSString isNilOrEmpty:sessionToken])
    {
        settings.sharedSecret = nil;
        settings.sessionSharedSecret = nil;
    }
    else 
    {
        settings.sharedSecret = [HVKeyChain getPasswordString:[NSString stringWithFormat:@"%@sharedSecret", prefix]];
        settings.sessionSharedSecret = [HVKeyChain getPasswordString:[NSString stringWithFormat:@"%@sessionSharedSecret", prefix]];
    }
    
	settings.country = [perfs objectForKey: [NSString stringWithFormat: @"%@country", prefix]];

	settings.language = [perfs objectForKey: [NSString stringWithFormat: @"%@language", prefix]];

	
	settings.personId = [perfs objectForKey: [NSString stringWithFormat: @"%@personId", prefix]];
	
	settings.recordId = [perfs objectForKey: [NSString stringWithFormat: @"%@recordId", prefix]];


	return [settings autorelease];
}

+ (NSString *)makePrefixForName: (NSString *)name {

	// Sets default value for name of this is nil.
	if (!name) {
		name = DEFAULT_SETTINGS_NAME;
	}
	NSString *prefix = [NSString stringWithFormat: @"%@%@", HEALTHVAULT_SETTINGS_PREFIX, name];

	return prefix;
}

@end
