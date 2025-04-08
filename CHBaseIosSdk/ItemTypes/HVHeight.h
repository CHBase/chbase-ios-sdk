//
//  HVHeight.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVHeight : HVItemDataTyped
{
    HVDateTime* m_when;
    HVLengthMeasurement* m_height;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) When the measurement was taken
//
@property (readwrite, nonatomic, retain) HVDateTime* when;
//
// (Required) Length measurement (meters)
// You can also use the convenience inMeters/inInches properties
//
@property (readwrite, nonatomic, retain) HVLengthMeasurement* value;
//
// Convenience properties
//
@property (readwrite, nonatomic) double inMeters;
@property (readwrite, nonatomic) double inInches;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithInches:(double) inches andDate:(NSDate *) date;
-(id) initWithMeters:(double) meters andDate:(NSDate *) date;
+(HVItem *) newItem;

//-------------------------
//
// Text
// These methods expect a format string containing a single %f
//
//-------------------------
-(NSString *) stringInMeters:(NSString *) format;
-(NSString *) stringInInches:(NSString *) format;
-(NSString *) stringInFeetAndInches:(NSString *) format;
-(NSString *) toString;

+(NSString *) typeID;
+(NSString *) XRootElement;

@end
