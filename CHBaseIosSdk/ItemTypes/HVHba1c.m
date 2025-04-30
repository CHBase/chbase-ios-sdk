#import "HVCommon.h"
#import "HVClient.h"
#import "HVHba1c.h"

static NSString* const c_typeid = @"62160199-b80f-4905-a55a-ac4ba825ceae";
static NSString* const c_typename = @"HbA1C";

static NSString* const c_element_when = @"when";
static NSString* const c_element_value = @"value";
static NSString* const c_element_hba1cAssayMethod = @"HbA1C-assay-method";
static NSString* const c_element_deviceId = @"device-id";

@implementation HVHba1c
@synthesize when = m_when;
@synthesize value = m_value;
@synthesize hba1cAssayMethod = m_hba1cAssayMethod;
@synthesize deviceId = m_deviceId;

-(void)dealloc
{
    [m_when release];
    [m_value release];
    [m_hba1cAssayMethod release];
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
    HVSERIALIZE(m_value, c_element_value);
    HVSERIALIZE(m_hba1cAssayMethod, c_element_hba1cAssayMethod);
    HVSERIALIZE_STRING(m_deviceId, c_element_deviceId);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_when, c_element_when, HVDateTime);
    HVDESERIALIZE(m_value, c_element_value, HVHbA1CValue);
    HVDESERIALIZE(m_hba1cAssayMethod, c_element_hba1cAssayMethod, HVCodableValue);
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
    return [[HVItem alloc] initWithType:[HVHba1c typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Hba1c", @"Hba1c");
}

@end