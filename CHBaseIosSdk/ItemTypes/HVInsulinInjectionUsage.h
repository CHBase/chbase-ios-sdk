#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVInsulinInjectionValue.h"

@interface HVInsulinInjectionUsage : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVCodableValue* m_type;
    HVInsulinInjectionValue* m_amount;
    NSString* m_deviceId;
}

@property (readwrite, nonatomic, retain) HVDateTime* when;
@property (readwrite, nonatomic, retain) HVCodableValue* insulinType;
@property (readwrite, nonatomic, retain) HVInsulinInjectionValue* amount;
@property (readwrite, nonatomic, retain) NSString* deviceId;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end
