//
//  HVItemQueryResult.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVItemQueryResult.h"
#import "HVGetItemsTask.h"
#import "HVClient.h"

static NSString* const c_element_item = @"thing";
static NSString* const c_element_pending = @"unprocessed-thing-key-info";
static NSString* const c_attribute_name = @"name";

@interface HVItemQueryResult (HVPrivate)

-(HVGetItemsTask *) newGetTaskFor:(HVPendingItemCollection *)pendingItems forRecord:(HVRecordReference *) record itemView:(HVItemView *) view;
-(BOOL) nextGetPendingItems:(HVPendingItemCollection *)pendingItems forRecord:(HVRecordReference *) record itemView:(HVItemView *) view andParentTask:(HVTask *) parentTask; 
-(void) getItemsComplete:(HVTask *) task forRecord:(HVRecordReference *) record itemView:(HVItemView *) view;

-(void) appendFoundItems:(HVItemCollection *) items;

@end

@implementation HVItemQueryResult

@synthesize items = m_items;
@synthesize pendingItems = m_pendingItems;
@synthesize name = m_name;

-(BOOL) hasItems
{
    return !([NSArray isNilOrEmpty:m_items]);
}

-(BOOL) hasPendingItems
{
    return !([NSArray isNilOrEmpty:m_pendingItems]);
}

-(NSUInteger)itemCount
{
    return (m_items ? m_items.count : 0);
}

-(NSUInteger)pendingCount
{
    return (m_pendingItems ? m_pendingItems.count : 0);
}

-(NSUInteger)resultCount
{
    return (self.itemCount + self.pendingCount);
}

-(void) dealloc
{
    [m_items release];
    [m_pendingItems release];
    [m_name release];
    [super dealloc];
}

-(HVTask *)getPendingItemsForRecord:(HVRecordReference *)record withCallback:(HVTaskCompletion)callback
{
    return [self getPendingItemsForRecord:record itemView:nil withCallback:callback];
}

-(HVTask *)getPendingItemsForRecord:(HVRecordReference *)record itemView:(HVItemView *)view withCallback:(HVTaskCompletion)callback
{
    HVTask* task = [self createTaskToGetPendingItemsForRecord:record itemView:view withCallback:callback];
    if (task)
    {
        [task start];
    }
    return task;    
}

-(HVTask *)createTaskToGetPendingItemsForRecord:(HVRecordReference *)record withCallback:(HVTaskCompletion)callback
{
    return [self createTaskToGetPendingItemsForRecord:record itemView:nil withCallback:callback];
}

-(HVTask *)createTaskToGetPendingItemsForRecord:(HVRecordReference *)record itemView:(HVItemView *)view withCallback:(HVTaskCompletion)callback
{
    HVCHECK_NOTNULL(record);
    
    if (!self.hasPendingItems)
    {
        return nil;
    }
    
    HVTask* task = [[[HVTask alloc] initWithCallback:callback] autorelease];
    HVCHECK_NOTNULL(task);
    
    HVCHECK_SUCCESS([self nextGetPendingItems:self.pendingItems forRecord:record itemView:view andParentTask:task]);
    
    return task;
    
LError:
    return nil;
    
}

-(void) serializeAttributes:(XWriter *)writer
{
    HVSERIALIZE_ATTRIBUTE(m_name, c_attribute_name);
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_ARRAY(m_items, c_element_item);
    HVSERIALIZE_ARRAY(m_pendingItems, c_element_pending);
}

-(void) deserializeAttributes:(XReader *)reader
{
    HVDESERIALIZE_ATTRIBUTE(m_name, c_attribute_name);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_TYPEDARRAY(m_items, c_element_item, HVItem, HVItemCollection);
    HVDESERIALIZE_TYPEDARRAY(m_pendingItems, c_element_pending, HVPendingItem, HVPendingItemCollection);
}

@end

@implementation HVItemQueryResult (HVPrivate)

-(HVGetItemsTask *) newGetTaskFor:(HVPendingItemCollection *)pendingItems forRecord:(HVRecordReference *)record itemView:(HVItemView *) view
{
    HVItemQuery *pendingQuery = [[HVItemQuery alloc] initWithPendingItems:pendingItems];
    HVCHECK_NOTNULL(pendingQuery);
    if (view)
    {
        pendingQuery.view = view;
    }
    HVGetItemsTask* getPendingTask = [[HVClient current].methodFactory newGetItemsForRecord:record query:pendingQuery andCallback:^(HVTask *task){
        
        [self getItemsComplete:task forRecord:record itemView:view];
    
    }];
    
    [pendingQuery release];
    return getPendingTask;

LError:
    return nil;
}

-(BOOL)nextGetPendingItems:(HVPendingItemCollection *)pendingItems forRecord:(HVRecordReference *)record itemView:(HVItemView *) view andParentTask:(HVTask *)parentTask
{
    HVGetItemsTask* getPendingTask = [self newGetTaskFor:pendingItems forRecord:record itemView:view];
    HVCHECK_NOTNULL(getPendingTask);
    
    [parentTask setNextTask:getPendingTask];    
    [getPendingTask release];
    
    return TRUE;
    
LError:
    return FALSE;
}

-(void)getItemsComplete:(HVTask *)task forRecord:(HVRecordReference *)record itemView:(HVItemView *) view
{
    HVGetItemsTask* getItems = (HVGetItemsTask *) task;
    HVItemQueryResult* result = getItems.queryResults.firstResult;
    
    if (result.hasItems)
    {
        //
        // Append items to this query result's item list
        //
        [self appendFoundItems:result.items];
    }
    
    if (!result.hasPendingItems)
    {
        // No more pending items!
        // We can clear the pending items in this query
        HVCLEAR(m_pendingItems);
        return;
    }
    //
    // The pending item query did not return all the items we had requested... MORE pending items!
    // So we have to issue another query
    //
    [self nextGetPendingItems:result.pendingItems forRecord:record itemView:view andParentTask:task.parent];
}

-(void)appendFoundItems:(HVItemCollection *)items
{
    HVENSURE(m_items, HVItemCollection);
    [m_items addObjectsFromArray:items];
}

@end

@implementation HVItemQueryResultCollection 

-(id) init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVItemQueryResult class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVItemQueryResult *)itemAtIndex:(NSUInteger)index
{
    return [self objectAtIndex:index];
}

@end


