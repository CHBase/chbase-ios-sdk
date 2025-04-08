//
//  HVVolumeValue.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVVolumeValue.h"

static const xmlChar* x_element_liters = XMLSTRINGCONST("liters");
static const xmlChar* x_element_displayValue = XMLSTRINGCONST("display");

@implementation HVVolumeValue

@synthesize liters = m_liters;
@synthesize displayValue = m_display;

-(double)litersValue
{
    return m_liters ? m_liters.value : NAN;
}

-(void)setLitersValue:(double)litersValue
{
    if (isnan(litersValue))
    {
        HVCLEAR(m_liters);
    }
    else
    {
        HVENSURE(m_liters, HVPositiveDouble);
        m_liters.value = litersValue;
    }
    
    [self updateDisplayText];
}

-(id)initWithLiters:(double)value
{
    self = [super init];
    HVCHECK_SELF;
    
    self.litersValue = value;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_liters release];
    [m_display release];
    [super dealloc];
}

-(BOOL) updateDisplayText
{
    HVCLEAR(m_display);
    if (!m_liters)
    {
        return FALSE;
    }
    
    m_display = [[HVDisplayValue alloc] initWithValue:m_liters.value andUnits:[HVVolumeValue volumeUnits]];
    
    return (m_display != nil);
}

-(NSString *)toString
{
    return [self toStringWithFormat:@"%.1f L"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    if (!m_liters)
    {
        return c_emptyString;
    }
    
    return [NSString localizedStringWithFormat:format, self.litersValue];
}

-(NSString *)description
{
    return [self toString];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_liters, HVClientError_InvalidVolume);
    HVVALIDATE_OPTIONAL(m_display);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_liters, x_element_liters);
    HVSERIALIZE_X(m_display, x_element_displayValue);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_liters, x_element_liters, HVPositiveDouble);
    HVDESERIALIZE_X(m_display, x_element_displayValue, HVDisplayValue);
}

+(NSString *)volumeUnits
{
    return NSLocalizedString(@"L", @"Liters");
}

@end
