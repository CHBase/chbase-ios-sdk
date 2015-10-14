//
//  HVBatchItemDownloader.h
//  HVLib
//
//
//
//

#import <Foundation/Foundation.h>
#import "HVTypeView.h"

//
// Efficiently downloads items in batches, minimizing roundtrops
// Currently, batch sizes should be <= 250. Currently, the server will only return max 250 items at a time
//
@interface HVBatchItemDownloader : NSObject
{
@private
    HVLocalRecordStore* m_store;
    NSMutableArray* m_keysToDownload;
    NSMutableArray* m_keyBatch;
    NSUInteger m_batchSize;
}

@property (readwrite, nonatomic) NSUInteger batchSize;
@property (readonly, nonatomic) NSMutableArray* keysToDownload;

-(id) initWithRecordStore:(HVLocalRecordStore *) store;

-(BOOL) addKeyToDownload:(HVItemKey *)key;
//
// These methods only download items if the item is NOT available locally
//
-(BOOL) addKeyForItemToEnsureDownloaded:(HVItemKey *) key;
-(BOOL) addRangeOfKeysToEnsureDownloaded:(NSRange) range inView:(id<HVTypeView>) view;

//
// Returns nil if no task started
//
-(HVTask *) downloadWithCallback:(HVTaskCompletion) callback;

@end
