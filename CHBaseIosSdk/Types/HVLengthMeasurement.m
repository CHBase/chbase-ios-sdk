//
//  HVLengthMeasurement.m
//  HVLib
//
//


#import "HVCommon.h"
#import "HVLengthMeasurement.h"

static const xmlChar* x_element_meters = XMLSTRINGCONST("m");
static const xmlChar* x_element_display = XMLSTRINGCONST("display");

@implementation HVLengthMeasurement

@synthesize value = m_meters;
@synthesize display = m_display;

-(double)inMeters
{
    return (m_meters) ? m_meters.value : NAN;
}

-(void)setInMeters:(double)meters
{
    HVENSURE(m_meters, HVPositiveDouble);
    m_meters.value = meters;
    [self updateDisplayValue:meters units:@"meters" andUnitsCode:@"m"];
}

-(double)inCentimeters
{
    return self.inMeters * 100;
}

-(void)setInCentimeters:(double)inCentimeters
{
    HVENSURE(m_meters, HVPositiveDouble);
    m_meters.value = inCentimeters / 100;
    [self updateDisplayValue:inCentimeters units:@"centimeters" andUnitsCode:@"cm"];
}

-(double)inKilometers
{
    return self.inMeters / 1000;
}

-(void)setInKilometers:(double)inKilometers
{
    HVENSURE(m_meters, HVPositiveDouble);
    m_meters.value = inKilometers * 1000;
    [self updateDisplayValue:inKilometers units:@"kilometers" andUnitsCode:@"km"];
}

-(double) inInches
{
    return (m_meters) ? [HVLengthMeasurement metersToInches:m_meters.value] : NAN;
}

-(void)setInInches:(double)inches
{
    HVENSURE(m_meters, HVPositiveDouble);
    m_meters.value = [HVLengthMeasurement inchesToMeters:inches];
    [self updateDisplayValue:inches units:@"inches" andUnitsCode:@"in"];
}

-(double)inFeet
{
    return self.inInches / 12;
}

-(void)setInFeet:(double)inFeet
{
    HVENSURE(m_meters, HVPositiveDouble);
    m_meters.value = [HVLengthMeasurement inchesToMeters:inFeet * 12];
    [self updateDisplayValue:inFeet units:@"feet" andUnitsCode:@"ft"];    
}

-(double)inMiles
{
    return self.inFeet / 5280;
}

-(void)setInMiles:(double)inMiles
{
    HVENSURE(m_meters, HVPositiveDouble);
    m_meters.value = [HVLengthMeasurement inchesToMeters:inMiles * 5280 * 12];
    [self updateDisplayValue:inMiles units:@"miles" andUnitsCode:@"mi"];        
}

-(void)dealloc
{
    [m_meters release];
    [m_display release];
    [super dealloc];
}

-(id)initWithInches:(double)inches
{
    self = [super init];
    HVCHECK_SELF;
    
    self.inInches = inches;
    HVCHECK_NOTNULL(m_meters);
    HVCHECK_NOTNULL(m_display);
    
    return self;
LError:
    HVALLOC_FAIL;    
}

-(id)initWithMeters:(double)meters
{
    self = [super init];
    HVCHECK_SELF;
    
    self.inMeters = meters;
    HVCHECK_NOTNULL(m_meters);
    HVCHECK_NOTNULL(m_display);
    
    return self;
LError:
    HVALLOC_FAIL;
}

-(BOOL) updateDisplayValue:(double)displayValue units:(NSString *)unitValue andUnitsCode:(NSString *)code
{
    HVDisplayValue *newValue = [[HVDisplayValue alloc] initWithValue:displayValue andUnits:unitValue];
    HVCHECK_NOTNULL(newValue);
    if (code)
    {
        newValue.unitsCode = code;
    }

    HVASSIGN(m_display, newValue);
    
    return TRUE;
    
LError:
    return FALSE;
}

-(NSString *)toString
{
    return [self stringInMeters:@"%.2f m"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.inMeters];
}

-(NSString *)stringInCentimeters:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.inCentimeters];    
}

-(NSString *)stringInMeters:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.inMeters];
}

-(NSString *)stringInKilometers:(NSString *)format  
{
    return [NSString localizedStringWithFormat:format, self.inKilometers];    
}

-(NSString *) stringInInches:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.inInches];
}

-(NSString *)stringInFeetAndInches:(NSString *)format
{
    long totalInches = (long) round(self.inInches);
    long feet = totalInches / 12;
    long inches = totalInches % 12;
    
    return [NSString localizedStringWithFormat:format, feet, inches];
}

-(NSString *)stringInMiles:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.inMiles];        
}

+(HVLengthMeasurement *)fromMiles:(double)value
{
    HVLengthMeasurement* length = [[[HVLengthMeasurement alloc] init] autorelease];
    length.inMiles = value;
    return length;
}

+(HVLengthMeasurement *)fromInches:(double)value
{
    HVLengthMeasurement* length = [[[HVLengthMeasurement alloc] init] autorelease];
    length.inInches = value;
    return length;    
}

+(HVLengthMeasurement *)fromKilometers:(double)value
{
    HVLengthMeasurement* length = [[[HVLengthMeasurement alloc] init] autorelease];
    length.inKilometers = value;
    return length;    
}

+(HVLengthMeasurement *)fromMeters:(double)value
{
    HVLengthMeasurement* length = [[[HVLengthMeasurement alloc] init] autorelease];
    length.inMeters = value;
    return length;    
}

+(HVLengthMeasurement *)fromCentimeters:(double)value
{
    HVLengthMeasurement* length = [[[HVLengthMeasurement alloc] init] autorelease];
    length.inCentimeters = value;
    return length;    
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_meters, HVClientError_InvalidLengthMeasurement);
    HVVALIDATE_OPTIONAL(m_display);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_meters, x_element_meters);
    HVSERIALIZE_X(m_display, x_element_display);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_meters, x_element_meters, HVPositiveDouble);
    HVDESERIALIZE_X(m_display, x_element_display, HVDisplayValue);
}

+(double)centimetersToInches:(double)cm
{
    return cm * 0.3937;
}

+(double)inchesToCentimeters:(double)cm
{
    return cm * 2.54;
}

+(double)metersToInches:(double)meters
{
    return [HVLengthMeasurement centimetersToInches:meters * 100];
}

+(double)inchesToMeters:(double)inches
{
    return [HVLengthMeasurement inchesToCentimeters:inches] / 100;
}

@end
