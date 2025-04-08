//
//  HVRemoveItemsTask.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVMethodCallTask.h"
#import "HVItemKey.h"

//
// Request: HVItemKeyCollection - keys to remove
// Response: Nothing
//
@interface HVRemoveItemsTask : HVMethodCallTask
{
    HVItemKeyCollection* m_keys;
}

@property (readwrite, nonatomic, retain) HVItemKeyCollection* keys;
@property (readonly, nonatomic) BOOL hasKeys;

-(id) initWithKey:(HVItemKey *) key andCallback:(HVTaskCompletion) callback;
-(id) initWithKeys:(HVItemKeyCollection *) keys andCallback:(HVTaskCompletion) callback;

+(HVRemoveItemsTask *)newForRecord:(HVRecordReference *)record key:(HVItemKey *)key callback:(HVTaskCompletion)callback;
+(HVRemoveItemsTask *)newForRecord:(HVRecordReference *) record keys:(HVItemKeyCollection *)keys andCallback:(HVTaskCompletion)callback;

@end
