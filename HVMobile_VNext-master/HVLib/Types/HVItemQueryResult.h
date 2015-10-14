//
//  HVItemQueryResult.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVItem.h"
#import "HVPendingItem.h"
#import "HVItemView.h"

@class HVGetItemsTask;

@interface HVItemQueryResult : HVType
{
@private
    HVItemCollection* m_items;
    HVPendingItemCollection* m_pendingItems;
    NSString* m_name;
}
//
// Collection of items found
//
@property (readwrite, nonatomic, retain) HVItemCollection* items;
//
// If there were too many matches (depends on server quotas & buffer sizes), HealthVault will
// return only the first chunk of matches. It will also return the keys of the 'pending' items
// You must issue a fresh query to retrieve these pending items. This is easily done using
// convenient init methods on HVItemQuery
//
@property (readwrite, nonatomic, retain) HVPendingItemCollection* pendingItems;
//
// When you issue multiple queries simultaneously, you can give them names
//
@property (readwrite, nonatomic, retain) NSString* name;
//
// Convenience properties
//
@property (readonly, nonatomic) BOOL hasItems;
@property (readonly, nonatomic) BOOL hasPendingItems;
@property (readonly, nonatomic) NSUInteger itemCount;
@property (readonly, nonatomic) NSUInteger pendingCount;
@property (readonly, nonatomic) NSUInteger resultCount;

//
// If the query result has pending items, get them and ADD them to the items collection
// 
-(HVTask *) getPendingItemsForRecord:(HVRecordReference *) record withCallback:(HVTaskCompletion) callback;
-(HVTask *) getPendingItemsForRecord:(HVRecordReference *) record itemView:(HVItemView *) view withCallback:(HVTaskCompletion) callback;

-(HVTask *) createTaskToGetPendingItemsForRecord:(HVRecordReference *) record withCallback:(HVTaskCompletion) callback;
-(HVTask *) createTaskToGetPendingItemsForRecord:(HVRecordReference *) record itemView:(HVItemView *) view withCallback:(HVTaskCompletion) callback;

@end

@interface HVItemQueryResultCollection : HVCollection

-(HVItemQueryResult *) itemAtIndex:(NSUInteger) index;

@end