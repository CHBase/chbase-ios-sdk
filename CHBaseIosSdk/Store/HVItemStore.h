//
//  HVItemStore.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVItem.h"
#import "HVTypeViewItems.h"

@protocol HVItemStore <NSObject>

-(NSEnumerator *) allKeys;

-(BOOL) existsItem:(NSString *) itemID;
-(HVItem *) getItem:(NSString *) itemID;
-(BOOL) putItem:(HVItem *) item;
-(void) removeItem:(NSString *) itemID;
//
// If item is cached, refreshes it from the primary store first
//
-(HVItem *) refreshAndGetItem:(NSString *) itemID;
//
// Clear any in-memory caches to free up memory
//
-(void) clearCache;
-(void) deleteKeyFromCache:(NSString *) itemID;
// If the cache supports a max count limit, sets it...
-(void) setCacheLimitCount:(NSInteger) cacheSize;

@end
