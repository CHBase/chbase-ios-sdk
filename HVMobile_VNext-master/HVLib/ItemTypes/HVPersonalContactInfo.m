//
//  HVPersonalContactInfo.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVPersonalContactInfo.h"

static NSString* const c_typeid = @"162dd12d-9859-4a66-b75f-96760d67072b";
static NSString* const c_typename = @"contact";

static NSString* const c_element_contact = @"contact";

@implementation HVPersonalContactInfo

@synthesize contact = m_contact;

-(void)dealloc
{
    [m_contact release];
    [super dealloc];
}

-(id)initWithContact:(HVContact *)contact
{
    HVCHECK_NOTNULL(contact);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.contact = contact;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}



-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_contact, HVClientError_InvalidPersonalContactInfo);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_contact, c_element_contact);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_contact, c_element_contact, HVContact);
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
    return [[HVItem alloc] initWithType:[HVPersonalContactInfo typeID]];
}

@end
