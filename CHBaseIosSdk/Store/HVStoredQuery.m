//
//  HVStoredQuery.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVStoredQuery.h"
#import "HVClient.h"

static NSString* const c_element_query = @"query";
static NSString* const c_element_result = @"result";
static NSString* const c_element_timestamp = @"timestamp";

@interface HVStoredQuery (HVPrivate)

-(void) getItemsComplete:(HVTask *) task forRecord:(HVRecordReference *) record;

@end

@implementation HVStoredQuery

@synthesize query = m_query;

-(HVItemQueryResult *)result
{
    return m_result;
}

-(void)setResult:(HVItemQueryResult *)result
{
    HVRETAIN(m_result, result);
    self.timestamp = [NSDate date];
}

@synthesize timestamp = m_timestamp;

-(void)dealloc
{
    [m_query release];
    [m_result release];
    [m_timestamp release];
    
    [super dealloc];
}

-(id)initWithQuery:(HVItemQuery *)query
{
    return [self initWithQuery:query andResult:nil];
}

-(id)initWithQuery:(HVItemQuery *)query andResult:(HVItemQueryResult *)result
{
    HVCHECK_NOTNULL(query);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.query = query;
    self.result = result;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(BOOL)isStale:(NSTimeInterval) maxAge
{
    NSDate* now = [NSDate date];
    return ([now timeIntervalSinceDate:m_timestamp] > maxAge);
}

-(HVTask *)synchronizeForRecord:(HVRecordReference *)record withCallback:(HVTaskCompletion)callback
{
    HVCHECK_NOTNULL(m_query);
    HVCHECK_NOTNULL(record);
    
    HVTask* task = [[[HVTask alloc] initWithCallback:callback] autorelease];
    HVCHECK_NOTNULL(task);

    HVGetItemsTask* getItemsTask = [[[HVClient current].methodFactory newGetItemsForRecord:record query:m_query andCallback:^(HVTask *task) {
        [self getItemsComplete:task forRecord:record];
    }] autorelease];
    HVCHECK_NOTNULL(getItemsTask);
    
    [task setNextTask:getItemsTask];
    [task start];
    
    return task;
    
LError:
    return nil;
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_DATE(m_timestamp, c_element_timestamp);
    HVSERIALIZE(m_query, c_element_query);
    HVSERIALIZE(m_result, c_element_result);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_DATE(m_timestamp, c_element_timestamp);
    HVDESERIALIZE(m_query, c_element_query, HVItemQuery);
    HVDESERIALIZE(m_result, c_element_result, HVItemQueryResult);    
}

@end

@implementation HVStoredQuery (HVPrivate)

-(void)getItemsComplete:(HVTask *)task forRecord:(HVRecordReference *)record
{
    HVItemQueryResult* queryResult = ((HVGetItemsTask*) task).queryResult;
    if (!queryResult.hasPendingItems)
    {
        self.result = queryResult;
        return;
    }
    //
    // Populate the query result's pending items
    //
    HVTask* pendingItemsTask = [queryResult createTaskToGetPendingItemsForRecord:record itemView:m_query.view withCallback:^(HVTask *task) {
        
        [task checkSuccess];
        self.result = queryResult;
    }];
    
    [task.parent setNextTask:pendingItemsTask];
}

@end
