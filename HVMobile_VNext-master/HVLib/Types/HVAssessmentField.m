//
//  HVAssessmentField.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVAssessmentField.h"

static NSString* const c_element_name = @"name";
static NSString* const c_element_value = @"value";
static NSString* const c_element_group = @"group";

@implementation HVAssessmentField

@synthesize name = m_name;
@synthesize value = m_value;
@synthesize fieldGroup = m_group;

-(id)initWithName:(NSString *)name andValue:(NSString *)value
{
    return [self initWithName:name value:value andGroup:nil];
}

-(id)initWithName:(NSString *)name value:(NSString *)value andGroup:(NSString *)group
{
    self = [super init];
    HVCHECK_SELF;
    
    m_name = [[HVCodableValue alloc] initWithText:name];
    HVCHECK_NOTNULL(m_name);
    
    m_value = [[HVCodableValue alloc] initWithText:value];
    HVCHECK_NOTNULL(m_value);
    
    if (group)
    {
        m_group = [[HVCodableValue alloc] initWithText:group];
        HVCHECK_NOTNULL(m_group);
    }
        
    return self;
    
LError:
    HVALLOC_FAIL;
}

+(HVAssessmentField *)from:(NSString *)name andValue:(NSString *)value
{
    return [[[HVAssessmentField alloc] initWithName:name andValue:value] autorelease];
}

-(void)dealloc
{
    [m_name release];
    [m_value release];
    [m_group release];
    
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN

    HVVALIDATE(m_name, HVClientError_InvalidAssessmentField);
    HVVALIDATE(m_value, HVClientError_InvalidAssessmentField);
    HVVALIDATE_OPTIONAL(m_group);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_name, c_element_name);
    HVSERIALIZE(m_value, c_element_value);
    HVSERIALIZE(m_group, c_element_group);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_name, c_element_name, HVCodableValue);
    HVDESERIALIZE(m_value, c_element_value, HVCodableValue);
    HVDESERIALIZE(m_group, c_element_group, HVCodableValue);    
}

@end


@implementation HVAssessmentFieldCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVAssessmentField class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

@end