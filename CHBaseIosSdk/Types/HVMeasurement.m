//
//  HVMeasurement.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVMeasurement.h"

static const xmlChar* x_element_value = XMLSTRINGCONST("value");
static const xmlChar* x_element_units = XMLSTRINGCONST("units");

@implementation HVMeasurement

@synthesize value = m_value;
@synthesize units = m_units;

-(id)initWithValue:(double)value andUnits:(HVCodableValue *)units
{
    HVCHECK_NOTNULL(units);
    
    self = [super init];
    HVCHECK_SELF;
    
    m_value = value;
    self.units = units;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(id)initWithValue:(double)value andUnitsString:(NSString *)units
{
    HVCodableValue* unitsValue = [[HVCodableValue alloc] initWithText:units];
    HVCHECK_NOTNULL(unitsValue);
    
    self = [self initWithValue:value andUnits:unitsValue];
    [unitsValue release];
    
    HVCHECK_SELF;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_units release];
    [super dealloc];
}

+(HVMeasurement *)fromValue:(double)value andUnits:(HVCodableValue *)units
{
    return [[[HVMeasurement alloc] initWithValue:value andUnits:units] autorelease];
}

+(HVMeasurement *)fromValue:(double)value andUnitsString:(NSString *)units
{
    return [[[HVMeasurement alloc] initWithValue:value andUnitsString:units] autorelease];
}

+(HVMeasurement *)fromValue:(double)value unitsDisplayText:(NSString *)unitsText unitsCode:(NSString *)code unitsVocab:(NSString *)vocab
{
    HVCodableValue* unitCode = [[HVCodableValue alloc] initWithText:unitsText code:code andVocab:vocab];
    HVCHECK_NOTNULL(unitCode);
    
    HVMeasurement* measurement = [[HVMeasurement alloc] initWithValue:value andUnits:unitCode];
    [unitCode release];
    
    return measurement;
    
LError:
    HVALLOC_FAIL;
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    if (!m_units)
    {
        return [NSString localizedStringWithFormat:@"%g", m_value]; 
    }
    
    return [self toStringWithFormat:@"%g %@"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, m_value, m_units.text];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_units, HVClientError_InvalidMeasurement);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_DOUBLE_X(m_value, x_element_value);
    HVSERIALIZE_X(m_units, x_element_units);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_DOUBLE_X(m_value, x_element_value);
    HVDESERIALIZE_X(m_units, x_element_units, HVCodableValue);
}

@end
