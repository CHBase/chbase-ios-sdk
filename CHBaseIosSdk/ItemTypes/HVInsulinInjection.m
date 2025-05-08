#import "HVCommon.h"
#import "HVClient.h"
#import "HVInsulinInjection.h"

static NSString* const c_typeid = @"3B3C053B-B1FE-4E11-9E22-D4B480DE74E8";
static NSString* const c_typename = @"insulin-injection";

static NSString* const c_element_type = @"type";
static NSString* const c_element_amount = @"amount";
static NSString* const c_element_deviceId = @"device-id";

@implementation HVInsulinInjection
@synthesize insulinType = m_type;
@synthesize amount = m_amount;
@synthesize deviceId = m_deviceId;

-(void)dealloc
{
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
    HVSERIALIZE(m_type, c_element_type);
    HVSERIALIZE(m_amount, c_element_amount);
    HVSERIALIZE_STRING(m_deviceId, c_element_deviceId);
}

-(void)deserialize:(XReader *)reader
{
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
    return [[HVItem alloc] initWithType:[HVInsulinInjection typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"InsulinInjection", @"InsulinInjection");
}

@end
