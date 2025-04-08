//
//  HVWeightMeasurement.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVWeightMeasurement.h"

static double const c_PoundsPerKg = 2.20462262185;
static double const c_KgPerPound = 0.45359237;

static const xmlChar* x_element_kg = XMLSTRINGCONST("kg");
static const xmlChar* x_element_display = XMLSTRINGCONST("display");

@implementation HVWeightMeasurement

@synthesize value = m_kg;
@synthesize display = m_display;

-(double) inKg
{
    return (m_kg) ? m_kg.value : NAN;
}

-(void) setInKg:(double)valueInKg
{
    HVENSURE(m_kg, HVPositiveDouble);
    m_kg.value = valueInKg;
    
    [self updateDisplayValue:valueInKg units:@"kilogram" andUnitsCode:@"kg"];
}

-(double)inGrams
{
    return self.inKg * 1000;
}

-(void)setInGrams:(double)grams
{
    HVENSURE(m_kg, HVPositiveDouble);
    m_kg.value = grams / 1000;
    
    [self updateDisplayValue:grams units:@"gram" andUnitsCode:@"g"];   
}

-(double)inMilligrams
{
    return self.inGrams * 1000;
}

-(void)setInMilligrams:(double)milligrams
{
    HVENSURE(m_kg, HVPositiveDouble);
    m_kg.value = milligrams / (1000 * 1000);
    
    [self updateDisplayValue:milligrams units:@"milligram" andUnitsCode:@"mg"];   
}

-(double) inPounds
{
    return [HVWeightMeasurement kgToPounds:self.inKg];
}

-(void) setInPounds:(double)valueInPounds
{
    HVENSURE(m_kg, HVPositiveDouble);
    m_kg.value = [HVWeightMeasurement poundsToKg:valueInPounds];

    [self updateDisplayValue:valueInPounds units:@"pound" andUnitsCode:@"lb"];
}

-(double)inOunces
{
    return self.inPounds * 16;
}

-(void)setInOunces:(double)ounces
{
    HVENSURE(m_kg, HVPositiveDouble);
    m_kg.value = [HVWeightMeasurement poundsToKg:(ounces / 16)];
    
    [self updateDisplayValue:ounces units:@"ounce" andUnitsCode:@"oz"];
}

-(id) initWithKg:(double)value
{
    self = [super init];
    HVCHECK_SELF;
    
    self.inKg = value;
    
    HVCHECK_NOTNULL(m_kg);
    HVCHECK_NOTNULL(m_display);

    return self;
LError:
    HVALLOC_FAIL;
}

-(id) initwithPounds:(double)value
{
    self = [super init];
    HVCHECK_SELF;
    
    self.inPounds = value;
    HVCHECK_NOTNULL(m_display);
    
    return self;
LError:
    HVALLOC_FAIL;    
}

-(void) dealloc
{
    [m_kg release];
    [m_display release];
    
    [super dealloc];
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

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    return [self toStringWithFormat:@"%.2f kilogram"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.inKg];
}

-(NSString *)stringInPounds:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.inPounds];
}

-(NSString *)stringInOunces:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.inOunces];    
}

-(NSString *)stringInKg:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.inKg];
}

-(NSString *)stringInGrams:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.inGrams];
}

-(NSString *)stringInMilligrams:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.inMilligrams];
}

+(HVWeightMeasurement *)fromKg:(double)kg
{
    return [[[HVWeightMeasurement alloc] initWithKg:kg] autorelease];
}

+(HVWeightMeasurement *)fromPounds:(double)pounds
{
    return [[[HVWeightMeasurement alloc] initwithPounds:pounds] autorelease];    
}

+(HVWeightMeasurement *)fromGrams:(double)grams
{
    HVWeightMeasurement* weight = [[[HVWeightMeasurement alloc] init] autorelease];
    weight.inGrams = grams;
    return weight;
}

+(HVWeightMeasurement *)fromMillgrams:(double)mg
{
    HVWeightMeasurement* weight = [[[HVWeightMeasurement alloc] init] autorelease];
    weight.inMilligrams = mg;
    return weight;
}

+(HVWeightMeasurement *)fromOunces:(double)ounces
{
    HVWeightMeasurement* weight = [[[HVWeightMeasurement alloc] init] autorelease];
    weight.inOunces = ounces;
    return weight;    
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_kg, HVClientError_InvalidWeightMeasurement);
    HVVALIDATE_OPTIONAL(m_display);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_kg, x_element_kg);
    HVSERIALIZE_X(m_display, x_element_display);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_kg, x_element_kg, HVPositiveDouble);
    HVDESERIALIZE_X(m_display, x_element_display, HVDisplayValue);
}

+(double) kgToPounds:(double)kg
{
    return kg * c_PoundsPerKg;
}

+(double) poundsToKg:(double)pounds
{
    return pounds * c_KgPerPound;
}

@end

