//
//  HVRecordReference.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVRecordReference.h"
#import "HVClient.h"

static NSString* const c_attribute_id = @"id";
static NSString* const c_attribute_personID = @"person-id";

@implementation HVRecordReference

@synthesize ID = m_id;
@synthesize personID = m_personID;

-(void) dealloc
{
    [m_id release];
    [m_personID release];
    [super dealloc];
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE_STRING(m_id, HVClientError_InvalidRecordReference);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void) serializeAttributes:(XWriter *)writer
{
    HVSERIALIZE_ATTRIBUTE(m_id, c_attribute_id);
    HVSERIALIZE_ATTRIBUTE(m_personID, c_attribute_personID);
}

-(void) deserializeAttributes:(XReader *)reader
{
    HVDESERIALIZE_ATTRIBUTE(m_id, c_attribute_id);
    HVDESERIALIZE_ATTRIBUTE(m_personID, c_attribute_personID);
}

@end

@implementation HVRecordReference (HVMethods)

-(HVGetItemsTask *)getItemsForClass:(Class)cls callback:(HVTaskCompletion)callback
{
    NSString* typeID = [[HVTypeSystem current] getTypeIDForClassName:NSStringFromClass(cls)];
    if (!typeID)
    {
        return nil;
    }
    
    return [self getItemsForType:typeID callback:callback];
}

-(HVGetItemsTask *)getItemsForType:(NSString *)typeID callback:(HVTaskCompletion)callback
{
    HVItemQuery *query = [[HVItemQuery alloc] initWithTypeID:typeID];
    HVCHECK_NOTNULL(query);
    
    HVGetItemsTask* task = [self getItems:query callback:callback];
    [query release];
    
    return task;
    
LError:
    return nil;
}

-(HVGetItemsTask *)getPendingItems:(HVPendingItemCollection *)items callback:(HVTaskCompletion)callback
{
    return [self getPendingItems:items ofType:nil callback:callback];
}

-(HVGetItemsTask *)getPendingItems:(HVPendingItemCollection *)items ofType:(NSString *)typeID callback:(HVTaskCompletion)callback
{
    HVItemQuery *query = [[[HVItemQuery alloc] initWithPendingItems:items] autorelease];
    HVCHECK_NOTNULL(query);

    if (![NSString isNilOrEmpty:typeID])
    {
        [query.view.typeVersions addObject:typeID];
    }

    return [self getItems:query callback:callback];
    
LError:
    return nil;    
}

-(HVGetItemsTask *)getItemWithKey:(HVItemKey *)key callback:(HVTaskCompletion)callback
{
    return [self getItemWithKey:key ofType:nil callback:callback];
}

-(HVGetItemsTask *)getItemWithKey:(HVItemKey *)key ofType:(NSString *)typeID callback:(HVTaskCompletion)callback
{
    HVItemQuery *query = [[[HVItemQuery alloc] initWithItemKey:key andType:typeID] autorelease];
    HVCHECK_NOTNULL(query);

    return [self getItems:query callback:callback];
    
LError:
    return nil;    
}

-(HVGetItemsTask *)getItemWithID:(NSString *)itemID callback:(HVTaskCompletion)callback
{
    return [self getItemWithID:itemID ofType:nil callback:callback];
}

-(HVGetItemsTask *)getItemWithID:(NSString *)itemID ofType:(NSString *)typeID callback:(HVTaskCompletion)callback
{
    HVItemQuery *query = [[[HVItemQuery alloc] initWithItemID:itemID andType:typeID] autorelease];
    HVCHECK_NOTNULL(query);
    
    return [self getItems:query callback:callback];
    
LError:
    return nil;    
}

-(HVGetItemsTask *)getItems:(HVItemQuery *)query callback:(HVTaskCompletion)callback
{
    HVGetItemsTask* task = [[[HVClient current].methodFactory newGetItemsForRecord:self query:query andCallback:callback] autorelease];
    HVCHECK_NOTNULL(task);
    
    [task start];
    return task;
    
LError:
    return nil;
}

-(HVPutItemsTask *)newItem:(HVItem *)item callback:(HVTaskCompletion)callback
{
    HVCHECK_NOTNULL(item);
    
    [item prepareForNew];
    
    return [self putItem:item callback:callback];
    
LError:
    return nil;
}

-(HVPutItemsTask *)newItems:(HVItemCollection *)items callback:(HVTaskCompletion)callback
{
    HVCHECK_NOTNULL(items);
    
    [items prepareForNew];
    return [self putItems:items callback:callback];

LError:
    return nil;
}

-(HVPutItemsTask *)putItem:(HVItem *)item callback:(HVTaskCompletion)callback
{
    HVCHECK_NOTNULL(item);
    
    HVItemCollection* items = [[HVItemCollection alloc] initwithItem:item];
    HVCHECK_NOTNULL(items);
    
    HVPutItemsTask* task = [self putItems:items callback:callback];
    [items release];
    
    return task;
    
LError:
    return nil;
}

-(HVPutItemsTask *)putItems:(HVItemCollection *)items callback:(HVTaskCompletion)callback
{
    HVPutItemsTask* task = [[[HVClient current].methodFactory newPutItemsForRecord:self items:items andCallback:callback] autorelease];
    HVCHECK_NOTNULL(task);
    
    [task start];
    return task;

LError:
    return nil;
}

-(HVPutItemsTask *)updateItem:(HVItem *)item callback:(HVTaskCompletion)callback
{
    [item prepareForUpdate];
    return [self putItem:item callback:callback];
}

-(HVPutItemsTask *)updateItems:(HVItemCollection *)items callback:(HVTaskCompletion)callback
{
    [items prepareForUpdate];
    return [self putItems:items callback:callback];
}

-(HVRemoveItemsTask *)removeItemWithKey:(HVItemKey *)key callback:(HVTaskCompletion)callback
{
    HVItemKeyCollection* keys = [[[HVItemKeyCollection alloc] initWithKey:key] autorelease];
    HVCHECK_NOTNULL(keys);
    
    return [self removeItemsWithKeys:keys callback:callback];
    
LError:
    return nil;
}

-(HVRemoveItemsTask *)removeItemsWithKeys:(HVItemKeyCollection *)keys callback:(HVTaskCompletion)callback
{
    HVRemoveItemsTask* task = [[[HVClient current].methodFactory newRemoveItemsForRecord:self keys:keys andCallback:callback] autorelease];
    HVCHECK_NOTNULL(task);

    [task start];
    return task;
    
LError:
    return nil;
}

@end