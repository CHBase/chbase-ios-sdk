//
//  HVFoodEnergyValue.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVNonNegativeDouble.h"
#import "HVDisplayValue.h"

@interface HVFoodEnergyValue : HVType
{
@private
    HVNonNegativeDouble* m_calories;
    HVDisplayValue* m_display;
}
//
// Required
// Note: these are dietary calories - or "large" calories. 
// The amount of energy needed to raise the temperature of 1Kg of water by 1 degree Celsius
// Or approx 4.2 kilojoules
//
@property (readwrite, nonatomic, retain) HVNonNegativeDouble* calories;
//
// Optional
//
@property (readwrite, nonatomic, retain) HVDisplayValue* displayValue;

@property (readwrite, nonatomic) double caloriesValue;

-(id) initWithCalories:(double) value;

-(BOOL) updateDisplayText;

-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;

+(HVFoodEnergyValue *) fromCalories:(double) value;

+(NSString *) calorieUnits;


@end
