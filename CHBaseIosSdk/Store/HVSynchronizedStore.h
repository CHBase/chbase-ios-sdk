//
//  HVSynchronizedStore.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVAsyncTask.h"
#import "HVObjectStore.h"
#import "HVItemStore.h"
#import "HVDownloadItemsTask.h"

@class HVTypeView;
@class HVSynchronizationManager;

@interface HVSynchronizedStore : NSObject
{
    enum HVItemSection m_sections;
    id<HVItemStore> m_localStore;
    
    HVSynchronizationManager* m_syncMgr;
}

@property (readonly, nonatomic) id<HVItemStore> localStore;
@property (readwrite, nonatomic) enum HVItemSection defaultSections;

// Weak ref back to the owning sync manager, if any
@property (readwrite, nonatomic, assign) HVSynchronizationManager* syncMgr;

-(id) initOverStore:(id<HVObjectStore>) store;
-(id) initOverItemStore:(id<HVItemStore>) store;

-(void) clearCache;

//---------------------------------
//
// Operations on items locally available on this machine
//
//---------------------------------

-(HVItem *) getLocalItemWithKey:(HVItemKey *) key;
//
// Retrieve locally stored items for the given keys
// HVItemCollection.count is always == keys.count
// If no local item is found for a key, returns its equivalent position in HVItemCollection
// contains NSNull
//
-(HVItemCollection *) getLocalItemsWithKeys:(NSArray *) keys;

-(HVItem *) getlocalItemWithID:(NSString *) itemID;
-(BOOL) putLocalItem:(HVItem *) item;
-(void) removeLocalItemWithKey:(HVItemKey *) key;

//---------------------------------
//
// Operations that go to HealthVault
// They pull items down to the local store
//
//---------------------------------
//
// Downloads items for the given keys and store them locally.
// Always retrieves the LATEST item for the key 
// When complete, notify HVTypeView of completions by calling:
//   - keysNotRetrieved (if error)
//   - itemsRetrieved
//
-(HVTask *) downloadItemsWithKeys:(NSArray *) keys inView:(HVTypeView *) view;
-(HVTask *) downloadItemsWithKeys:(NSArray *) keys typeID:(NSString *) typeID inView:(HVTypeView *) view;
//
// Fetch items with given keys into the local store
// Always retrieves the LATEST item for the key
// In the callback, HVTask.result has an HVItemCollection containing those items that were found
//
-(HVTask *) getItemsInRecord:(HVRecordReference *) record withKeys:(NSArray *) keys callback:(HVTaskCompletion) callback;
-(HVTask *) getItemsInRecord:(HVRecordReference *) record forQuery:(HVItemQuery *) query callback:(HVTaskCompletion) callback;

// Deprecated. Use HVSynchronizationMgr & HVSynchronizedType
-(BOOL) putItem:(HVItem *) item __deprecated;

//
// In the callback, use [task checkForSuccess] to confirm that the operation succeeded
// task.result will contain updated keys - in case the items 
// Always retrieves the LATEST item for the keys
//
-(HVDownloadItemsTask *) downloadItemsInRecord:(HVRecordReference *) record forKeys:(NSArray *) keys callback:(HVTaskCompletion) callback;
//
// In the callback, use [task checkForSuccess] to confirm that the operation succeeded
//
-(HVDownloadItemsTask *) downloadItemsInRecord:(HVRecordReference *) record query:(HVItemQuery *) query callback:(HVTaskCompletion) callback;
//
// These create new download tasks but do NOT start them.
// You can make the task a child of another task
// 
-(HVDownloadItemsTask *) newDownloadItemsInRecord:(HVRecordReference *) record forKeys:(NSArray *) keys callback:(HVTaskCompletion) callback;
-(HVDownloadItemsTask *) newDownloadItemsInRecord:(HVRecordReference *) record forQuery:(HVItemQuery *) query callback:(HVTaskCompletion) callback;

@end
