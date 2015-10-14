//
//  HVWeightMeasurement.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVPositiveDouble.h"
#import "HVDisplayValue.h"

//-------------------------
//
// Weights are always measured in KG
//
//-------------------------
@interface HVWeightMeasurement : HVType
{
@private
    HVPositiveDouble* m_kg;
    HVDisplayValue* m_display;
}

//-------------------------
//
// Weight Data
//
//-------------------------
//
// (Required) - weight - in KG
//
@property (readwrite, nonatomic, retain) HVPositiveDouble* value;
//
// (Optional) - what the user entered - before conversion to standard units
//
@property (readwrite, nonatomic, retain) HVDisplayValue *display;
//
// Convenience properties
//
@property (readwrite, nonatomic) double inKg;
@property (readwrite, nonatomic) double inGrams;
@property (readwrite, nonatomic) double inMilligrams;
@property (readwrite, nonatomic) double inPounds;
@property (readwrite, nonatomic) double inOunces;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithKg:(double) value;
-(id) initwithPounds:(double) value;

//-------------------------
//
// Methods
//
//-------------------------
//
// Vocabulary for units and code: weight-units
//
-(BOOL) updateDisplayValue:(double) displayValue units:(NSString *) unitValue andUnitsCode:(NSString *) code;

+(double) kgToPounds:(double) kg;
+(double) poundsToKg:(double) pounds;

//-------------------------
//
// Text
//
//-------------------------
//
// These methods expect a format string with one %f in it.
//
-(NSString *) toStringWithFormat:(NSString *) format;
-(NSString *) stringInPounds:(NSString *) format;
-(NSString *) stringInOunces:(NSString *) format;
-(NSString *) stringInKg:(NSString *) format;
-(NSString *) stringInGrams:(NSString *) format;
-(NSString *) stringInMilligrams:(NSString *) format;

-(NSString *) toString;

+(HVWeightMeasurement *) fromKg:(double) kg;
+(HVWeightMeasurement *) fromGrams:(double) grams;
+(HVWeightMeasurement *) fromMillgrams:(double) grams;

+(HVWeightMeasurement *) fromPounds:(double) pounds;
+(HVWeightMeasurement *) fromOunces:(double) ounces;


@end
