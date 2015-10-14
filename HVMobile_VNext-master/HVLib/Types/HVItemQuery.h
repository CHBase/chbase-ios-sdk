//
//  HVItemQuery.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVInt.h"
#import "HVItemKey.h"
#import "HVItemFilter.h"
#import "HVItemView.h"


@interface HVItemQuery : HVType
{
@private
    NSString* m_name;
    HVStringCollection* m_itemIDs;
    HVItemKeyCollection* m_keys;
    HVStringCollection* m_clientIDs;
    HVItemFilterCollection* m_filters;
    HVItemView* m_view;
    HVInt* m_max;
    HVInt* m_maxFull;    
}

@property (readwrite, nonatomic, retain) NSString* name;
//
// itemIDs, keys, and clientIDs are a CHOICE.
// You can specify items for one only one of them in a single query
// 
@property (readonly, nonatomic) HVStringCollection* itemIDs;
@property (readonly, nonatomic) HVItemKeyCollection* keys;
@property (readonly, nonatomic) HVStringCollection* clientIDs;
//
// constrain results (where clauses
//
@property (readonly, nonatomic) HVItemFilterCollection* filters;
//
// What format to pull data down in
//
@property (readwrite, nonatomic, retain) HVItemView* view;

@property (readwrite, nonatomic) int maxResults;
@property (readwrite, nonatomic) int maxFullResults;

-(id) initWithTypeID:(NSString *) typeID;
-(id) initWithFilter:(HVItemFilter *) filter;
-(id) initWithItemKey:(HVItemKey *) key;
-(id) initWithItemKeys:(NSArray *) keys;
-(id) initWithItemIDs:(NSArray *) ids;
-(id) initwithItemID:(NSString *) itemID;
-(id) initWithPendingItems:(NSArray *) pendingItems;
-(id) initWithItemKey:(HVItemKey *) key andType:(NSString *) typeID;
-(id) initWithItemID:(NSString *) itemID andType:(NSString *) typeID;;
-(id) initWithClientID:(NSString *) clientID andType:(NSString *) typeID;

@end

@interface HVItemQueryCollection : HVCollection 

-(void) addItem:(HVItemQuery *) query;
-(HVItemQuery *) itemAtIndex:(NSUInteger) index;

@end
