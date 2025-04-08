//
//  HealthVaultService.h
//  CHBase Mobile Library for iOS
//
//

#import <Foundation/Foundation.h>
#import "HVService.h"
#import "HealthVaultRequest.h"
#import "HealthVaultResponse.h"
#import "MobilePlatform.h"
#import "WebResponse.h"
#import "WebTransport.h"

/// A class used to communicate with the HealthVault web service.
@interface HealthVaultService : NSObject<HealthVaultService>
{

	NSString *_healthServiceUrl;
	NSString *_shellUrl;
	NSString *_authorizationSessionToken;
	NSString *_sharedSecret;
	NSString *_sessionSharedSecret;
	NSString *_masterAppId;
	NSString *_language;
	NSString *_country;
	NSString *_appIdInstance;
	NSString *_applicationCreationToken;

	NSMutableArray *_records;
	HealthVaultRecord *_currentRecord;
    
    NSTimeInterval _requestDelay;
    NSString* _settingsFileName;
    //
    // Providers
    //
    id<HVHttpTransport> _transport;
    id<HVCryptographer> _cryptographer;
    Provisioner* _provisioner;
    
}

/// Gets or sets the URL that is used to talk to the HealthVault Web Service.
@property (retain) NSString *healthServiceUrl;

/// Gets or sets the URL that is used to talk to the HealthVault Shell.
@property (retain) NSString *shellUrl;

/// Gets or sets the authorization token that is required to talk to the HealthVault
@property (retain) NSString *authorizationSessionToken;

/// Gets or sets the application shared secret.
@property (retain) NSString *sharedSecret;

/// Gets or sets the session shared secret.
@property (retain) NSString *sessionSharedSecret;

/// Gets or sets the master app id.
/// The master application is predefined by the developer using the Application Configuration Center tool. 
@property (retain) NSString *masterAppId;

/// Gets or sets the language that is used for responses.
@property (retain) NSString *language;

/// Gets or sets the country that is used for responses.
@property (retain) NSString *country;

@property (retain) NSString* deviceName;

/// Gets or sets the application instance id.
@property (retain) NSString *appIdInstance;

/// Gets or sets the application creation token.
/// The application token is returned from the CreateApplicationRequest method, and is
/// only useful for passing to the HealthVault Shell to start the authorization and application
/// creation process. 
@property (retain) NSString *applicationCreationToken;

/// Gets the list of records that this application is authorized to use.
@property (retain) NSMutableArray *records;

/// Gets or sets the person and record that will be used.
@property (retain) HealthVaultRecord *currentRecord;
@property (readonly) BOOL isAppCreated;

/// Is YES if current application instance has already been created, otherwise FALSE.
@property (readonly, getter = getIsApplicationCreated) BOOL isApplicationCreated;

@property (readwrite, nonatomic) NSTimeInterval requestSendDelay;
@property (readwrite, nonatomic, retain) NSString* settingsFileName;

//--------------------------------------------
//
// Providers
//
//--------------------------------------------
@property (retain) id<HVHttpTransport> transport;
@property (retain) id<HVCryptographer> cryptographer;
@property (retain) Provisioner* provisioner;

//--------------------------------------------
//
// Methods
//
//--------------------------------------------

/// Initializes a new instance of the HealthVaultService class 
/// using default platform and shell URLs.
/// The master application id must come from the HealthVault Application Configuration
/// Center, and that application must set to be a SODA application. 
/// Before requests can be made, the  method performAuthenticationCheck must be called.
/// @param masterAppId - the master application id for this application.
- (id)initWithDefaultUrl: (NSString *)masterAppId;

/// Initializes a new instance of the HealthVaultService class.
/// The master application id must come from the HealthVault Application Configuration
/// Center, and that application must set to be a SODA application. 
/// Before requests can be made, the  method performAuthenticationCheck must be called.
/// @param healthServiceUrl - the Url to use to talk to the HealthVault web service.
/// @param shellUrl - the Url to use for the HealthVault Shell.
/// @param masterAppId - the master application id for this application.
- (id)initWithUrl:(NSString *)healthServiceUrl
		shellUrl:(NSString *)shellUrl
		masterAppId:(NSString *)masterAppId;

-(id) initForAppID:(NSString *) appID andEnvironment:(HVEnvironmentSettings *) environment;

/// Returns the URL string to use to provision the application.
- (NSString *)getApplicationCreationUrl;

/// Returns the URL string to use to authorize additional records.
- (NSString *)getUserAuthorizationUrl;

/// Generates the info section for the cast call.
/// @returns the generate info section.
- (NSString *)getCastCallInfoSection;

/// Saves the results of a cast call into the session.
/// @param responseXml - the response xml.
- (void)saveCastCallResults: (NSString *)responseXml;

/// Sends a request to the HealthVault web service.
/// This method returns immediately; the results and any error information will be passed to the
/// completion method stored in the request.
/// Please ensure that the method performAuthenticationCheck is called before making requests.
/// @param request - the request to send.
///
- (void)sendRequest:(HealthVaultRequest *)request;
///
/// This is useful when faking testing (poor man's) for slower 3G networks.
///
- (void)sendRequest:(HealthVaultRequest *)request withDelay:(NSTimeInterval) delay;

/// Authorizes more records.
/// @param target - callback handler.
/// @param authCompleted - method that is called when the authentication process is complete.
/// @param shellAuthRequire - method that is called when the application needs to perform authorization.
/// Applications should call SaveSettings in both of the handlers.
- (void)authorizeRecords: (NSObject *)target
 authenticationCompleted: (SEL)authCompleted
	   shellAuthRequired: (SEL)shellAuthRequired;

/// Starts the authentication check.
/// @param target - callback handler.
/// @param authCompleted - method that is called when the authentication process is complete.
/// @param shellAuthRequired - method that is called when the application needs to perform authorization.
/// The authentication check is required to be called every time the 
/// application is initialized. It will perform the proper amount of initialization 
/// based on the information that was saved.
/// Applications should call LoadsSettings method before calling this 
/// method, and should call SaveSettings in both of the handlers.
- (void)performAuthenticationCheck: (NSObject *)target
	authenticationCompleted: (SEL)authCompleted
		  shellAuthRequired: (SEL)shellAuthRequired;

//
// Saves settings to .settingsFileName.
// By default, writes to a file named "HVClient"
//
- (void)saveSettings;

/// Loads the last-saved configuration from isolated storage.
/// @param name - the filename to use.
- (void)loadSettings;

//
// Delete all provisioning state
//
-(void) reset;

-(void) applyEnvironmentSettings:(HVEnvironmentSettings *) settings;

@end
