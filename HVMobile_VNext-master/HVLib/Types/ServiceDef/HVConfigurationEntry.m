//
//  HVConfigurationEntry.m
//  HVLib
//
//
//

#import "HVCommon.h"
#import "HVConfigurationEntry.h"

static const xmlChar* x_attribute_key = XMLSTRINGCONST("key");

@implementation HVConfigurationEntry

@synthesize key = m_key;
@synthesize value = m_value;

-(void)dealloc
{
    [m_key release];
    [m_value release];
    [super dealloc];
}

-(void)deserializeAttributes:(XReader *)reader
{
    HVDESERIALIZE_ATTRIBUTE_X(m_key, x_attribute_key);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_TEXT(m_value);
}

-(void)serializeAttributes:(XWriter *)writer
{
    HVSERIALIZE_ATTRIBUTE_X(m_key, x_attribute_key);
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_TEXT(m_value);
}

@end

@implementation HVConfigurationEntryCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVConfigurationEntry class];
            
    return self;
    
LError:
    HVALLOC_FAIL;
}

@end
