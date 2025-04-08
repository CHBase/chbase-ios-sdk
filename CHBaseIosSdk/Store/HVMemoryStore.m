//
//  HVMemoryStore.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVMemoryStore.h"

@implementation HVMemoryStore

-(id) init
{
    self = [super init];
    HVCHECK_SELF;
    
    m_store = [[NSMutableDictionary alloc] init];
    HVCHECK_NOTNULL(m_store);
    
    m_metadata = [[NSMutableDictionary alloc] init];
    HVCHECK_NOTNULL(m_metadata);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void) dealloc
{
    [m_store release];
    [m_metadata release];
    
    [super dealloc];
}

-(NSEnumerator *)allKeys
{
    return [m_store keyEnumerator];
}

-(BOOL)keyExists:(NSString *)key
{
    return ([m_store objectForKey:key] != nil);
}

-(NSDate *)createDateForKey:(NSString *)key
{
    // Not exactly accurate, but this is a test store..
    return [m_metadata objectForKey:key];
}

-(NSDate *)updateDateForKey:(NSString *)key
{
    return [m_metadata objectForKey:key];
}

-(id)getObjectWithKey:(NSString *)key name:(NSString *)name andClass:(Class)cls
{
    id obj = [m_store objectForKey:key];
    if (obj && [obj isKindOfClass:cls])
    {
        return obj;
    }
    
    return nil;
}

-(NSData *)getBlob:(NSString *)key
{
    id obj = [m_store objectForKey:key];
    if (obj && [obj isKindOfClass:[NSData class]])
    {
        return obj;
    }
    
    return nil;   
}

-(BOOL)putBlob:(NSData *)blob withKey:(NSString *)key
{
    HVCHECK_NOTNULL(key);
    
    [m_store setObject:blob forKey:key];
    [self touchObjectWithKey:key];
    
    return TRUE;

LError:
    return FALSE;
}

-(BOOL)putObject:(id)obj withKey:(NSString *)key andName:(NSString *)name
{
    HVCHECK_NOTNULL(key);
    
    [m_store setObject:obj forKey:key];
    [self touchObjectWithKey:key];
    
    return TRUE;
    
LError:
    return FALSE;
}

-(BOOL)deleteKey:(NSString *)key
{
    [m_store removeObjectForKey:key];
    return TRUE;
}

-(void)touchObjectWithKey:(NSString *)key
{
    [m_metadata setObject:[NSDate date] forKey:key];
    
}

-(id<HVObjectStore>)newChildStore:(NSString *)name
{
    return [[HVMemoryStore alloc] init];
}

-(void)deleteChildStore:(NSString *)name
{
    // Not supported
    NSLog(@"Not supported");
}

-(BOOL)childStoreExists:(NSString *)name
{
    // Not supported
    NSLog(@"Not supported");
    return FALSE;
}

-(NSEnumerator *)allChildStoreNames
{
    // Not supported yet
    return nil;
}

-(id)refreshAndGetObjectWithKey:(NSString *)key name:(NSString *)name andClass:(Class)cls
{
    return [self refreshAndGetObjectWithKey:key name:name andClass:cls];
}

-(NSData *)refreshAndGetBlob:(NSString *)key
{
    return [self getBlob:key];
}

@end
