//
//  HVPendingItem.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVItemKey.h"
#import "HVItemType.h"

@interface HVPendingItem : HVType
{
@private
    HVItemKey* m_id;
    HVItemType* m_type;
    NSDate* m_effectiveDate;
}

@property (readwrite, nonatomic, retain) HVItemKey* key;
@property (readwrite, nonatomic, retain) HVItemType* type;
@property (readwrite, nonatomic, retain) NSDate* effectiveDate;

@end

@interface HVPendingItemCollection : HVCollection
@end