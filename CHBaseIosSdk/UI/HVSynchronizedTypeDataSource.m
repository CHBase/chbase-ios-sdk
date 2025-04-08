//
//  HVSynchronizedTypeDataSource.m
//  HVLib
//
//
//
//

#import "HVCommon.h"
#import "HVSynchronizedTypeDataSource.h"

@interface HVSynchronizedTypeDataSource (HVPrivate)

-(void) subscribe;
-(void) unsubscribe;

-(void) onItemsAvailable:(NSNotification *) event;
-(void) onKeysNotAvailable:(NSNotification *) event;
-(void) onSyncCompleted:(NSNotification *) event;

@end

@implementation HVSynchronizedTypeDataSource

@synthesize type = m_type;

-(id)init
{
    return [self initForTable:nil withType:nil];
}

-(id)initForTable:(UITableView *)table andView:(id<HVTypeView>)view
{
    return [self initForTable:table withType:(HVSynchronizedType *) view];
}

-(id)initForTable:(UITableView *)table withType:(HVSynchronizedType *)type
{
    HVCHECK_NOTNULL(table);
    HVCHECK_NOTNULL(type);
    
    self = [super initForTable:table andView:type];
    HVCHECK_SELF;
    
    HVRETAIN(m_type, type);
    
    [self subscribe];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [self unsubscribe];
    
    [m_type release];
    [super dealloc];
}

//------------------------------
//
// HVSynchronizedTypeDelegate
//
//------------------------------
-(void)synchronizedType:(HVSynchronizedType *)type itemsAvailable:(HVItemCollection *)items typeChanged:(BOOL)changed
{
    if (changed)
    {
        [self reloadAllItems];
    }
    else
    {
        [self reloadItems:items];
    }
}

-(void)synchronizedType:(HVSynchronizedType *)type keysNotAvailable:(NSArray *)keys
{
    [self reloadAllItems];
}

-(void)synchronizedTypeSyncCompleted:(HVSynchronizedType *)type
{
    [self reloadAllItems];
}

-(void)synchronizedType:(HVSynchronizedType *)type syncFailedWithError:(id)ex
{
    
}

@end

@implementation HVSynchronizedTypeDataSource (HVPrivate)

-(void)subscribe
{
    [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(onItemsAvailable:)
         name:HVSynchronizedTypeItemsAvailableNotification
         object:m_type
     ];
    
    [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(onKeysNotAvailable:)
         name:HVSynchronizedTypeKeysNotAvailableNotification
         object:m_type
     ];
    
    [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(onSyncCompleted:)
         name:HVSynchronizedTypeSyncCompletedNotification
         object:m_type
     ];

}

-(void)unsubscribe
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)onItemsAvailable:(NSNotification *)event
{
    HVASSERT([NSThread isMainThread]);

    [self synchronizedType:event.object
        itemsAvailable:[event.userInfo objectForKey:@"items"]
        typeChanged:[event.userInfo boolValueForKey:@"viewChanged"]
     ];
}

-(void)onKeysNotAvailable:(NSNotification *)event
{
    HVASSERT([NSThread isMainThread]);

    [self synchronizedType:event.object
        keysNotAvailable:[event.userInfo objectForKey:@"keys"]
    ];
}

-(void)onSyncCompleted:(NSNotification *)event
{
    HVASSERT([NSThread isMainThread]);

    [self synchronizedTypeSyncCompleted:event.object];
}

@end
