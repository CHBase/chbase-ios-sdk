//
//  HVServiceDefinition.h
//  HVLib
//
//
//
//

#import "HVType.h"
#import "HVPlatformInfo.h"
#import "HVShellInfo.h"
#import "HVInstance.h"
#import "HVSystemInstances.h"

@interface HVServiceDefinition : HVType
{
@private
    HVPlatformInfo* m_platform;
    HVShellInfo* m_shell;
    HVSystemInstances* m_instances;
}

@property (readwrite, nonatomic, retain) HVPlatformInfo* platform;
@property (readwrite, nonatomic, retain) HVShellInfo* shell;
@property (readwrite, nonatomic, retain) HVSystemInstances* systemInstances;

@end

@interface HVServiceDefinitionParams : HVType
{
@private
    NSDate* m_updatedSince;
    HVStringCollection* m_sections;
}

@property (readwrite, nonatomic, retain) NSDate* updatedSince;
@property (readwrite, nonatomic, retain) HVStringCollection* sections;

@end