//
//  HVDisplayValue.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"

//
// The DisplayValue of a measurement is the precise information the user
// entered - BEFORE any conversions to standard units, such as metric. 
// E.g. Weights are stored in kgs, but are typically entered (in the US) 
// in pounds. 
//
// The display value captures the exact data the user entered, along with
// the units of that data. 
//
@interface HVDisplayValue : HVType
{
@private
    double m_value;
    NSString* m_text;
    NSString* m_units;
    NSString* m_unitsCode;
}
//
// (Required) - the exact data as entered by the user - before any conversions
// to standardized units
//
@property (readwrite, nonatomic) double value;
//
// (Optional) - units for the data
//
@property (readwrite, nonatomic, retain) NSString* units;
//
// (Optional) - a vocabulary code for the units
//
@property (readwrite, nonatomic, retain) NSString* unitsCode;
//
// (Optional) - text value for the above
//
@property (readwrite, nonatomic, retain) NSString* text;

-(id) initWithValue:(double) doubleValue andUnits:(NSString *) unitValue;

@end
