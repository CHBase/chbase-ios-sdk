//
//  HVCachingObjectStore.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVObjectStore.h"

//
// Places a transparent caching facade over an inner object store
//
@interface HVCachingObjectStore : NSObject <HVObjectStore, NSCacheDelegate>
{
@private
    NSCache* m_cache;
    id<HVObjectStore> m_inner;
}

-(id)initWithObjectStore:(id<HVObjectStore>) store;

//
// Cache specific methods
//
-(void) deleteKeyFromCache:(NSString *) key;
-(void) clear __deprecated;  // OBSOLETE. Use clearCache instead
-(void) clearCache;
-(void) setCacheLimitCount:(NSNumber *) count;

@end
