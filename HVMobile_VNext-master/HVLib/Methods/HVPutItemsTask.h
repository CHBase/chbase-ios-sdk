//
//  HVPutItemsTask.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVMethodCallTask.h"
#import "HVItem.h"

//
// Request: HVItemCollection
// Response: HVItemKeyCollection - keys assigned to the items you put
// 
@interface HVPutItemsTask : HVMethodCallTask
{
    HVItemCollection* m_items;
}

@property (readwrite, nonatomic, retain) HVItemCollection* items;
@property (readonly, nonatomic) BOOL hasItems;

@property (readonly, nonatomic) HVItemKeyCollection* putResults;
@property (readonly, nonatomic) HVItemKey* firstKey;

-(id) initWithItem:(HVItem *) item andCallback:(HVTaskCompletion) callback;
-(id) initWithItems:(HVItemCollection *) items andCallback:(HVTaskCompletion) callback;

+(HVPutItemsTask *) newForRecord:(HVRecordReference *) record item:(HVItem *) item andCallback:(HVTaskCompletion)callback;
+(HVPutItemsTask *) newForRecord:(HVRecordReference *) record items:(HVItemCollection *)items andCallback:(HVTaskCompletion)callback;

@end
