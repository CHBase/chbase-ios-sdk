#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVInsulinInjection : HVItemDataTyped
{
@private
    HVCodableValue* m_type;
    HVInsulinInjection* m_amount;
    NSString* m_deviceId;
}

@property (readwrite, nonatomic, retain) HVCodableValue* type;
@property (readwrite, nonatomic, retain) HVInsulinInjection* amount;
@property (readwrite, nonatomic, retain) NSString* deviceId;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end