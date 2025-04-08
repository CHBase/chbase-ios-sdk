//
//  HVConcentrationValue.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVNonNegativeDouble.h"
#import "HVDisplayValue.h"

extern NSString* const c_element_mmolPL;
extern NSString* const c_element_display;

extern NSString* const c_mmolPlUnits;
extern NSString* const c_mmolUnitsCode;
extern NSString* const c_mgDLUnits;
extern NSString* const c_mgDLUnitsCode;

extern const xmlChar* x_element_mmolPL;
extern const xmlChar* x_element_display;

//
// Concentration values, stored in mmol/Liter
// Most commonly used to store Cholesterol Measurements
//
@interface HVConcentrationValue : HVType
{
@private
    HVNonNegativeDouble* m_mmolPerl;
    HVDisplayValue* m_display;
}

//
// Required
//
@property (readwrite, nonatomic, retain) HVNonNegativeDouble* value;
//
// Optional
//
@property (readwrite, nonatomic, retain) HVDisplayValue *display;

@property (readwrite, nonatomic) double mmolPerLiter;

-(id) initWithMmolPerLiter:(double) value;
-(id) initWithMgPerDL:(double) value gramsPerMole:(double) gramsPerMole;

-(double) mgPerDL:(double) gramsPerMole;
-(void) setMgPerDL:(double) value gramsPerMole:(double) gramsPerMole;

-(BOOL) updateDisplayValue:(double) displayValue units:(NSString *) unitValue andUnitsCode:(NSString *)code;

-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;

@end
