#import "HVCommon.h"
#import "HVClient.h"
#import "HVInsulinInjectionUsage.h"

static NSString* const c_typeid = @"184166BE-8ADB-4D9C-8162-C403040E31AD";
static NSString* const c_typename = @"diabetes-insulin-injection-use";

static NSString* const c_element_when = @"when";
static NSString* const c_element_type = @"type";
static NSString* const c_element_amount = @"amount";
static NSString* const c_element_deviceId = @"device-id";

@implementation HVInsulinInjectionUsage
@synthesize when = m_when;
@synthesize insulinType = m_type;
@synthesize amount = m_amount;
@synthesize deviceId = m_deviceId;

-(void)dealloc
{
    [m_when release];
    [m_type release];
    [m_amount release];
    [m_deviceId release];
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
    HVSERIALIZE(m_type, c_element_type);
    HVSERIALIZE(m_amount, c_element_amount);
    HVSERIALIZE_STRING(m_deviceId, c_element_deviceId);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_when, c_element_when, HVDateTime);
    HVDESERIALIZE(m_type, c_element_type, HVCodableValue);
    HVDESERIALIZE(m_amount, c_element_amount, HVInsulinInjectionValue);
    HVDESERIALIZE_STRING(m_deviceId, c_element_deviceId);
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
    return [[HVItem alloc] initWithType:[HVInsulinInjectionUsage typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"InsulinInjectionUsage", @"InsulinInjectionUsage");
}

@end
