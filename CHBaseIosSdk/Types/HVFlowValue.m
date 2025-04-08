//
//  HVFlowValue.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVFlowValue.h"

static const xmlChar* x_element_litersPerSecond = XMLSTRINGCONST("liters-per-second");
static const xmlChar* x_element_displayValue = XMLSTRINGCONST("display");

@implementation HVFlowValue

@synthesize litersPerSecond = m_litersPerSecond;
@synthesize displayValue = m_display;

-(double)litersPerSecondValue
{
    return m_litersPerSecond ? m_litersPerSecond.value : NAN;
}

-(void)setLitersPerSecondValue:(double)litersPerSecondValue
{
    if (isnan(litersPerSecondValue))
    {
        HVCLEAR(m_litersPerSecond);
    }
    else
    {
        HVENSURE(m_litersPerSecond, HVPositiveDouble);
        m_litersPerSecond.value = litersPerSecondValue;
    }
    
    [self updateDisplayText];
}

-(id)initWithLitersPerSecond:(double)value
{
    self = [super init];
    HVCHECK_SELF;
    
    self.litersPerSecondValue = value;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_litersPerSecond release];
    [m_display release];
    [super dealloc];
}

-(BOOL) updateDisplayText
{
    HVCLEAR(m_display);
    if (!m_litersPerSecond)
    {
        return FALSE;
    }
    
    m_display = [[HVDisplayValue alloc] initWithValue:m_litersPerSecond.value andUnits:[HVFlowValue flowUnits]];
    
    return (m_display != nil);
}

-(NSString *)toString
{
    return [self toStringWithFormat:@"%.1f L/s"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    if (!m_litersPerSecond)
    {
        return c_emptyString;
    }
    
    return [NSString localizedStringWithFormat:format, self.litersPerSecondValue];
}

-(NSString *)description
{
    return [self toString];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_litersPerSecond, HVClientError_InvalidFlow);
    HVVALIDATE_OPTIONAL(m_display);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_litersPerSecond, x_element_litersPerSecond);
    HVSERIALIZE_X(m_display, x_element_displayValue);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_litersPerSecond, x_element_litersPerSecond, HVPositiveDouble);
    HVDESERIALIZE_X(m_display, x_element_displayValue, HVDisplayValue);
}

+(NSString *)flowUnits
{
    return NSLocalizedString(@"L/s", @"Liters per second");
}

@end
