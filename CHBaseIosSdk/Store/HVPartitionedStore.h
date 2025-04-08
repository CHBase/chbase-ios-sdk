//
//  HVPartitionedStore.h
//  HVLib
//
//
//
//

#import <Foundation/Foundation.h>
#import "HVObjectStore.h"

@interface HVPartitionedObjectStore : NSObject
{
@private
    id<HVObjectStore> m_rootStore;
    NSMutableDictionary* m_partitions;
}

-(id) initWithRoot:(id<HVObjectStore>) root;

-(BOOL) partition:(NSString *) partitionKey keyExists:(NSString *) key;

-(id) partition:(NSString *) partitionKey getObjectWithKey:(NSString *) key name:(NSString *) name andClass:(Class) cls;
-(BOOL) partition:(NSString *) partitionKey putObject:(id) obj withKey:(NSString *) key andName:(NSString *) name;
-(BOOL) partition:(NSString *) partitionKey deleteKey:(NSString *) key;
-(BOOL) deletePartition:(NSString *) partitionKey;
-(NSDate *) partition:(NSString *) partitionKey createDateForKey:(NSString *) key;
-(NSDate *) partition:(NSString *) partitionKey updateDateForKey:(NSString *) key;
-(NSEnumerator *) allPartitionKeys;
-(NSEnumerator *) allKeysInPartition:(NSString *) partitionKey;

-(void) clearCache;

@end
