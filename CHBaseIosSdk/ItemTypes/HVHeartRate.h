//
//  HVBloodPressure.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVHeartRate : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVNonNegativeInt* m_bpm;
    HVCodableValue* m_measurementMethod;
    HVCodableValue* m_measurementConditions;
    HVCodableValue* m_measurementFlags;
}

//
// (Required) - When the measurement was made
//
@property (readwrite, nonatomic, retain) HVDateTime* when;
//
// (Required) - Heart rate in beats per minute
//
@property (readwrite, nonatomic, retain) HVNonNegativeInt* bpm;

@property (readwrite, nonatomic, retain) HVCodableValue* measurementMethod;
@property (readwrite, nonatomic, retain) HVCodableValue* measurementConditions;
@property (readwrite, nonatomic, retain) HVCodableValue* measurementFlags;

//
// Convenience properties
//
@property (readwrite, nonatomic) int bpmValue;


//-------------------------
//
// Initializers
//
//-------------------------

-(id) initWithBpm:(int) bpm andDate:(NSDate*) date;

+(HVItem *) newItem;

//-------------------------
//
// Methods
//
//-------------------------
+(HVVocabIdentifier *) vocabForMeasurementMethod;
+(HVVocabIdentifier *) vocabForMeasurementConditions;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;
//
// Takes a format string with %@ in it, surrounded with other decorative text of your choice
//
-(NSString *) toStringWithFormat:(NSString *) format;

//-------------------------
//
// Type information
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;

@end
