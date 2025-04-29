#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVComment : HVItemDataTyped
{
@private
    HVApproxDateTime* m_when;
    NSString* m_content;
    HVCodableValue* m_category;
}

@property (readwrite, nonatomic, retain) HVApproxDateTime* when;
@property (readwrite, nonatomic, retain) NSString* content;
@property (readwrite, nonatomic, retain) HVCodableValue* category;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end