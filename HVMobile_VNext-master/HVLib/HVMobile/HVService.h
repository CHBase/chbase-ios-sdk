//
//  HVService.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVHttpTransport.h"
#import "HVCryptographer.h"
#import "Provisioner.h"
#import "HealthVaultRecord.h"
#import "HVClientSettings.h"

@class HealthVaultRequest;

@protocol HealthVaultService <NSObject>

@property (retain) NSString *healthServiceUrl;
@property (retain) NSString *shellUrl;
@property (retain) NSString *authorizationSessionToken;
@property (retain) NSString *sharedSecret;
@property (retain) NSString *sessionSharedSecret;
@property (retain) NSString *masterAppId;
@property (retain) NSString *language;
@property (retain) NSString *country;
@property (retain) NSString* deviceName;
@property (retain) NSString *appIdInstance;
@property (retain) NSString *applicationCreationToken;
@property (retain) NSMutableArray *records;
@property (retain) HealthVaultRecord *currentRecord;
@property (readonly) BOOL isAppCreated;

@property (retain) id<HVHttpTransport> transport;
@property (retain) id<HVCryptographer> cryptographer;
@property (retain) Provisioner* provisioner;

- (NSString *)getApplicationCreationUrl;
- (NSString *)getApplicationCreationUrlGA; // HealthVault global architecture aware
- (NSString *)getUserAuthorizationUrl;

- (void)sendRequest:(HealthVaultRequest *)request;
- (void)authorizeRecords: (NSObject *)target authenticationCompleted: (SEL)authCompleted shellAuthRequired: (SEL)shellAuthRequired;

- (void)performAuthenticationCheck: (NSObject *)target authenticationCompleted: (SEL)authCompleted shellAuthRequired: (SEL)shellAuthRequired;

- (void)saveSettings;
- (void)loadSettings;

-(void) reset;
-(void) applyEnvironmentSettings:(HVEnvironmentSettings *) settings;

@end
