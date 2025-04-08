//
//  HVBloodPressure.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVBloodPressure : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVNonNegativeInt* m_systolic;
    HVNonNegativeInt* m_diastolic;
    HVNonNegativeInt* m_pulse;
    HVBool* m_heartbeat;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) When the blood pressure was taken
//
@property (readwrite, nonatomic, retain) HVDateTime* when;
//
// (Required) Systolic value. 
//  You can also use the convenience systolicValue property 
//
@property (readwrite, nonatomic, retain) HVNonNegativeInt* systolic;
//
// (Required) Diastolic value
// You can also use the convenience diastolicValue property
//
@property (readwrite, nonatomic, retain) HVNonNegativeInt* diastolic;
//
// (Optional) Pulse
// You can also use the convenience pulseValue property
// 
@property (readwrite, nonatomic, retain) HVNonNegativeInt* pulse;
//
// (Optional) True if irregular heartbeat
//
@property (readwrite, nonatomic, retain) HVBool *irregularHeartbeat;


//
// Convenience properties
//
@property (readwrite, nonatomic) int systolicValue;
@property (readwrite, nonatomic) int diastolicValue;
@property (readwrite, nonatomic) int pulseValue;


//-------------------------
//
// Initializers
//
//-------------------------

-(id) initWithSystolic:(int) sVal diastolic:(int) dVal;
-(id) initWithSystolic:(int) sVal diastolic:(int) dVal andDate:(NSDate*) date;
-(id) initWithSystolic:(int) sVal diastolic:(int) dVal pulse:(int) pVal;
+(HVItem *) newItem;


//-------------------------
//
// Text
//
//-------------------------
//
// Generates string for systolic OVER diastolic
//
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
