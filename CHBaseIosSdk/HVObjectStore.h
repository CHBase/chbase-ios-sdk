//
//  HVObjectStore.h
//  HVLib
//
//

#import <Foundation/Foundation.h>

@protocol HVObjectStore <NSObject>

-(NSEnumerator *) allKeys;

-(NSDate *) createDateForKey:(NSString *) key;
-(NSDate *) updateDateForKey:(NSString *) key;

-(BOOL) keyExists:(NSString *) key;
-(BOOL) deleteKey:(NSString *) key;

-(id) getObjectWithKey:(NSString *) key name:(NSString *) name andClass:(Class) cls;
-(BOOL) putObject:(id) obj withKey:(NSString *) key andName:(NSString *) name;

-(NSData *) getBlob:(NSString *) key;
-(BOOL) putBlob:(NSData *) blob withKey:(NSString *) key;

-(id<HVObjectStore>) newChildStore:(NSString *) name;
-(void) deleteChildStore:(NSString *) name;
-(BOOL) childStoreExists:(NSString *) name;
-(NSEnumerator *) allChildStoreNames;

//
// Tells the store not to serve up objects from any caches, but to refetch from the backing store
//
-(id) refreshAndGetObjectWithKey:(NSString *) key name:(NSString *) name andClass:(Class) cls; 
-(NSData *) refreshAndGetBlob:(NSString *) key;

@optional
-(void) clearCache;

@end
