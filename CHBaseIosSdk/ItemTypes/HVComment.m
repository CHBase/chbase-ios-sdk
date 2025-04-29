#import "HVCommon.h"
#import "HVClient.h"
#import "HVComment.h"

static NSString* const c_typeid = @"9f4e0fcd-10d7-416d-855a-90514ce2016b";
static NSString* const c_typename = @"comment";

static NSString* const c_element_when = @"when";
static NSString* const c_element_content = @"content";
static NSString* const c_element_category = @"category";

@implementation HVComment
@synthesize when = m_when;
@synthesize content = m_content;
@synthesize category = m_category;

-(void)dealloc
{
    [m_when release];
    [m_content release];
    [m_category release];
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
    HVSERIALIZE_STRING(m_content, c_element_content);
    HVSERIALIZE(m_category, c_element_category);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_when, c_element_when, HVApproxDateTime);
    HVDESERIALIZE_STRING(m_content, c_element_content);
    HVDESERIALIZE(m_category, c_element_category, HVCodableValue);
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
    return [[HVItem alloc] initWithType:[HVComment typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Comment", @"Comment");
}

@end