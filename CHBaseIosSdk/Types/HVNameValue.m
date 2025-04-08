//
//  HVNameValue.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVNameValue.h"

static NSString* const c_element_name = @"name";
static NSString* const c_element_value = @"value";

@implementation HVNameValue

@synthesize name = m_name;
@synthesize value = m_value;

-(double)measurementValue
{
    return (m_value) ? m_value.value : NAN;
}

-(void)setMeasurementValue:(double)measurementValue
{
    HVENSURE(m_value, HVMeasurement);
    m_value.value = measurementValue;
}

-(id)initWithName:(HVCodedValue *)name andValue:(HVMeasurement *)value
{
    HVCHECK_NOTNULL(name);
    HVCHECK_NOTNULL(value);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.name = name;
    self.value = value;
    
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

+(HVNameValue *)fromName:(HVCodedValue *)name andValue:(HVMeasurement *)value
{
    return [[[HVNameValue alloc] initWithName:name andValue:value] autorelease];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_name, HVClientError_InvalidNameValue);
    HVVALIDATE(m_value, HVClientError_InvalidNameValue);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;      
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_name, c_element_name);
    HVSERIALIZE(m_value, c_element_value);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_name, c_element_name, HVCodedValue);
    HVDESERIALIZE(m_value, c_element_value, HVMeasurement);
}

@end

@implementation HVNameValueCollection

-(id) init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVNameValue class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVNameValue *)itemAtIndex:(NSUInteger)index
{
    return (HVNameValue *) [self objectAtIndex:index];
}

-(NSUInteger)indexOfItemWithName:(HVCodedValue *)code
{
    for (NSUInteger i = 0, count = self.count; i < count; ++i)
    {
        if ([[self itemAtIndex:i].name isEqualToCodedValue:code])
        {
            return i;
        }
     }     
    
    return NSNotFound;
}

-(NSUInteger)indexOfItemWithNameCode:(NSString *)nameCode
{
    for (NSUInteger i = 0, count = self.count; i < count; ++i)
    {
        if ([[self itemAtIndex:i].name.code isEqualToString:nameCode])
        {
            return i;
        }
    }     
    
    return NSNotFound;   
}

-(HVNameValue *)getItemWithNameCode:(NSString *)nameCode
{
    NSUInteger index = [self indexOfItemWithNameCode:nameCode];
    if (index == NSNotFound)
    {
        return nil;
    }
    
    return [self itemAtIndex:index];
}

-(void)addOrUpdate:(HVNameValue *)value
{
    NSUInteger indexOf = [self indexOfItemWithName:value.name];
    if (indexOf != NSNotFound)
    {
        [self replaceObjectAtIndex:indexOf withObject:value];
    }
    else
    {
        [super addObject:value];
    }
}

@end