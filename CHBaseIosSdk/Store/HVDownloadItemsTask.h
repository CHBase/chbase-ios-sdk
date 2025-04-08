//
//  HVDownloadItemsTask.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVAsyncTask.h"
#import "HVItemStore.h"

@interface HVDownloadItemsTask : HVTask
{
@private
    NSMutableArray* m_downloadedKeys;
}

@property (readonly, nonatomic) BOOL didKeysDownload;
@property (readonly, nonatomic) NSMutableArray* downloadedKeys;
@property (readonly, nonatomic) HVItemKey* firstKey;

-(void) recordItemsAsDownloaded:(HVItemCollection *) items;

@end
