//
//  HVVitalSignResult.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVVitalSignResult.h"

static NSString* const c_element_title = @"title";
static NSString* const c_element_value = @"value";
static NSString* const c_element_unit = @"unit";
static NSString* const c_element_refMin = @"reference-minimum";
static NSString* const c_element_refMax = @"reference-maximum";
static NSString* const c_element_textValue = @"text-value";
static NSString* const c_element_flag = @"flag";

@implementation HVVitalSignResult

@synthesize title = m_title;
@synthesize value = m_value;
@synthesize unit = m_unit;
@synthesize referenceMin = m_referenceMin;
@synthesize referenceMax = m_referenceMax;
@synthesize textValue = m_textValue;
@synthesize flag = m_flag;

-(id)initWithTitle:(HVCodableValue *)title value:(double)value andUnit:(NSString *)unit
{
    HVCHECK_NOTNULL(title);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.title = title;

    m_value = [[HVDouble alloc] initWith:value];
    HVCHECK_NOTNULL(m_value);
    
    if (unit)
    {
        m_unit = [[HVCodableValue alloc] initWithText:unit];
        HVCHECK_NOTNULL(m_unit);
    }
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(id)initWithTemperature:(double)value inCelsius:(BOOL)celsius
{
    HVCodableValue* title = [HVCodableValue fromText:@"Temperature" code:@"Tmp" andVocab:@"vital-statistics"];
    return [self initWithTitle:title value:value andUnit:(celsius) ? @"celsius" : @"fahrenheit"];
}

-(void)dealloc
{
    [m_title release];
    [m_value release];
    [m_unit release];
    [m_referenceMin release];
    [m_referenceMax release];
    [m_textValue release];
    [m_flag release];
    
    [super dealloc];
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    return [NSString stringWithFormat:@"%@, %@ %@", 
            (m_title) ? [m_title toString] : c_emptyString, 
            (m_value) ? [m_value toStringWithFormat:@"%.2f"] : c_emptyString, 
            (m_unit) ? [m_unit toString] : c_emptyString];
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_title, HVClientError_InvalidVitalSignResult);
    HVVALIDATE_OPTIONAL(m_value);
    HVVALIDATE_OPTIONAL(m_unit);
    HVVALIDATE_OPTIONAL(m_referenceMin);
    HVVALIDATE_OPTIONAL(m_referenceMax);
    HVVALIDATE_STRINGOPTIONAL(m_textValue, HVClientError_InvalidVitalSignResult);
    HVVALIDATE_OPTIONAL(m_flag);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_title, c_element_title);
    HVSERIALIZE(m_value, c_element_value);
    HVSERIALIZE(m_unit, c_element_unit);
    HVSERIALIZE(m_referenceMin, c_element_refMin);
    HVSERIALIZE(m_referenceMax, c_element_refMax);
    HVSERIALIZE_STRING(m_textValue, c_element_textValue);
    HVSERIALIZE(m_flag, c_element_flag);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_title, c_element_title, HVCodableValue);
    HVDESERIALIZE(m_value, c_element_value, HVDouble);
    HVDESERIALIZE(m_unit, c_element_unit, HVCodableValue);
    HVDESERIALIZE(m_referenceMin, c_element_refMin, HVDouble);
    HVDESERIALIZE(m_referenceMax, c_element_refMax, HVDouble);
    HVDESERIALIZE_STRING(m_textValue, c_element_textValue);
    HVDESERIALIZE(m_flag, c_element_flag, HVCodableValue);   
}

@end

@implementation HVVitalSignResultCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVVitalSignResult class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVVitalSignResult *)itemAtIndex:(NSUInteger)index
{
    return [self objectAtIndex:index];
}

@end