#import "HVCommon.h"
#import "HVClient.h"
#import "HVAdvanceDirectiveContactType.h"

static NSString* const c_element_name = @"name";
static NSString* const c_element_id = @"id";
static NSString* const c_element_contactInfo = @"contact-info";
static NSString* const c_element_relationship = @"relationship";
static NSString* const c_element_isPrimary = @"is-primary";

@implementation HVAdvanceDirectiveContactType
@synthesize name = m_name;
@synthesize id = m_id;
@synthesize contactInfo = m_contactInfo;
@synthesize relationship = m_relationship;
@synthesize isPrimary = m_isPrimary;

-(void)dealloc
{
    [m_name release];
    [m_id release];
    [m_contactInfo release];
    [m_relationship release];
    [m_isPrimary release];
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
    HVSERIALIZE(m_name, c_element_name);
    HVSERIALIZE_STRING(m_id, c_element_id);
    HVSERIALIZE(m_contactInfo, c_element_contactInfo);
    HVSERIALIZE(m_relationship, c_element_relationship);
    HVSERIALIZE(m_isPrimary, c_element_isPrimary);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_name, c_element_name, HVName);
    HVDESERIALIZE_STRING(m_id, c_element_id);
    HVDESERIALIZE(m_contactInfo, c_element_contactInfo, HVContact);
    HVDESERIALIZE(m_relationship, c_element_relationship, HVCodableValue);
    HVDESERIALIZE(m_isPrimary, c_element_isPrimary, HVBool);
}


@end


@implementation HVAdvanceDirectiveContactTypeCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVAdvanceDirectiveContactType class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)addItem:(HVAdvanceDirectiveContactType *)item
{
    [super addObject:item];
}

-(HVAdvanceDirectiveContactType *)itemAtIndex:(NSUInteger)index
{
    return [super objectAtIndex:index];
}

@end
