//
//  HVSystemInstances.m
//  HVLib
//
//
//
//

#import "HVCommon.h"
#import "HVSystemInstances.h"

static const xmlChar* x_attribute_currentinstance = XMLSTRINGCONST("current-instance-id");
static NSString* const c_element_instance = @"instance";

@implementation HVSystemInstances

@synthesize currentInstanceID = m_currentInstanceID;
@synthesize instances = m_instances;

-(void)dealloc
{
    [m_currentInstanceID release];
    [m_instances release];
    [super dealloc];
}

-(void)deserializeAttributes:(XReader *)reader
{
    HVDESERIALIZE_ATTRIBUTE_X(m_currentInstanceID, x_attribute_currentinstance);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_TYPEDARRAY(m_instances, c_element_instance, HVInstance, HVInstanceCollection);
}

-(void)serializeAttributes:(XWriter *)writer
{
    HVSERIALIZE_ATTRIBUTE_X(m_currentInstanceID, x_attribute_currentinstance);    
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_ARRAY(m_instances, c_element_instance);
}

@end
