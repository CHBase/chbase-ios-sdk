#import "HVCommon.h"
#import "HVClient.h"
#import "HVBloodOxygenSaturation.h"

static NSString* const c_typeid = @"3a54f95f-03d8-4f62-815f-f691fc94a500";
static NSString* const c_typename = @"blood-oxygen-saturation";

static NSString* const c_element_when = @"when";
static NSString* const c_element_value = @"value";
static NSString* const c_element_measurementMethod = @"measurement-method";
static NSString* const c_element_measurementFlags = @"measurement-flags";

@implementation HVBloodOxygenSaturation
@synthesize when = m_when;
@synthesize value = m_value;
@synthesize measurementMethod = m_measurementMethod;
@synthesize measurementFlags = m_measurementFlags;

-(void)dealloc
{
    [m_when release];
    [m_value release];
    [m_measurementMethod release];
    [m_measurementFlags release];
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
    HVSERIALIZE(m_value, c_element_value);
    HVSERIALIZE(m_measurementMethod, c_element_measurementMethod);
    HVSERIALIZE(m_measurementFlags, c_element_measurementFlags);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_when, c_element_when, HVDateTime);
    HVDESERIALIZE(m_value, c_element_value,HVNonNegativeDouble);
    HVDESERIALIZE(m_measurementMethod, c_element_measurementMethod, HVCodableValue);
    HVDESERIALIZE(m_measurementFlags, c_element_measurementFlags, HVCodableValue);
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
    return [[HVItem alloc] initWithType:[HVBloodOxygenSaturation typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"BloodOxygenSaturation", @"BloodOxygenSaturation");
}

@end