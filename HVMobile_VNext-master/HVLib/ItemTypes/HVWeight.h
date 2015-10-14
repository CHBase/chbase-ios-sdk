//
//  Weight.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVWeight : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVWeightMeasurement* m_value;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) When the measurement was made
//
@property (readwrite, nonatomic, retain) HVDateTime* when;
//
// (Required) The weight measurement
// You can also use the inPounds and inKg properties to set the weight value
//
@property (readwrite, nonatomic, retain) HVWeightMeasurement* value;

//
// Helper properties for manipulating weight
//
@property (readwrite, nonatomic) double inPounds;
@property (readwrite, nonatomic) double inKg;

//-------------------------
//
// Initializers 
//
//-------------------------
-(id) initWithKg:(double) kg andDate:(NSDate*) date;
-(id) initWithPounds:(double) pounds andDate:(NSDate *) date;

+(HVItem *) newItem;
+(HVItem *) newItemWithKg:(double) kg andDate:(NSDate*) date;
+(HVItem *) newItemWithPounds:(double) pounds andDate:(NSDate *) date;

//-------------------------
//
// Text 
//
//-------------------------
-(NSString *) toString;  // Returns weight in kg
-(NSString *) stringInPounds;
-(NSString *) stringInKg;
//
// These methods expect a format string with a %f in it, surrounded with other decorative text of your choice
//
-(NSString *) stringInPoundsWithFormat:(NSString *) format;
-(NSString *) stringInKgWithFormat:(NSString *) format;

//-------------------------
//
// Type Information
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;


@end
