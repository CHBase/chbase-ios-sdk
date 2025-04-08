//
//  HVItemChangeTable.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVItemChange.h"
#import "HVPartitionedStore.h"

@class HVItemChangeQueue;

@interface HVItemChangeTable : NSObject
{
@private
    HVPartitionedObjectStore* m_store;
}

-(id) initWithObjectStore:(id<HVObjectStore>) store;

-(BOOL) hasChangesForTypeID:(NSString *) typeID itemID:(NSString *) itemID;
-(BOOL) hasChangesForTypeID:(NSString *) typeID;
-(BOOL) hasChanges;

// Returns the change ID, if one was assigned
-(NSString *) trackChange:(enum HVItemChangeType) changeType forTypeID:(NSString *) typeID andKey:(HVItemKey *) key;

// An array of HVItemChangeQueueEntry in order
-(HVItemChangeQueue *) getQueue;
-(HVItemChangeQueue *) getQueueForTypeID:(NSString *)typeID;
-(NSMutableArray *) getAll;

-(NSMutableArray *) getAllTypesWithChanges;
-(HVItemChange *) getForTypeID:(NSString *) typeID itemID:(NSString *) itemID;
-(BOOL) put:(HVItemChange *) change;
-(BOOL) removeForTypeID:(NSString *) typeID itemID:(NSString *) itemID;

-(void) removeAll;
-(BOOL) removeAllForTypeID:(NSString *) typeID;

@end

//-------------------------------------------
//
// HVItemChangeQueue
//
//-------------------------------------------
@interface HVItemChangeQueue : NSEnumerator
{
@private
    HVItemChangeTable* m_changeTable;
    NSMutableArray* m_types;
    NSString* m_currentType;
    NSMutableArray* m_currentQueue;
}

-(id)initWithChangeTable:(HVItemChangeTable *)changeTable andChangedTypes:(NSMutableArray *) types;

-(HVItemChange *) nextChange;

@end
