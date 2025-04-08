//
//  HVOrganization.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVOrganization.h"

static NSString* const c_element_name = @"name";
static NSString* const c_element_contact = @"contact";
static NSString* const c_element_type = @"type";
static NSString* const c_element_site = @"website";

@implementation HVOrganization

@synthesize name = m_name;
@synthesize contact = m_contact;
@synthesize type = m_type;
@synthesize website = m_webSite;

-(void)dealloc
{
    [m_name release];
    [m_contact release];
    [m_type release];
    [m_webSite release];

    [super dealloc];
}

-(NSString *)toString
{
    return m_name;
}

-(NSString *)description
{
    return [self toString];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_STRING(m_name, HVClientError_InvalidOrganization);
    HVVALIDATE_OPTIONAL(m_contact);
    HVVALIDATE_OPTIONAL(m_type);
    HVVALIDATE_STRINGOPTIONAL(m_webSite, HVClientError_InvalidOrganization);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING(m_name, c_element_name);
    HVSERIALIZE(m_contact, c_element_contact);
    HVSERIALIZE(m_type, c_element_type);
    HVSERIALIZE_STRING(m_webSite, c_element_site);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING(m_name, c_element_name);
    HVDESERIALIZE(m_contact, c_element_contact, HVContact);
    HVDESERIALIZE(m_type, c_element_type, HVCodableValue);
    HVDESERIALIZE_STRING(m_webSite, c_element_site);  
}

@end
