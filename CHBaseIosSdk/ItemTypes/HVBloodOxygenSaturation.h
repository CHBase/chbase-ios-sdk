#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVBloodOxygenSaturation : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVNonNegativeDouble* m_value;
    HVCodableValue* m_measurementMethod;
    HVCodableValue* m_measurementFlags;
}

@property (readwrite, nonatomic, retain) HVDateTime* when;
@property (readwrite, nonatomic, retain) HVNonNegativeDouble* value;
@property (readwrite, nonatomic, retain) HVCodableValue* measurementMethod;
@property (readwrite, nonatomic, retain) HVCodableValue* measurementFlags;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end