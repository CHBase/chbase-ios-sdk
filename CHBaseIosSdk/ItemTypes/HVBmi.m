#import "HVCommon.h"
#import "HVClient.h"
#import "HVBmi.h"

static NSString* const c_typeid = @"E6C843CF-839A-4D79-A549-9C3B54A6B67C";
static NSString* const c_typename = @"bmi";

static NSString* const c_element_when = @"when";
static NSString* const c_element_height = @"height";
static NSString* const c_element_weight = @"weight";
static NSString* const c_element_value = @"value";

@implementation HVBmi
@synthesize when = m_when;
@synthesize height = m_height;
@synthesize weight = m_weight;
@synthesize value = m_value;

-(void)dealloc
{
    [m_when release];
    [m_height release];
    [m_weight release];
    [m_value release];
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
    HVSERIALIZE(m_height, c_element_height);
    HVSERIALIZE(m_weight, c_element_weight);
    HVSERIALIZE(m_value, c_element_value);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_when, c_element_when, HVDateTime);
    HVDESERIALIZE(m_height, c_element_height, HVLengthMeasurement);
    HVDESERIALIZE(m_weight, c_element_weight, HVWeightMeasurement);
    HVDESERIALIZE(m_value, c_element_value, HVBmiValue);
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
    return [[HVItem alloc] initWithType:[HVBmi typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Bmi", @"Bmi");
}

@end