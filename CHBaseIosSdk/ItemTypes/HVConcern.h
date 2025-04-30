#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVConcern : HVItemDataTyped
{
@private
    HVCodableValue* m_description;
    HVCodableValue* m_status;
}

@property (readwrite, nonatomic, retain) HVCodableValue* description;
@property (readwrite, nonatomic, retain) HVCodableValue* status;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end