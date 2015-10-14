//
//  HVNutritionFact.h
//  HVLib
//
//
//

#import "HVType.h"
#import "HVCodableValue.h"
#import "HVMeasurement.h"

@interface HVNutritionFact : HVType
{
@private
    HVCodableValue* m_name;
    HVMeasurement* m_fact;
}

@property (readwrite, nonatomic, retain) HVCodableValue* name;
@property (readwrite, nonatomic, retain) HVMeasurement* fact;

@end

@interface HVNutritionFactCollection : HVCollection

@end

@interface HVAdditionalNutritionFacts : HVType
{
@private
    HVNutritionFactCollection* m_facts;
}

//
// Required
//
@property (readwrite, nonatomic, retain) HVNutritionFactCollection* facts;

@end