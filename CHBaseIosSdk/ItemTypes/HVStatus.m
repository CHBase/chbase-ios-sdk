#import "HVCommon.h"
#import "HVClient.h"
#import "HVStatus.h"

static NSString* const c_typeid = @"d33a32b2-00de-43b8-9f2a-c4c7e9f580ec";
static NSString* const c_typename = @"status";

static NSString* const c_element_statusType = @"status-type";
static NSString* const c_element_text = @"text";

@implementation HVStatus
@synthesize statusType = m_statusType;
@synthesize text = m_text;

-(void)dealloc
{
    [m_statusType release];
    [m_text release];
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
    HVSERIALIZE(m_statusType, c_element_statusType);
    HVSERIALIZE_STRING(m_text, c_element_text);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_statusType, c_element_statusType, HVCodableValue);
    HVDESERIALIZE_STRING(m_text, c_element_text);
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
    return [[HVItem alloc] initWithType:[HVStatus typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Status", @"Status");
}

@end