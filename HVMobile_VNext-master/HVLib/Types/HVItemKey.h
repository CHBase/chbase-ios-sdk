//
//  HVItemKey.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"

@interface HVItemKey : HVType
{
@private
    NSString* m_id;
    NSString* m_version;
}

@property (readwrite, nonatomic, retain) NSString* itemID;
@property (readwrite, nonatomic, retain) NSString* version;
@property (readonly, nonatomic) BOOL hasVersion;

-(id) initNew;
-(id) initWithID:(NSString *) itemID;
-(id) initWithID:(NSString *) itemID andVersion:(NSString *) version;
-(id) initWithKey:(HVItemKey *) key;

-(BOOL) isVersion:(NSString *) version;
-(BOOL) isLocal;

-(BOOL) isEqualToKey:(HVItemKey *) key;

+(HVItemKey *) local;
+(HVItemKey *) newLocal;

@end

@interface HVItemKeyCollection : HVCollection <XSerializable>

-(id) initWithKey:(HVItemKey *) key;

-(void) addItem:(HVItemKey *) key;

-(HVItemKey *) firstKey;
-(HVItemKey *) itemAtIndex:(NSUInteger) index;

-(HVClientResult *) validate;

@end