//
//  HVInstance.m
//  HVLib
//
//
//
//

#import "HVCommon.h"
#import "HVInstance.h"

static const xmlChar* x_element_id = XMLSTRINGCONST("id");
static const xmlChar* x_element_name = XMLSTRINGCONST("name");
static const xmlChar* x_element_description = XMLSTRINGCONST("description");
static const xmlChar* x_element_platform = XMLSTRINGCONST("platform-url");
static const xmlChar* x_element_shell = XMLSTRINGCONST("shell-url");

@implementation HVInstance

@synthesize instanceID = m_id;
@synthesize name = m_name;
@synthesize instanceDescription = m_description;
@synthesize platformUrl = m_platformUrl;
@synthesize shellUrl = m_shellUrl;

-(void)dealloc
{
    [m_id release];
    [m_name release];
    [m_description release];
    [m_platformUrl release];
    [m_shellUrl release];
    
    [super dealloc];
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING_X(m_id, x_element_id);
    HVDESERIALIZE_STRING_X(m_name, x_element_name);
    HVDESERIALIZE_STRING_X(m_description, x_element_description);
    HVDESERIALIZE_STRING_X(m_platformUrl, x_element_platform);
    HVDESERIALIZE_STRING_X(m_shellUrl, x_element_shell);
}


-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING_X(m_id, x_element_id);
    HVSERIALIZE_STRING_X(m_name, x_element_name);
    HVSERIALIZE_STRING_X(m_description, x_element_description);
    HVSERIALIZE_STRING_X(m_platformUrl, x_element_platform);
    HVSERIALIZE_STRING_X(m_shellUrl, x_element_shell);
}

@end

@implementation HVInstanceCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVInstance class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVInstance *)indexOfInstance:(NSUInteger)index
{
    return (HVInstance *) [self objectAtIndex:index];
}

-(NSInteger) indexOfInstanceNamed:(NSString *)name
{
    return [self indexOfMatchingObject:^BOOL(id value) {
        return [((HVInstance *) value).name isEqualToString:name];
    }];
}

-(NSInteger) indexOfInstanceWithID:(NSString *)instanceID
{
    return [self indexOfMatchingObject:^BOOL(id value) {
        return [((HVInstance *) value).instanceID isEqualToString:instanceID];
    }];
}

@end
