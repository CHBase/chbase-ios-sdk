//
//  HVDietaryIntake.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

//------------------------
//
// DAILY Dietary Intake
// DEPRECATED.
// This type is obsolete.
// Use HVDietaryIntake
//
//------------------------
@interface HVDailyDietaryIntake : HVItemDataTyped
{
@private
    HVDate* m_when;
    HVPositiveInt* m_calories;
    HVWeightMeasurement* m_totalFat;
    HVWeightMeasurement* m_saturatedFat;
    HVWeightMeasurement* m_transFat;
    HVWeightMeasurement* m_protein;
    HVWeightMeasurement* m_carbs;
    HVWeightMeasurement* m_fiber;
    HVWeightMeasurement* m_sugar;
    HVWeightMeasurement* m_sodium;
    HVWeightMeasurement* m_cholesterol;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) - the day for this intake
//
@property (readwrite, nonatomic, retain) HVDate* when;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVPositiveInt* calories;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVWeightMeasurement* totalFat;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVWeightMeasurement* saturatedFat;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVWeightMeasurement* transFat;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVWeightMeasurement* protein;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVWeightMeasurement* totalCarbs;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVWeightMeasurement* sugar;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVWeightMeasurement* dietaryFiber;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVWeightMeasurement* sodium;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVWeightMeasurement* cholesterol;

//
// Convenience properties
//
@property (readwrite, nonatomic) int caloriesValue;
@property (readwrite, nonatomic) double totalFatGrams;
@property (readwrite, nonatomic) double saturatedFatGrams;
@property (readwrite, nonatomic) double transFatGrams;
@property (readwrite, nonatomic) double proteinGrams;
@property (readwrite, nonatomic) double totalCarbGrams;
@property (readwrite, nonatomic) double sugarGrams;
@property (readwrite, nonatomic) double dietaryFiberGrams;
@property (readwrite, nonatomic) double sodiumMillgrams;
@property (readwrite, nonatomic) double cholesterolMilligrams;

+(NSString *) typeID;
+(NSString *) XRootElement;

+(HVItem *) newItem;

@end
