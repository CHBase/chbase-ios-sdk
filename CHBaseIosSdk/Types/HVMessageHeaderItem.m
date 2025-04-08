//
//  HVMessageHeaderItem.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVMessageHeaderItem.h"

static const xmlChar* x_element_name = XMLSTRINGCONST("name");
static const xmlChar* x_element_value = XMLSTRINGCONST("value");

@implementation HVMessageHeaderItem

@synthesize name = m_name;
@synthesize value = m_value;

-(id)initWithName:(NSString *)name value:(NSString *)value
{
    HVCHECK_STRING(name);
    HVCHECK_STRING(value);
    
    self = [super init];
    HVCHECK_SELF;
    
    HVRETAIN(m_name, name);
    HVRETAIN(m_value, value);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_name release];
    [m_value release];
    [super dealloc];
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE_STRING(m_name, HVClientError_InvalidMessageHeader);
    HVVALIDATE_STRING(m_value, HVClientError_InvalidMessageHeader);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING_X(m_name, x_element_name);
    HVSERIALIZE_STRING_X(m_value, x_element_value);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING_X(m_name, x_element_name);
    HVDESERIALIZE_STRING_X(m_value, x_element_value);
}

@end

@implementation HVMessageHeaderItemCollection

-(id) init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVMessageHeaderItem class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVMessageHeaderItem *)itemAtIndex:(NSUInteger)index
{
    return (HVMessageHeaderItem *) [self objectAtIndex:index];
}

-(NSUInteger)indexOfHeaderWithName:(NSString *)name
{
    for (NSUInteger i = 0, count = self.count; i < count; ++i)
    {
        HVMessageHeaderItem* header = [self itemAtIndex:i];
        if ([header.name isEqualToStringCaseInsensitive:name])
        {
            return i;
        }
    }
    
    return NSNotFound;
}

-(HVMessageHeaderItem *)headerWithName:(NSString *)name
{
    NSUInteger index = [self indexOfHeaderWithName:name];
    if (index != NSNotFound)
    {
        return [self itemAtIndex:index];
    }
    
    return nil;
}

@end

