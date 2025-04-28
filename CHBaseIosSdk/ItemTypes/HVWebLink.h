#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVWebLink : HVItemDataTyped
{
@private
    NSString* m_url;
    NSString* m_title;
}


+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end