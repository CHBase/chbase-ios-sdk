#import "HVCommon.h"
#import "HVClient.h"
#import "HVAppSpecificInformation.h"

static NSString* const c_typeid = @"a5033c9d-08cf-4204-9bd3-cb412ce39fc0";
static NSString* const c_typename = @"app-specific";

static NSString* const c_element_formatAppid = @"format-appid";
static NSString* const c_element_formatTag = @"format-tag";
static NSString* const c_element_when = @"when";
static NSString* const c_element_summary = @"summary";

@implementation HVAppSpecificInformation
@synthesize formatAppid = m_formatAppid;
@synthesize formatTag = m_formatTag;
@synthesize when = m_when;
@synthesize summary = m_summary;
@synthesize xml = m_xml;

-(void)dealloc
{
    [m_formatAppid release];
    [m_formatTag release];
    [m_when release];
    [m_summary release];
    [m_xml release];
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
    HVSERIALIZE_STRING(m_formatAppid, c_element_formatAppid);
    HVSERIALIZE_STRING(m_formatTag, c_element_formatTag);
    HVSERIALIZE(m_when, c_element_when);
    HVSERIALIZE_STRING(m_summary, c_element_summary);
    HVSERIALIZE_RAW(m_xml);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING(m_formatAppid, c_element_formatAppid);
    HVDESERIALIZE_STRING(m_formatTag, c_element_formatTag);
    HVDESERIALIZE(m_when, c_element_when, HVDateTime);
    HVDESERIALIZE_STRING(m_summary, c_element_summary);
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
    return [[HVItem alloc] initWithType:[HVAppSpecificInformation typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"AppSpecificInformation", @"AppSpecificInformation");
}

@end
