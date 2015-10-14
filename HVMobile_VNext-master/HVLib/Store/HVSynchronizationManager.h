//
//  HVSynchronizationManager.h
//  HVLib
//
//
//
#import <Foundation/Foundation.h>
#import "HVItemChangeManager.h"
#import "HVSynchronizedStore.h"

@class HVLocalRecordStore;
@class HVSynchronizedType;

@interface HVSynchronizationManager : NSObject
{
@private
    HVLocalRecordStore* m_store;  
    HVSynchronizedStore* m_data;
    HVItemChangeManager* m_changeManager;
    NSMutableDictionary* m_syncTypes;
}

@property (readonly, nonatomic) HVLocalRecordStore* store;
@property (readonly, nonatomic) HVRecordReference* record;
@property (readonly, nonatomic) HVSynchronizedStore* data;
@property (readonly, nonatomic) HVItemChangeManager* changeManager;

-(id) initForRecordStore:(HVLocalRecordStore *) store withCache:(BOOL) cache;

// Invoked by the owning HVLocalRecordStore to release references
-(void) close;
-(void) reset;  // Warning - calling this will delete all locally cached data and any pending changes
//
// Return a synchronized type object for the given typeID
// HVSynchronizedType can function offline just like a HVTypeView, but also has Offline WRITEs
// and reliable background commit support. See documentation
//
-(HVSynchronizedType *) getTypeForClassName:(NSString *)className;
-(HVSynchronizedType *) getTypeForTypeID:(NSString *) typeID;

-(HVItem *) getLocalItemWithKey:(HVItemKey *) key; // Returns nil if not locally available
-(HVItem *) getLocalItemForEditWithKey:(HVItemKey *) key; // Clones (in memory only) item, if available. Returns nil if not locally available
-(HVDownloadItemsTask *) downloadItemWithKey:(HVItemKey *) key withCallback:(HVTaskCompletion) callback;

-(HVAutoLock *) newLockForItemKey:(HVItemKey *) key;
-(BOOL) putNewItem:(HVItem *) item;
-(BOOL) putItem:(HVItem *) item itemLock:(HVAutoLock *) lock;
-(BOOL) removeItem:(HVItem *) item itemLock:(HVAutoLock *) lock;
-(BOOL) removeItemWithTypeID:(NSString *) typeID key:(HVItemKey *) key itemLock:(HVAutoLock *) lock;

-(BOOL) hasPendingChanges;
-(HVTask *) commitPendingChangesWithCallback:(HVTaskCompletion) callback;

+(NSString *) dataStoreKey;

-(void) clearCache;

//---------------------------------------------------
//
// Internal methods called HVSynchronizationStore
//
//---------------------------------------------------
-(BOOL) replaceLocalWithDownloaded:(HVItem *) item;  // Will only replace the local item if there are no pending changes to the item
-(BOOL) applyChangeCommitSuccess:(HVItemChange *) change itemLock:(HVAutoLock *) lock;

@end
