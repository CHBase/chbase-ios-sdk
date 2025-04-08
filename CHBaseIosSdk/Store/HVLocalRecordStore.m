//
//  HVLocalRecordStore.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVLocalRecordStore.h"
#import "HVTypeView.h"
#import "HVSynchronizedStore.h"
#import "HVCachingObjectStore.h"
#import "HVStoredQuery.h"
#import "HVItemChangeManager.h"

static NSString* const c_view = @"view";
static NSString* const c_personalImage = @"personalImage";
static NSString* const c_storedQuery = @"storedQuery";

@interface HVLocalRecordStore (HVPrivate)

-(BOOL) ensureMetadataStore;
-(BOOL) ensureDataStore;
-(void) closeDataStore;

-(NSString *) makeViewKey:(NSString *) name;
-(NSString *) makeStoredQueryKey:(NSString *) name;

@end

@implementation HVLocalRecordStore

@synthesize root = m_root;
@synthesize record = m_record;
@synthesize metadata = m_metadata;
-(HVSynchronizedStore *)data
{
    return m_dataMgr.data;
}
@synthesize dataMgr = m_dataMgr;

-(id)initForRecord:(HVRecordReference *)record overRoot:(id<HVObjectStore>)root
{
    return [self initForRecord:record overRoot:root withCache:FALSE];
}

-(id)initForRecord:(HVRecordReference *)record overRoot:(id<HVObjectStore>)root withCache:(BOOL)cache
{
    HVCHECK_NOTNULL(record);
    HVCHECK_NOTNULL(root);
    
    m_cache = cache;
    
    self = [super init];
    HVCHECK_SELF;
    
    m_root = [root newChildStore:record.ID];
    HVCHECK_NOTNULL(m_root);
    
    HVRETAIN(m_record, record);
    
    HVCHECK_SUCCESS([self ensureMetadataStore]);    
    HVCHECK_SUCCESS([self ensureDataStore]);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_record release];
    [m_root release];
    [m_metadata release];
    [m_dataMgr release];
   
    [super dealloc];
}

-(HVTypeView *)getView:(NSString *)name
{
    HVTypeView* view = [m_metadata getObjectWithKey:[self makeViewKey:name] name:c_view andClass:[HVTypeView class]];
    if (view)
    {
        view.store = self;
    }
    return view;
}

-(BOOL)putView:(HVTypeView *)view name:(NSString *)name
{
    return [m_metadata putObject:view withKey:[self makeViewKey:name] andName:c_view];
}

-(void)deleteView:(NSString *)name
{
    [m_metadata deleteKey:[self makeViewKey:name]];
}

-(NSData *)getPersonalImage
{
    return [m_metadata getBlob:c_personalImage];
}

-(BOOL) putPersonalImage:(NSData *)imageData
{
    return [m_metadata putBlob:imageData withKey:c_personalImage];
}

-(void)deletePersonalImage
{
    [m_metadata deleteKey:c_personalImage];
}

-(HVStoredQuery *)getStoredQuery:(NSString *)name
{
    HVStoredQuery* storedQuery = [m_metadata getObjectWithKey:[self makeStoredQueryKey:name] 
                                                                name:c_storedQuery 
                                                                andClass:[HVStoredQuery class]];
 
    return storedQuery;    
}

-(BOOL)putStoredQuery:(HVStoredQuery *)query withName:(NSString *)name
{
    return [m_metadata putObject:query withKey:[self makeStoredQueryKey:name] andName:c_storedQuery];
}

-(void)deleteStoredQuery:(NSString *)name
{
    [m_metadata deleteKey:[self makeStoredQueryKey:name]];    
}

-(HVSynchronizedType *)getSynchronizedTypeForTypeID:(NSString *)typeID
{
    return [m_dataMgr getTypeForTypeID:typeID];
}

+(NSString *)metadataStoreKey
{
    return @"Metadata";
}

-(BOOL)resetMetadata
{
    if (m_dataMgr.changeManager.isBusy)
    {
        return FALSE;
    }

    HVCLEAR(m_metadata);
    [m_root deleteChildStore:[HVLocalRecordStore metadataStoreKey]];
    
    return [self ensureMetadataStore];
}

-(BOOL)resetData
{
    if (m_dataMgr.changeManager.isBusy)
    {
        //
        // Cannot delete store if pending changes are being committed
        //
        return FALSE;
    }
    
    [m_dataMgr reset];
    [self closeDataStore];
    
    return [self ensureDataStore];
}

-(HVTask *)commitOfflineChangesWithCallback:(HVTaskCompletion)callback
{
    return [m_dataMgr.changeManager commitChangesWithCallback:callback];
}

-(void)close
{
    [self closeDataStore];
}

-(void)clearCache
{
    [m_dataMgr clearCache];
}

@end

@implementation HVLocalRecordStore (HVPrivate)

-(BOOL)ensureMetadataStore
{
    if (m_metadata)
    {
        return TRUE;
    }
    
    m_metadata = [m_root newChildStore:[HVLocalRecordStore metadataStoreKey]];
    HVCHECK_NOTNULL(m_metadata);
    
    return TRUE;
    
LError:
    return FALSE;
}

-(BOOL) ensureDataStore
{
    if (m_dataMgr)
    {
        return TRUE;
    }
    
    m_dataMgr = [[HVSynchronizationManager alloc] initForRecordStore:self withCache:m_cache];
    HVCHECK_NOTNULL(m_dataMgr);
    
    return TRUE;
    
LError:
    return FALSE;
}

-(void)closeDataStore
{
    if (m_dataMgr)
    {
        [m_dataMgr close];
    }
    HVCLEAR(m_dataMgr);
}

-(NSString *)makeViewKey:(NSString *)name
{
    return [name stringByAppendingString:c_view];
}

-(NSString *)makeStoredQueryKey:(NSString *)name
{
    return [name stringByAppendingString:c_storedQuery];    
}

@end
