#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVBmiValue.h"

@interface HVBmi : HVItemDataTyped
{
@private
HVDateTime* m_when;
    HVLengthMeasurement* m_height;
    HVWeightMeasurement* m_weight;
    HVBmiValue* m_value;
}

@property (readwrite, nonatomic, retain) HVDateTime* when;
@property (readwrite, nonatomic, retain) HVLengthMeasurement* height;
@property (readwrite, nonatomic, retain) HVWeightMeasurement* weight;
@property (readwrite, nonatomic, retain) HVBmiValue* value;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end
