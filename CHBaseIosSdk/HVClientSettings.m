//
//  HVClientSettings.m
//  HVLib
//


#import <UIKit/UIKit.h>
#import "HVCommon.h"
#import "HVClientSettings.h"
#import "HVNetworkReachability.h"

static NSString* const c_element_debug = @"debug";
static NSString* const c_element_appID = @"masterAppID";
static NSString* const c_element_appName = @"appName";
static NSString* const c_element_name = @"name";
static NSString* const c_element_friendlyName = @"friendlyName";
static NSString* const c_element_serviceUrl = @"serviceUrl";
static NSString* const c_element_shellUrl = @"shellUrl";
static NSString* const c_element_environment = @"environment";
static NSString* const c_element_appData = @"appData";
static NSString* const c_element_deviceName = @"deviceName";
static NSString* const c_element_country = @"country";
static NSString* const c_element_language = @"language";
static NSString* const c_element_signinTitle = @"signInTitle";
static NSString* const c_element_signinRetryMessage = @"signInRetryMessage";
static NSString* const c_element_httpTimeout = @"httpTimeout";
static NSString* const c_element_maxAttemptsPerRequest = @"maxAttemptsPerRequest";
static NSString* const c_element_useCachingInStore = @"useCachingInStore";
static NSString* const c_element_autoRequestDelay = @"autoRequestDelay";
static NSString* const c_element_multiInstance = @"isMultiInstanceAware";
static NSString* const c_element_instanceID = @"instanceID";

@implementation HVEnvironmentSettings

@synthesize name = m_name;
-(NSString *)name
{
    if ([NSString isNilOrEmpty:m_name])
    {
        self.name = @"PPE";
    }
    
    return m_name;
}

@synthesize friendlyName = m_friendlyName;
-(NSString *)friendlyName
{
    if ([NSString isNilOrEmpty:m_friendlyName])
    {
        self.friendlyName = @"CHBase Pre-Production";
    }
    
    return m_friendlyName;
}

@synthesize serviceUrl = m_serviceUrl;
-(NSURL *)serviceUrl
{
    if (!m_serviceUrl)
    {
        m_serviceUrl = [[NSURL alloc] initWithString:@"https://platform.healthvault-ppe.com/platform/wildcat.ashx"];
    }
    
    return m_serviceUrl;
}

@synthesize shellUrl = m_shellUrl;
-(NSURL *)shellUrl
{
    if (!m_shellUrl)
    {
        m_shellUrl = [[NSURL alloc] initWithString:@"https://account.healthvault-ppe.com"];
    }
    
    return m_shellUrl;
}

@synthesize instanceID = m_instanceID;
-(NSString *)instanceID
{
    if ([NSString isNilOrEmpty:m_instanceID])
    {
        return @"1";
    }
    
    return m_instanceID;
}

@synthesize appDataXml = m_appData;

-(BOOL)hasName
{
    return !([NSString isNilOrEmpty:m_name]);
}

-(BOOL)hasInstanceID
{
    return !([NSString isNilOrEmpty:m_instanceID]);
}

-(void)dealloc
{
    [m_name release];
    [m_friendlyName release];
    [m_serviceUrl release];
    [m_shellUrl release];
    [m_instanceID release];
    [m_appData release];
    
    [super dealloc];
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING(m_name, c_element_name);
    HVSERIALIZE_STRING(m_friendlyName, c_element_friendlyName);
    HVSERIALIZE_URL(m_serviceUrl, c_element_serviceUrl);
    HVSERIALIZE_URL(m_shellUrl, c_element_shellUrl);
    HVSERIALIZE_STRING(m_instanceID, c_element_instanceID);
    HVSERIALIZE_RAW(m_appData);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING(m_name, c_element_name);
    HVDESERIALIZE_STRING(m_friendlyName, c_element_friendlyName);
    HVDESERIALIZE_URL(m_serviceUrl, c_element_serviceUrl);
    HVDESERIALIZE_URL(m_shellUrl, c_element_shellUrl);
    HVDESERIALIZE_STRING(m_instanceID, c_element_instanceID);
    HVDESERIALIZE_RAW(m_appData, c_element_appData);
}

