//
//  HVPlatformInfo.h
//  HVLib
//
//
//

#import "HVType.h"
#import "HVConfigurationEntry.h"
#import "HVCollection.h"

@interface HVPlatformInfo : HVType
{
@private
    NSString* m_url;
    NSString* m_version;
    HVConfigurationEntryCollection* m_config;
}

@property (readwrite, nonatomic, retain) NSString* url;
@property (readwrite, nonatomic, retain) NSString* version;
@property (readwrite, nonatomic, retain) HVConfigurationEntryCollection* config;

@end
