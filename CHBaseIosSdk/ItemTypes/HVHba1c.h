#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVHba1cvalue.h"


@interface HVHba1c : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVHbA1CValue* m_value;
    HVCodableValue* m_hba1cAssayMethod;
    NSString* m_deviceId;
}

@property (readwrite, nonatomic, retain) HVDateTime* when;
@property (readwrite, nonatomic, retain) HVHbA1CValue* value;
@property (readwrite, nonatomic, retain) HVCodableValue* hba1cAssayMethod;
@property (readwrite, nonatomic, retain) NSString* deviceId;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end
