//
//  HVApproxMeasurement.h
//  HVLib
//
//

#import "HVType.h"
#import "HVMeasurement.h"

//-------------------------
//
// Sometimes it is not possible to get a precise numeric measurement. 
// Descriptive (approx) measurements can include: "A lot", "Strong", "Weak", "Big", "Small"...
//
//-------------------------
@interface HVApproxMeasurement : HVType
{
@private
    NSString* m_display;
    HVMeasurement* m_measurement;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) - You must supply at least a descriptive display text
//
@property (readwrite, nonatomic, retain) NSString* displayText;
//
// (Optional) - A coded measurement value
//
@property (readwrite, nonatomic, retain) HVMeasurement* measurement;

//
// Convenience
//
@property (readonly, nonatomic) BOOL hasMeasurement;
//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithDisplayText:(NSString *) text;
-(id) initWithDisplayText:(NSString *)text andMeasurement:(HVMeasurement *) measurement;

+(HVApproxMeasurement *) fromDisplayText:(NSString *) text;
+(HVApproxMeasurement *) fromDisplayText:(NSString *) text andMeasurement:(HVMeasurement *) measurement;
+(HVApproxMeasurement *) fromValue:(double)value unitsText:(NSString *)unitsText unitsCode:(NSString *)code unitsVocab:(NSString *) vocab;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;

@end