+(HVEnvironmentSettings *)fromInstance:(HVInstance *)instance
{
    HVCHECK_NOTNULL(instance);
    
    HVEnvironmentSettings* settings = [[[HVEnvironmentSettings alloc] init] autorelease];
    HVCHECK_NOTNULL(settings);
    
    settings.name = instance.name;
    settings.friendlyName = instance.name;
    settings.serviceUrl = [NSURL URLWithString:instance.platformUrl];
    settings.shellUrl = [NSURL URLWithString:instance.shellUrl];
    settings.instanceID = instance.instanceID;
    
    return settings;
    
LError:
    return nil;
}


-(BOOL)isServiceNetworkReachable
{
    return HVIsHostNetworkReachable(self.serviceUrl.host);
}

-(BOOL)isShellNetworkReachable
{
    return HVIsHostNetworkReachable(self.shellUrl.host);
}

@end

@implementation HVClientSettings

@synthesize debug = m_debug;
@synthesize masterAppID = m_appID;
@synthesize appName = m_appName;
@synthesize isMultiInstanceAware = m_isMultiInstanceAware;
@synthesize environments = m_environments;
@synthesize deviceName = m_deviceName;
@synthesize country = m_country;
@synthesize language = m_language;
@synthesize signInControllerTitle = m_signInTitle;
@synthesize signinRetryMessage = m_signInRetryMessage;
@synthesize httpTimeout = m_httpTimeout;
@synthesize maxAttemptsPerRequest = m_maxAttemptsPerRequest;
@synthesize useCachingInStore = m_useCachingInStore;
@synthesize autoRequestDelay = m_autoRequestDelay;
@synthesize appDataXml = m_appData;

-(NSArray *)environments
{
    if ([NSArray isNilOrEmpty:m_environments])
    {
        HVCLEAR(m_environments);
        
        NSMutableArray* defaultEnvironments = [[NSMutableArray alloc] init];
        m_environments = defaultEnvironments;

        HVEnvironmentSettings* defaultEnvironment = [[HVEnvironmentSettings alloc] init];
        [defaultEnvironments addObject:defaultEnvironment];
        [defaultEnvironment release];
    }
    
    return m_environments;
}

-(NSString *)deviceName
{
    if ([NSString isNilOrEmpty:m_deviceName])
    {
        m_deviceName = [[[UIDevice currentDevice] name] retain];
    }
    
    return m_deviceName;
}

-(NSString *)country
{
   if ([NSString isNilOrEmpty:m_country])
   {
       m_country = [[[NSLocale currentLocale] objectForKey: NSLocaleCountryCode] retain];
   }
    
    return m_country;
}

-(NSString *) language
{
    if ([NSString isNilOrEmpty:m_language])
    {
        m_language = [[[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode] retain];
    }
    
    return m_language;
}

-(NSString *)signInControllerTitle
{
    if ([NSString isNilOrEmpty:m_signInTitle])
    {
        m_signInTitle = [NSLocalizedString(@"CHBase", @"Sign in to CHBase") retain];
    }
    
    return m_signInTitle;
}

-(NSString *) signinRetryMessage
{
    if ([NSString isNilOrEmpty:m_signInRetryMessage])
    {
        m_signInRetryMessage = [NSLocalizedString(@"Could not sign into CHBase. Try again?", @"Retry signin message") retain];
    }
    
    return m_signInRetryMessage;
}

-(HVEnvironmentSettings *)firstEnvironment
{
    return [self.environments objectAtIndex:0];
}

@synthesize rootDirectoryPath = m_rootDirectoryPath;

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    m_debug = FALSE;
    m_isMultiInstanceAware = FALSE;
    m_httpTimeout = 60;             // Default timeout in seconds
    m_maxAttemptsPerRequest = 3;    // Retry thrice...
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_appID release];
    [m_appName release];
    [m_environments release];
    [m_deviceName release];
    [m_country release];
    [m_language release];
    
    [m_signInTitle release];
    [m_signInRetryMessage release];
    
    [m_appData release];
    [m_rootDirectoryPath release];
    
    [super dealloc];
}

