#import "HVCommon.h"
#import "HVClient.h"
#import "HVAsthmaInhalerUsage.h"

static NSString* const c_typeid = @"03efe378-976a-42f8-ae1e-507c497a8c6d";
static NSString* const c_typename = @"asthma-inhaler-use";

static NSString* const c_element_when = @"when";
static NSString* const c_element_drug = @"drug";
static NSString* const c_element_strength = @"strength";
static NSString* const c_element_doseCount = @"dose-count";
static NSString* const c_element_deviceId = @"device-id";
static NSString* const c_element_dosePurpose = @"dose-purpose";

@implementation HVAsthmaInhalerUsage
@synthesize when = m_when;
@synthesize drug = m_drug;
@synthesize strength = m_strength;
@synthesize doseCount = m_doseCount;
@synthesize deviceId = m_deviceId;
@synthesize dosePurpose = m_dosePurpose;

-(void)dealloc
{
    [m_when release];
    [m_drug release];
    [m_strength release];
    [m_doseCount release];
    [m_deviceId release];
    [m_dosePurpose release];
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    HVVALIDATE_SUCCESS
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_when, c_element_when);
    HVSERIALIZE(m_drug, c_element_drug);
    HVSERIALIZE(m_strength, c_element_strength);
    HVSERIALIZE(m_doseCount, c_element_doseCount);
    HVSERIALIZE_STRING(m_deviceId, c_element_deviceId);
    HVSERIALIZE(m_dosePurpose, c_element_dosePurpose);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_when, c_element_when, HVDateTime);
    HVDESERIALIZE(m_drug, c_element_drug, HVCodableValue);
    HVDESERIALIZE(m_strength, c_element_strength, HVCodableValue);
    HVDESERIALIZE(m_doseCount, c_element_doseCount, HVNonNegativeInt);
    HVDESERIALIZE_STRING(m_deviceId, c_element_deviceId);
    HVDESERIALIZE(m_dosePurpose, c_element_dosePurpose, HVCodableValue);
}

+(NSString *)typeID
{
    return c_typeid;
}

+(NSString *) XRootElement
{
    return c_typename;
}

+(HVItem *) newItem
{
    return [[HVItem alloc] initWithType:[HVAsthmaInhalerUsage typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"AsthmaInhalerUsage", @"AsthmaInhalerUsage");
}

@end