#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVBodyDimension : HVItemDataTyped
{
@private
    HVApproxDateTime* m_when;
    HVCodableValue* m_measurementName;
    HVLengthMeasurement* m_value;
}

@property (readwrite, nonatomic, retain) HVApproxDateTime* when;
@property (readwrite, nonatomic, retain) HVCodableValue* measurementName;
@property (readwrite, nonatomic, retain) HVLengthMeasurement* value;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end