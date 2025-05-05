#import "HVCommon.h"
#import "HVClient.h"
#import "HVBodyDimension.h"

static NSString* const c_typeid = @"dd710b31-2b6f-45bd-9552-253562b9a7c1";
static NSString* const c_typename = @"body-dimension";

static NSString* const c_element_when = @"when";
static NSString* const c_element_measurementName = @"measurement-name";
static NSString* const c_element_value = @"value";

@implementation HVBodyDimension
@synthesize when = m_when;
@synthesize measurementName = m_measurementName;
@synthesize value = m_value;

-(void)dealloc
{
    [m_when release];
    [m_measurementName release];
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
    HVSERIALIZE(m_measurementName, c_element_measurementName);
    HVSERIALIZE(m_value, c_element_value);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_when, c_element_when, HVApproxDateTime);
    HVDESERIALIZE(m_measurementName, c_element_measurementName, HVCodableValue);
    HVDESERIALIZE(m_value, c_element_value, HVLengthMeasurement);
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
    return [[HVItem alloc] initWithType:[HVBodyDimension typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"BodyDimension", @"BodyDimension");
}

@end