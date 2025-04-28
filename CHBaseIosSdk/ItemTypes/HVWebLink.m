#import "HVCommon.h"
#import "HVClient.h"
#import "HVWebLink.h"

static NSString* const c_typeid = @"d4b48e6b-50fa-4ba8-ac73-7d64a68dc328";
static NSString* const c_typename = @"link";

static NSString* const c_element_url = @"url";
static NSString* const c_element_title = @"title";

@implementation HVWebLink
@synthesize url = m_url;
@synthesize title = m_title;

-(void)dealloc
{
    [m_url release];
    [m_title release];
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
    HVSERIALIZE_STRING(m_url, c_element_url);
    HVSERIALIZE_STRING(m_title, c_element_title);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING(m_url, c_element_url);
    HVDESERIALIZE_STRING(m_title, c_element_title);
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
    return [[HVItem alloc] initWithType:[HVWebLink typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"WebLink", @"WebLink");
}

@end