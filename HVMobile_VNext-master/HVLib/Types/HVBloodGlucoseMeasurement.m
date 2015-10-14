//
//  HVBloodGlucoseMeasurement.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVBloodGlucoseMeasurement.h"
#import "HVMeasurement.h"

@implementation HVBloodGlucoseMeasurement

@synthesize value = m_mmolPerl;
@synthesize display = m_display;

-(double)mmolPerLiter
{
    return (m_mmolPerl) ? m_mmolPerl.value : NAN;
}

-(void)setMmolPerLiter:(double)mmolPerLiter
{
    HVENSURE(m_mmolPerl, HVPositiveDouble);
    m_mmolPerl.value = mmolPerLiter;
    [self updateDisplayValue:mmolPerLiter units:c_mmolPlUnits andUnitsCode:c_mmolUnitsCode];
}

-(double)mgPerDL
{
    if (m_mmolPerl)
    {
        return [HVBloodGlucoseMeasurement mMolPerLiterToMgPerDL:m_mmolPerl.value];
    }
    
    return NAN;
}

-(void)setMgPerDL:(double)mgPerDL
{
    HVENSURE(m_mmolPerl, HVPositiveDouble);
    m_mmolPerl.value = [HVBloodGlucoseMeasurement mgPerDLToMmolPerLiter:mgPerDL];
    [self updateDisplayValue:mgPerDL units:c_mgDLUnits andUnitsCode:c_mgDLUnitsCode];
}

-(void)dealloc
{
    [m_mmolPerl release];
    [m_display release];
    [super dealloc];
}

-(id)initWithMmolPerLiter:(double)value
{
    self = [super init];
    HVCHECK_SELF;
    
    self.mmolPerLiter = value;
    HVCHECK_NOTNULL(m_mmolPerl);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(id)initWithMgPerDL:(double)value
{
    self = [super init];
    HVCHECK_SELF;
    
    self.mgPerDL = value;
    HVCHECK_NOTNULL(m_mmolPerl);
    
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

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    return [self toStringWithFormat:@"%.3f mmol/l"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.mmolPerLiter];
}

+(double)mMolPerLiterToMgPerDL:(double)value
{
    return value * 18;
}

+(double)mgPerDLToMmolPerLiter:(double)value
{
    return value / 18;
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_mmolPerl, HVClientError_InvalidBloodGlucoseMeasurement);
    HVVALIDATE_OPTIONAL(m_display);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;  
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_mmolPerl, x_element_mmolPL);
    HVSERIALIZE_X(m_display, x_element_display);
}

-(void)deserialize:(XReader *)reader
{    
    HVDESERIALIZE_X(m_mmolPerl, x_element_mmolPL, HVPositiveDouble);
    HVDESERIALIZE_X(m_display, x_element_display, HVDisplayValue);
}

@end
