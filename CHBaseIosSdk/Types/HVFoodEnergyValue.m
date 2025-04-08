//
//  HVFoodEnergyValue.m
//  HVLib
//
//
//

#import "HVCommon.h"
#import "HVFoodEnergyValue.h"

static const xmlChar* x_element_calories = XMLSTRINGCONST("calories");
static const xmlChar* x_element_displayValue = XMLSTRINGCONST("display");

@implementation HVFoodEnergyValue

@synthesize calories = m_calories;
@synthesize displayValue = m_display;

-(double)caloriesValue
{
    return (m_calories) ? m_calories.value : NAN;
}

-(void)setCaloriesValue:(double)caloriesValue
{
    if (isnan(caloriesValue))
    {
        HVCLEAR(m_calories);
    }
    else 
    {
        HVENSURE(m_calories, HVNonNegativeDouble);
        m_calories.value = caloriesValue;
    }
    
    [self updateDisplayText];
}

-(id)initWithCalories:(double)value
{
    self = [super init];
    HVCHECK_SELF;
    
    self.caloriesValue = value;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_calories release];
    [m_display release];
    
    [super dealloc];
}

-(BOOL) updateDisplayText
{
    HVCLEAR(m_display);
    if (!m_calories)
    {
        return FALSE;
    }
    
    m_display = [[HVDisplayValue alloc] initWithValue:m_calories.value andUnits:[HVFoodEnergyValue calorieUnits]];
    
    return (m_display != nil);
}

-(NSString *)toString
{
    return [self toStringWithFormat:@"%.0f cal"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    if (!m_calories)
    {
        return c_emptyString;
    }
    
    return [NSString localizedStringWithFormat:format, self.caloriesValue];
}

+(NSString *)calorieUnits
{
    return NSLocalizedString(@"cal", @"Calorie units");
}

-(NSString *)description
{
    return [self toString];
}


-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_calories, HVClientError_InvalidDietaryIntake);
    HVVALIDATE_OPTIONAL(m_display);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_calories, x_element_calories);
    HVSERIALIZE_X(m_display, x_element_displayValue);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_calories, x_element_calories, HVNonNegativeDouble);
    HVDESERIALIZE_X(m_display, x_element_displayValue, HVDisplayValue);
}

+(HVFoodEnergyValue *)fromCalories:(double)value
{
    return [[[HVFoodEnergyValue alloc] initWithCalories:value] autorelease];
}

@end
