//
//  HVRelatedItem.h
//  HVLib
//
//

#import "HVBaseTypes.h"
#import "HVType.h"
#import "HVItemKey.h"
#import "HVCollection.h"

@class HVItem;

@interface HVRelatedItem : HVType
{
@private
    NSString* m_itemID;
    NSString* m_version;
    HVString255* m_clientID;
    NSString* m_relationship;
}

//
// You can have either a key OR a clientID
//
@property (readwrite, nonatomic, retain) NSString* itemID;
@property (readwrite, nonatomic, retain) NSString* version;
@property (readwrite, nonatomic, retain) HVString255* clientID;

@property (readwrite, nonatomic, retain) NSString* relationship;

-(id) initRelationship:(NSString *) relationship toItemWithKey:(HVItemKey *) key;
-(id) initRelationship:(NSString *)relationship toItemWithClientID:(NSString *) clientID;

+(HVRelatedItem *) relationNamed:(NSString *) name toItemKey:(HVItemKey *) item;
+(HVRelatedItem *) relationNamed:(NSString *) name toItem:(HVItem *) key;

@end

@interface HVRelatedItemCollection : HVCollection

-(NSUInteger) indexOfRelation:(NSString *) name;
-(HVRelatedItem *) addRelation:(NSString *) name toItem:(HVItem *) item;

@end