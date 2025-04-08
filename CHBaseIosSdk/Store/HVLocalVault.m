//
//  HVLocalVault.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVLocalVault.h"
#import "XLib.h"
#import "HVCachingObjectStore.h"
#import "HVClient.h"
#import "HVItemChangeManager.h"


@interface HVLocalVaultOfflineChangesCommitter : HVTaskSequence
{
@private
    NSMutableArray* m_records;
    HVLocalVault* m_localVault;
}

-(id) initWithLocalVault:(HVLocalVault *)vault andRecordReferences:(NSArray *) recordRefs;

@end

@interface HVLocalVault (HVPrivate)

-(void) setRoot:(HVDirectory *) root;
-(BOOL) ensureRecordStores;
-(BOOL) ensureVocabStores;

-(void) close;

@end

@implementation HVLocalVault

@synthesize root = m_root;
@synthesize vocabs = m_vocabs;

-(id)init
{
    return [self initWithRoot:nil];
}

-(id)initWithRoot:(HVDirectory *)root
{
    return [self initWithRoot:root andCache:FALSE];
}

-(id)initWithRoot:(HVDirectory *)root andCache:(BOOL)cache
{
    HVCHECK_NOTNULL(root);
    
    self = [super init];
    HVCHECK_SELF;
    
    m_cache = cache;
    self.root = root;
    
    HVCHECK_SUCCESS([self ensureRecordStores]);
    HVCHECK_SUCCESS([self ensureVocabStores]);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [self close];
    
    [m_root release];
    [m_recordStores release];
    [m_vocabs release];
    
    [super dealloc];
}

-(HVLocalRecordStore *)getRecordStore:(HVRecordReference *)record
{
    HVCHECK_NOTNULL(record);
    
    @synchronized(m_recordStores)
    {
        HVLocalRecordStore* recordStore = [m_recordStores objectForKey:record.ID];
        if (!recordStore)
        {
            recordStore = [[HVLocalRecordStore alloc] initForRecord:record overRoot:m_root withCache:m_cache];
            [m_recordStores setObject:recordStore forKey:record.ID];
            [recordStore release];
        }
        
        return recordStore;
    }

LError:
    return nil;
}

-(BOOL)deleteRecordStore:(HVRecordReference *)record
{
    HVCHECK_NOTNULL(record);

    NSString* recordID = record.ID;
    @synchronized(m_recordStores)
    {
        HVLocalRecordStore* recordStore = [m_recordStores objectForKey:recordID];
        if (recordStore)
        {
            if (recordStore.dataMgr.changeManager.isBusy)
            {
                return FALSE;
            }
            
            [m_recordStores removeObjectForKey:recordID];
            [m_root deleteChildStore:recordID];
        }
    }
    
    return TRUE;
    
LError:
    return FALSE;
}

-(void)resetDataStoreForRecords:(NSArray *)records
{
    @synchronized(m_recordStores)
    { 
        for (HVRecordReference* record in records)
        {
            HVLocalRecordStore* recordStore = [self getRecordStore:record];
            if (recordStore)
            {
                [recordStore resetData];
            }
        }
    }
}

-(void)didReceiveMemoryWarning
{
    [self clearCache];
}

-(void)clearCache
{
    NSArray* stores;
    @synchronized(m_recordStores)
    {
        stores = [m_recordStores allValues];
    }
    
    if (stores)
    {
        for (HVLocalRecordStore* recordStore in stores)
        {
            [recordStore clearCache];
        }
    }
    
    if (m_vocabs && [m_vocabs.store respondsToSelector:@selector(clearCache)])
    {
        [m_vocabs.store performSelector:@selector(clearCache)];
    }
}

-(HVTask *)commitOfflineChangesWithCallback:(HVTaskCompletion)callback
{
    return [self commitOfflineChangesForRecords:[HVClient current].records withCallback:callback];
}

-(HVTask *)commitOfflineChangesForRecords:(NSArray *)records withCallback:(HVTaskCompletion)callback
{
    HVLocalVaultOfflineChangesCommitter* committer = [[[HVLocalVaultOfflineChangesCommitter alloc] initWithLocalVault:self andRecordReferences:records] autorelease];
    HVCHECK_NOTNULL(committer);
    
    return [HVTaskSequence run:committer callback:callback];
    
LError:
    return nil;
}

@end

@implementation HVLocalVault (HVPrivate)
-(void)setRoot:(HVDirectory *)root
{
    HVRETAIN(m_root, root);
}

-(BOOL)ensureRecordStores
{
    if (m_recordStores)
    {
        return TRUE;
    }
 
    m_recordStores = [[NSMutableDictionary alloc] initWithCapacity:2];
    HVCHECK_NOTNULL(m_recordStores);
    
    return TRUE;
    
LError:
    return FALSE;
}

-(BOOL)ensureVocabStores
{
    if (m_vocabs)
    {
        return TRUE;
    }
    
    id<HVObjectStore> vocabObjectStore = [m_root newChildStore:@"vocabs"];
    HVCHECK_NOTNULL(vocabObjectStore);
    
    if (m_cache)
    {
        id<HVObjectStore> cachingDataStore = [[HVCachingObjectStore alloc] initWithObjectStore:vocabObjectStore];
        [vocabObjectStore release];
        HVCHECK_NOTNULL(cachingDataStore);
        
        vocabObjectStore = cachingDataStore;
    }
    
    m_vocabs = [[HVLocalVocabStore alloc] initWithObjectStore:vocabObjectStore];
    [vocabObjectStore release];
    HVCHECK_NOTNULL(m_vocabs);
    
    return TRUE;
    
LError:
    return FALSE;
}

-(void)close
{
    if (!m_recordStores)
    {
        return;
    }
    
    NSEnumerator* stores = m_recordStores.objectEnumerator;
    HVLocalRecordStore* store = nil;
    while ((store = stores.nextObject) != nil)
    {
        [store close];
    }
}

@end

@implementation HVLocalVaultOfflineChangesCommitter

-(id) init
{
    return [self initWithLocalVault:[HVClient current].localVault andRecordReferences:[HVClient current].records];
}

-(id)initWithLocalVault:(HVLocalVault *)vault andRecordReferences:(NSArray *)recordRefs
{
    HVCHECK_NOTNULL(vault);
    HVCHECK_NOTNULL(recordRefs);
    
    self = [super init];
    HVCHECK_SELF;
    
    m_records = [[NSMutableArray alloc] initWithCapacity:recordRefs.count];
    for (HVRecordReference* recordRef in recordRefs)
    {
        [m_records addObject:recordRef];
    }
    
    HVRETAIN(m_localVault, vault);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_localVault release];
    [m_records release];
    
    [super dealloc];
}

-(HVTask *)nextTask
{
    while (TRUE)
    {
        HVRecordReference* nextRecord = [m_records dequeueObject];
        if (!nextRecord)
        {
            break;
        }
        
        HVLocalRecordStore* recordStore = [m_localVault getRecordStore:nextRecord];
        if (recordStore)
        {
            HVTask* task = [[recordStore.dataMgr.changeManager newCommitChangesTaskWithCallback:^(HVTask *task) {
                
                [task checkSuccess];
                
            }] autorelease];
            
            if (task)
            {
                return task;
            }
            //
            // Nil indicates changes manager is busy
            //
        }
    }
    
    return nil;
}

@end