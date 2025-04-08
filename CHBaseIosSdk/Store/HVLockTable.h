//
//  HVLockTable.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>

@class HVLockTable;

//
// This lock will automatically release itself when the object is deallocated
//
@interface HVAutoLock : NSObject
{
@private
    long m_lockID;
    HVLockTable* m_lockTable;
    NSString* m_key;
}

@property (readonly, nonatomic) long lockID;
@property (readonly, nonatomic) NSString* key;

-(BOOL) validateLock;
-(void) releaseLock;

@end

@interface HVLockTable : NSObject
{
@private
    NSMutableDictionary* m_locks;
    long m_nextLockId;
}

-(NSArray *) allLockedKeys;
-(BOOL) isKeyLocked:(NSString *) key;

-(BOOL) validateLock:(long) lockID forKey:(NSString *) key;
-(long) acquireLockForKey:(NSString *) key;
-(BOOL) releaseLock:(long) lockID forKey:(NSString *) key;

// Returns nil if lock was not acquired
-(HVAutoLock *) newAutoLockForKey:(NSString *) key;
-(BOOL) validateLock:(HVAutoLock *) lock;

-(NSString *) descriptionOfLockForKey:(NSString *) key;
+(BOOL) isValidLockId:(long) lockID;

@end
