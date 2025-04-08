//
//  HVNameValue.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVCodedValue.h"
#import "HVMeasurement.h"

//-------------------------
//
// Named Measurements
//
//-------------------------
@interface HVNameValue : HVType
{
    HVCodedValue* m_name;
    HVMeasurement* m_value;
}

//-------------------------
//
// Data
//
//-------------------------
//
// REQUIRED
//
@property (readwrite, nonatomic, retain) HVCodedValue* name;
@property (readwrite, nonatomic, retain) HVMeasurement* value;

//
// Convenience
//
@property(readwrite, nonatomic, assign) double measurementValue;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithName:(HVCodedValue *) name andValue:(HVMeasurement *) value;

+(HVNameValue *) fromName:(HVCodedValue *) name andValue:(HVMeasurement *) value;

@end

//-------------------------
//
// Collection of Named Measurements
//
//-------------------------
@interface HVNameValueCollection : HVCollection 

-(HVNameValue *) itemAtIndex:(NSUInteger) index;

-(NSUInteger) indexOfItemWithName:(HVCodedValue *) code;
//
// Name codes should typically be from [HVExercise vocabForDetails]
//
-(NSUInteger) indexOfItemWithNameCode:(NSString *) nameCode;
-(HVNameValue *) getItemWithNameCode:(NSString *) nameCode;

-(void) addOrUpdate:(HVNameValue *) value;
 

@end
