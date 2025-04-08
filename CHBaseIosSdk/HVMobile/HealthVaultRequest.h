//
//  HealthVaultRequest.h
//  CHBase Mobile Library for iOS
//
//

#import <Foundation/Foundation.h>
#import "HVService.h"

/// This class encapsulates the data that is contained in a request.
@interface HealthVaultRequest : NSObject {

	NSString *_methodName;
	float _methodVersion;
	NSString *_infoXml;
	NSString *_recordId;
	NSString *_personId;

	NSString *_authorizationSessionToken;
    NSString *_userAuthToken;
	NSString *_appIdInstance;
	NSString *_sessionSharedSecret;

	NSString *_language;
	NSString *_country;
	NSDate *_msgTime;
	int _msgTTL;

	NSObject *_userState;

	NSObject *_target;
	SEL _callBack;
    
    NSURLConnection* _connection;
    
    BOOL _isAnonymous;
    id<HealthVaultService> _service; // Weak reference
}

/// Gets or sets the name of the method to be called.
/// The method name and version must be one of the methods documented in the
/// method reference at:
/// http://developer.healthvault.com/pages/methods/methods.aspx
@property (retain) NSString *methodName;

/// Gets or sets the version of the method to be called.
/// The method name and version must be one of the methods documented in the
/// method reference at:
/// http://developer.healthvault.com/pages/methods/methods.aspx
@property (assign) float methodVersion;

/// Gets or sets the request-specific information.
@property (retain) NSString *infoXml;

/// Gets or sets the record id that will be used to perform request.
@property (retain) NSString *recordId;

/// Gets or sets the person id that will be used to perform request.
@property (retain) NSString *personId;

/// Gets or sets the authorization token that is required to talk to the HealthVault 
/// web service.
@property (retain) NSString *authorizationSessionToken;

@property (retain) NSString *userAuthToken;

/// Gets or sets the application instance id.
@property (retain) NSString *appIdInstance;

/// Gets or sets the session shared secret.
@property (retain) NSString *sessionSharedSecret;

// Gets or sets the language that is used for responses.
@property (retain) NSString *language;

/// Gets or sets the country that is used for responses.
@property (retain) NSString *country;

/// Gets or sets request msg-time parameter.
@property (retain) NSDate *msgTime;

/// Gets or sets request msg-ttl parameter.
@property (assign) int msgTTL;

/// Gets or sets the user state.
/// User state can be used by the caller to pass state to the handler.
@property (retain) NSObject *userState;

/// Gets or sets the callback handler.
@property (retain) NSObject *target;

/// Gets or sets the callback that will be called when the request has completed.
@property (assign) SEL callBack;

@property (retain) NSURLConnection* connection;

@property (readwrite) BOOL isAnonymous;
@property (readonly) BOOL hasSessionToken;
@property (readonly) BOOL hasUserAuthToken;
@property (readonly) BOOL hasCredentials;

/// Initializes a new instance of the HealthVaultRequest class.
/// @param name - the name of the method.
/// @param methodVersion - the version of the method.
/// @param infoSection - the request-specific xml to pass.
/// @param target - callback method owner.
/// @param callBack - the method to call when the request has completed.
///
/// The method name and version must be one of the methods documented in the
/// method reference at:
/// http://developer.healthvault.com/pages/methods/methods.aspx
- (id)initWithMethodName: (NSString *)name
		   methodVersion: (float)methodVersion
			 infoSection: (NSString *)info
				  target: (NSObject *)target
				callBack: (SEL)callBack;

/// Converts the request to xml representation ready to be submitted to HealthVault service.
/// @returns xml representation of the request.
- (NSString *)toXml __deprecated_msg("Use toXml:");
- (NSString *)toXml:(id<HealthVaultService>) service;

-(void) cancel;

-(void) writeHeader:(NSMutableString *) header forBody:(NSString *) body;
-(void) writeMethodHeaders:(NSMutableString *) header;
-(void) writeRecordHeaders:(NSMutableString *) header;
-(void) writeStandardHeaders:(NSMutableString *) header;
-(void) writeAuthSessionHeader:(NSMutableString *) header;
-(void) writeHashHeader:(NSMutableString *) header forBody:(NSString *) body;

-(void) writeAuth:(NSMutableString *) xml forHeader:(NSString *) header;

@end
