#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVAdvanceDirectiveContactType.h"

@interface HVAdvanceDirectiveV2 : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    NSString* m_name;
    HVAdvanceDirectiveContactTypeCollection* m_contact;
}

@property (readwrite, nonatomic, retain) HVDateTime* when;
@property (readwrite, nonatomic, retain) NSString* name;
@property (readwrite, nonatomic, retain) HVAdvanceDirectiveContactTypeCollection* contact;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end