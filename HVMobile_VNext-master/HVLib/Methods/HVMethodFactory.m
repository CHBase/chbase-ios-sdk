//
//  HVMethodFactory.m
//  HVLib
//
//
//
//

#import "HVCommon.h"
#import "HVMethodFactory.h"

@implementation HVMethodFactory

-(HVGetItemsTask *)newGetItemsForRecord:(HVRecordReference *)record queries:(HVItemQueryCollection *)queries andCallback:(HVTaskCompletion)callback
{
    HVGetItemsTask* task = [HVGetItemsTask newForRecord:record queries:queries andCallback:callback];
    task.taskName = @"GetItemsForRecord";
    return task;
}

-(HVPutItemsTask *)newPutItemsForRecord:(HVRecordReference *)record items:(HVItemCollection *)items andCallback:(HVTaskCompletion)callback
{
    HVPutItemsTask* task = [HVPutItemsTask newForRecord:record items:items andCallback:callback];
    task.taskName = @"PutItemsForRecord";
    return task;
}

-(HVRemoveItemsTask *)newRemoveItemsForRecord:(HVRecordReference *)record keys:(HVItemKeyCollection *)keys andCallback:(HVTaskCompletion)callback
{
    HVRemoveItemsTask* task = [HVRemoveItemsTask newForRecord:record keys:keys andCallback:callback];
    task.taskName = @"RemoveItemsForRecord";
    return task;
}

@end

@implementation HVMethodFactory (HVMethodFactoryExtensions)

-(HVGetItemsTask *)newGetItemsForRecord:(HVRecordReference *)record query:(HVItemQuery *)query andCallback:(HVTaskCompletion)callback
{
    HVCHECK_NOTNULL(query);
    
    HVItemQueryCollection* queries = [[HVItemQueryCollection alloc] init];
    HVCHECK_NOTNULL(queries);
    
    [queries addObject:query];
    
    HVGetItemsTask* task = [self newGetItemsForRecord:record queries:queries andCallback:callback];
    [queries release];
    
    return task;
    
LError:
    return nil;
}

-(HVPutItemsTask *)newPutItemForRecord:(HVRecordReference *)record item:(HVItem *)item andCallback:(HVTaskCompletion)callback
{
    HVItemCollection* items = [[HVItemCollection alloc] initwithItem:item];
    HVCHECK_NOTNULL(items);
    
    HVPutItemsTask* putItems = [self newPutItemsForRecord:record items:items andCallback:callback];
    [items release];
    
    return putItems;
    
LError:
    return nil;
}

@end