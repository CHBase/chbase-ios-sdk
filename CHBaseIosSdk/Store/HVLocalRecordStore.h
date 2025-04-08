//
//  HVLocalRecordStore.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVObjectStore.h"
#import "HVSynchronizationManager.h"

@class HVStoredQuery;

@interface HVLocalRecordStore : NSObject
{
@private
    HVRecordReference* m_record;
    id<HVObjectStore> m_root;
    id<HVObjectStore> m_metadata;
    HVSynchronizationManager* m_dataMgr;
    BOOL m_cache;
}

//-------------------------
//
// Data
//
//-------------------------
//
// Record for which this is a store
//
@property (readonly, nonatomic) HVRecordReference* record;
//
// Root store for this record
//
@property (readonly, nonatomic) id<HVObjectStore> root;
//
// Metadata, such as view definitions, etc..
// Child of root
//
@property (readonly, nonatomic) id<HVObjectStore> metadata;
//
// All Item Data (Xml) is stored here
//
@property (readonly, nonatomic) HVSynchronizedStore* data;
//
// Synchronization manager
//
@property (readonly, nonatomic) HVSynchronizationManager* dataMgr;

//-------------------------
//
// Initializers
//
//-------------------------
//
// NO caching by default.
//
-(id) initForRecord:(HVRecordReference *) record overRoot:(id<HVObjectStore>) root;
-(id) initForRecord:(HVRecordReference *) record overRoot:(id<HVObjectStore>) root withCache:(BOOL) cache;

//-------------------------
//
// Methods
//
//-------------------------s
-(HVTypeView *) getView:(NSString *) name;
-(BOOL) putView:(HVTypeView *) view name:(NSString*) name;
-(void) deleteView:(NSString *) name;

-(NSData *) getPersonalImage;
-(BOOL) putPersonalImage:(NSData *) imageData;
-(void) deletePersonalImage;

-(HVStoredQuery *) getStoredQuery:(NSString *) name;
-(BOOL) putStoredQuery:(HVStoredQuery *) query withName:(NSString *) name;
-(void) deleteStoredQuery:(NSString *) name;

-(HVSynchronizedType *) getSynchronizedTypeForTypeID:(NSString *) typeID;

+(NSString *) metadataStoreKey;

-(BOOL) resetMetadata;
-(BOOL) resetData;

-(void) clearCache;
//
// If you are using Offline changes, call this to commit all pending changes to HealthVault
//
-(HVTask *) commitOfflineChangesWithCallback:(HVTaskCompletion) callback;

//
// Must be called to close references
//
-(void) close;

@end

