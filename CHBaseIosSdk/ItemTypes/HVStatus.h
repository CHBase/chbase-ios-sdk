#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVStatus : HVItemDataTyped
{
@private
    HVCodableValue* m_statusType;
    NSString* m_text;
}

@property (readwrite, nonatomic, retain) HVCodableValue* statusType;
@property (readwrite, nonatomic, retain) NSString* text;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end