//
//  HVApproxMeasurement.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVApproxMeasurement.h"

static NSString* const c_element_display = @"display";
static NSString* const c_element_structured = @"structured";

@implementation HVApproxMeasurement

@synthesize displayText = m_display;
@synthesize measurement = m_measurement;

-(BOOL)hasMeasurement
{
    return (m_measurement != nil);
}

-(id)initWithDisplayText:(NSString *)text
{
    return [self initWithDisplayText:text andMeasurement:nil];
}

-(id)initWithDisplayText:(NSString *)text andMeasurement:(HVMeasurement *)measurement
{
    HVCHECK_STRING(text);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.displayText = text;
    
    if (measurement)
    {
        self.measurement = measurement;
    }
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_display release];
    [m_measurement release];
    [super dealloc];
}

+(HVApproxMeasurement *)fromDisplayText:(NSString *)text
{
    return [[[HVApproxMeasurement alloc] initWithDisplayText:text] autorelease];
}

+(HVApproxMeasurement *)fromDisplayText:(NSString *)text andMeasurement:(HVMeasurement *)measurement
{
    return [[[HVApproxMeasurement alloc] initWithDisplayText:text andMeasurement:measurement] autorelease];
}

+(HVApproxMeasurement *) fromValue:(double)value unitsText:(NSString *)unitsText unitsCode:(NSString *)code unitsVocab:(NSString *) vocab
{
    HVMeasurement* measurement = [HVMeasurement fromValue:value unitsDisplayText:unitsText unitsCode:code unitsVocab:vocab];
    HVCHECK_NOTNULL(measurement);
    
    NSString* displayText = [NSString localizedStringWithFormat:@"%g %@", value, unitsText];
    HVCHECK_NOTNULL(displayText);
    
    HVApproxMeasurement* approxMeasurement = [HVApproxMeasurement fromDisplayText:displayText andMeasurement:measurement];
    return approxMeasurement;
    
LError:
    return nil;
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    if (m_display)
    {
        return m_display;
    }
    
    if (m_measurement)
    {
        return [m_measurement toString];
    }
    
    return c_emptyString;    
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    if (m_measurement)
    {
        return [m_measurement toStringWithFormat:format];
    }
    
    return (m_display) ? m_display : c_emptyString;
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN

    HVVALIDATE_STRING(m_display, HVClientError_InvalidApproxMeasurement);
    HVVALIDATE_OPTIONAL(m_measurement);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING(m_display, c_element_display);
    HVSERIALIZE(m_measurement, c_element_structured);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING(m_display, c_element_display);
    HVDESERIALIZE(m_measurement, c_element_structured, HVMeasurement);
}

@end
