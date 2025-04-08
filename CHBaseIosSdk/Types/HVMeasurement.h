//
//  HVMeasurement.h
//  HVLib
//
//

#import "HVType.h"
#import "HVCodableValue.h"

//-------------------------
//
// Structured measurement, combining value and units
//
//-------------------------
@interface HVMeasurement : HVType
{
    double m_value;
    HVCodableValue* m_units;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required)
//
@property (readwrite, nonatomic) double value;
//
// (Required)
//
@property (readwrite, nonatomic, retain) HVCodableValue* units;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithValue:(double) value andUnits:(HVCodableValue *) units;
-(id) initWithValue:(double) value andUnitsString:(NSString *) units;

+(HVMeasurement *) fromValue:(double) value unitsDisplayText:(NSString *) unitsText unitsCode:(NSString *) code unitsVocab:(NSString *) vocab;
+(HVMeasurement *) fromValue:(double) value andUnits:(HVCodableValue *) units;
+(HVMeasurement *) fromValue:(double) value andUnitsString:(NSString *) units;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;
//
// Value  Units
// Expects string in the format "%f %@"
//
-(NSString *) toStringWithFormat:(NSString *) format;

@end
