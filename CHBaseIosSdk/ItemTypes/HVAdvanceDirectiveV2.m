#import "HVCommon.h"
#import "HVClient.h"
#import "HVAdvanceDirectiveV2.h"

static NSString* const c_typeid = @"0E17BE0F-4423-4220-A110-E879074CBFE0";
static NSString* const c_typename = @"advance-directive-v2";

static NSString* const c_element_when = @"when";
static NSString* const c_element_name = @"name";
static const xmlChar* x_element_contact = XMLSTRINGCONST("contact");

static NSString* const c_element_contact = @"contact";

@implementation HVAdvanceDirectiveV2
@synthesize when = m_when;
@synthesize name = m_name;
@synthesize contact = m_contact;

-(void)dealloc
{
    [m_when release];
    [m_name release];
    [m_contact release];
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
    HVSERIALIZE_STRING(m_name, c_element_name);
    HVSERIALIZE_ARRAY(m_contact, c_element_contact);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_when, c_element_when, HVDateTime);
    HVDESERIALIZE_STRING(m_name, c_element_name);
    HVDESERIALIZE_TYPEDARRAY_X(m_contact, x_element_contact, HVAdvanceDirectiveContactType,HVAdvanceDirectiveContactTypeCollection);
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
    return [[HVItem alloc] initWithType:[HVAdvanceDirectiveV2 typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"AdvanceDirectiveV2", @"AdvanceDirectiveV2");
}

@end
