#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVAsthmaInhalerUsage : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVCodableValue* m_drug;
    HVCodableValue* m_strength;
    HVNonNegativeInt* m_doseCount;
    NSString* m_deviceId;
    HVCodableValue* m_dosePurpose;
}

@property (readwrite, nonatomic, retain) HVDateTime* when;
@property (readwrite, nonatomic, retain) HVCodableValue* drug;
@property (readwrite, nonatomic, retain) HVCodableValue* strength;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* doseCount;
@property (readwrite, nonatomic, retain) NSString* deviceId;
@property (readwrite, nonatomic, retain) HVCodableValue* dosePurpose;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end