-(void)validateSettings
{
    if ([NSString isNilOrEmpty:m_appID])
    {
        [HVClientException throwExceptionWithError:HVMAKE_ERROR(HVClientEror_InvalidMasterAppID)];
    }
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_BOOL(m_debug, c_element_debug);
    HVSERIALIZE_STRING(m_appID, c_element_appID);
    HVSERIALIZE_STRING(m_appName, c_element_appName);
    HVSERIALIZE_BOOL(m_isMultiInstanceAware, c_element_multiInstance);
    HVSERIALIZE_ARRAY(m_environments, c_element_environment);
    HVSERIALIZE_STRING(m_deviceName, c_element_deviceName);
    HVSERIALIZE_STRING(m_country, c_element_language);
    HVSERIALIZE_STRING(m_language, c_element_language);
    HVSERIALIZE_STRING(m_signInTitle, c_element_signinTitle);
    HVSERIALIZE_STRING(m_signInRetryMessage, c_element_signinRetryMessage);
    HVSERIALIZE_DOUBLE(m_httpTimeout, c_element_httpTimeout);
    HVSERIALIZE_INT(m_maxAttemptsPerRequest, c_element_maxAttemptsPerRequest);
    HVSERIALIZE_BOOL(m_useCachingInStore, c_element_useCachingInStore);
    HVSERIALIZE_DOUBLE(m_autoRequestDelay, c_element_autoRequestDelay);
    
    HVSERIALIZE_RAW(m_appData);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_BOOL(m_debug, c_element_debug);
    HVDESERIALIZE_STRING(m_appID, c_element_appID);
    HVDESERIALIZE_STRING(m_appName, c_element_appName);
    HVDESERIALIZE_BOOL(m_isMultiInstanceAware, c_element_multiInstance);
    
    NSMutableArray* environs = nil;
    HVDESERIALIZE_ARRAY(environs, c_element_environment, HVEnvironmentSettings);
    self.environments = environs;
    
    HVDESERIALIZE_STRING(m_deviceName, c_element_deviceName);
    HVDESERIALIZE_STRING(m_country, c_element_country);
    HVDESERIALIZE_STRING(m_language, c_element_language);
    HVDESERIALIZE_STRING(m_signInTitle, c_element_signinTitle);
    HVDESERIALIZE_STRING(m_signInRetryMessage, c_element_signinRetryMessage);
    HVDESERIALIZE_DOUBLE(m_httpTimeout, c_element_httpTimeout);
    HVDESERIALIZE_INT(m_maxAttemptsPerRequest, c_element_maxAttemptsPerRequest);
    HVDESERIALIZE_BOOL(m_useCachingInStore, c_element_useCachingInStore);
    HVDESERIALIZE_DOUBLE(m_autoRequestDelay, c_element_autoRequestDelay);
    
    HVDESERIALIZE_RAW(m_appData, c_element_appData);
}

-(HVEnvironmentSettings *)environmentWithName:(NSString *)name
{
    HVCHECK_NOTNULL(name);
    
    NSArray* environments = self.environments;
    for (NSUInteger i = 0, count = environments.count; i < count; ++i)
    {
        HVEnvironmentSettings* environment = [environments objectAtIndex:i];
        if (environment.hasName && [environment.name isEqualToStringCaseInsensitive:name])
        {
            return environment;
        }
    }
    
LError:
    return nil;
}

-(HVEnvironmentSettings *)environmentAtIndex:(NSUInteger)index
{
    return [m_environments objectAtIndex:index];
}

-(HVEnvironmentSettings *)environmentWithInstanceID:(NSString *)instanceID
{
    NSArray* environments = self.environments;
    for (NSUInteger i = 0, count = environments.count; i < count; ++i)
    {
        HVEnvironmentSettings* environment = [environments objectAtIndex:i];
        if (environment.hasInstanceID && [environment.instanceID isEqualToStringCaseInsensitive:instanceID])
        {
            return environment;
        }
    }
    
    return nil;
}

+(HVClientSettings *)newSettingsFromResource
{
    HVClientSettings* settings = (HVClientSettings *) [NSObject newFromResource:@"ClientSettings" withRoot:@"clientSettings" asClass:[HVClientSettings class]];
    
    if (!settings)
    {
        settings = [[HVClientSettings alloc] init];
    }
    
    return settings;
}

+(HVClientSettings *)newDefault
{
    HVClientSettings* settings = [HVClientSettings newSettingsFromResource];
    if (!settings)
    {
        settings = [[HVClientSettings alloc] init]; // Default settings
    }
    return settings;
}

@end
