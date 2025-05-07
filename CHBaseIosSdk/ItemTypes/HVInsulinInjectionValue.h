#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVInsulinInjectionValue : HVItemDataTyped
{
@private
    HVPositiveDouble* m_ie;
    HVDisplayValue* m_display;
}

@property (readwrite, nonatomic, retain) HVPositiveDouble* ie;
@property (readwrite, nonatomic, retain) HVDisplayValue* display;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end