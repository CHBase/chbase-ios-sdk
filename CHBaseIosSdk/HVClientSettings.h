//
//  HVClientSettings.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "XSerializableType.h"
#import "HVInstance.h"

//
// HVEnvironmentSettings is used by HVClientSettings (see below)
// 
@interface HVEnvironmentSettings : XSerializableType
{
    NSString* m_name;
    NSString* m_friendlyName;
    NSURL* m_serviceUrl;
    NSURL* m_shellUrl;
    NSString* m_instanceID;
    NSString* m_appData;
}

//
// In Xml, properties are in precisely this SEQUENCE
// The element name for each property is listed below
//

//
// <name>
// Optional Environment name
//
@property (readwrite, nonatomic, retain) NSString* name;
//
// <friendlyName>
// Optional. Friendly name for the environment.
//
@property (readwrite, nonatomic, retain) NSString* friendlyName;
//
// <serviceUrl>
// Optional. Url for HealthVault platform
//
@property (readwrite, nonatomic, retain) NSURL* serviceUrl;
//
// <shellUrl>
// Optional. Url for HealthVault Shell
//
@property (readwrite, nonatomic, retain) NSURL* shellUrl;
//
// <instanceID>
// Optional. Instance ID of the targeted HealthVault environment
//
@property (readwrite, nonatomic, retain) NSString* instanceID;
//
// <appData>
//  Optional. Can contain arbitrary Xml that you can use as you see fit
//  This property gets/set the OUTER Xml for the <appData> element
//
@property (readwrite, nonatomic, retain) NSString* appDataXml;

@property (readonly, nonatomic) BOOL hasName;
@property (readonly, nonatomic) BOOL hasInstanceID;

+(HVEnvironmentSettings *) fromInstance:(HVInstance *) instance;

//-------------------------
//
// Network reachability
//
//-------------------------
-(BOOL) isServiceNetworkReachable;
-(BOOL) isShellNetworkReachable;

@end

//-----------------
//
// Settings for HVClient.
//
// HVClient loads ClientSettings from an Xml resource file named ClientSettings.xml
// If not found, creates a default HVClientSettings that you can configure
//
//-----------------
@interface HVClientSettings : XSerializableType
{
    BOOL m_debug;
    NSString *m_appID;
    NSString *m_appName;
    BOOL m_isMultiInstanceAware;
    
    NSArray* m_environments;
    
    NSString *m_deviceName;
    NSString *m_country;
    NSString *m_language;
    
    NSString* m_signInTitle;
    NSString* m_signInRetryMessage;
    
    NSTimeInterval m_httpTimeout;
    NSInteger m_maxAttemptsPerRequest;
    BOOL m_useCachingInStore;
    
    NSTimeInterval m_autoRequestDelay;
    
    NSString* m_appData;
    NSURL* m_rootDirectoryPath;
}

// Begin PERSISTED PROPERTIES
//
// ClientSettings.xml contains properties in precisely this SEQUENCE
// The element name for each property is listed below
//
//
// <debug>
// Run in debug mode. Useful if you want to look at wire Xml in the debugger
// Default is false
//
@property (readwrite, nonatomic) BOOL debug;
//
// <masterAppID>
// Required. Master SODA appID
//
@property (readwrite, nonatomic, retain) NSString* masterAppID;
//
// <appName>
// Optional
@property (readwrite, nonatomic, retain) NSString* appName;
//
// <isMultiInstanceAware>
// Is this application globally available?. Default is false
//
@property (readwrite, nonatomic) BOOL isMultiInstanceAware;
//
// <environment>
// Service environments that this environment could run against.
// To create multiple environments, add multiple <enviromnent> elements in the Xml file
// Each <environment> element is of type HVEnvironmentSettings (see above).
//
@property (readwrite, nonatomic, retain) NSArray* environments;
//
// The name of this device...
// <deviceName>
// Default - uses the [[UIDevice device] name]
//
@property (readwrite, nonatomic, retain) NSString* deviceName;
//
// <country>
// If not specified, uses the current system configured country
//
@property (readwrite, nonatomic, retain) NSString* country;
//
// <language>
// If not specified, uses the current system configured language
//
@property (readwrite, nonatomic, retain) NSString* language;
//
// <signInTitle>
//
@property (readwrite, nonatomic, retain) NSString* signInControllerTitle;
@property (readwrite, nonatomic, retain) NSString* signinRetryMessage;
//
// <httpTimeout>
// Timeout for Http requests in seconds. Default is 60 seconds.
//
@property (readwrite, nonatomic) NSTimeInterval httpTimeout; // Standard timeout in seconds
//
// <maxAttemptsPerRequest>
// Set this to > 0 to automatically retry requests if they fail due to network errors
// Default is 3
//
@property (readwrite, nonatomic) NSInteger maxAttemptsPerRequest;
//
// <useCachingInStore>
// Used for HVTypeViews. If true, uses NSCache to cache HVItem* objects in memory
//
@property (readwrite, nonatomic) BOOL useCachingInStore;
//
// <autoRequestDelay>
// If > 0, will automatically delay each request... useful for faking "slow" networks
// Useful for debugging
//
@property (readwrite, nonatomic) NSTimeInterval autoRequestDelay;
//
// Get/Set the outXml for an <appData> element
// <appData> contain arbitray Xml that you can use as you see fit
//
@property (readwrite, nonatomic, retain) NSString* appDataXml;
//
// End PERSISTED PROPERTIES

@property (readonly, nonatomic) HVEnvironmentSettings* firstEnvironment;

@property (readwrite, nonatomic, retain) NSURL* rootDirectoryPath;

-(void) validateSettings;

-(HVEnvironmentSettings *) environmentWithName:(NSString *) name;
-(HVEnvironmentSettings *) environmentAtIndex:(NSUInteger) index;
-(HVEnvironmentSettings *) environmentWithInstanceID:(NSString *) instanceID;
//
// Load client settings from a resource file named ClientSettings.xml
//
+(HVClientSettings *) newSettingsFromResource;
+(HVClientSettings *) newDefault;

@end
