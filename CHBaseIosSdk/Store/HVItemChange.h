//
//  HVItemChange.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "XLib.h"
#import "HVItem.h"

enum HVItemChangeType
{
    HVItemChangeTypePut,
    HVItemChangeTypeRemove
};

@interface HVItemChange : XSerializableType
{
@private
    enum HVItemChangeType m_changeType;
    NSTimeInterval m_timestamp;
    int m_attempt;

    NSString* m_changeID;
    NSString* m_typeID;
    HVItemKey* m_key;
    HVItemKey* m_updatedKey;
    HVItem* m_localItem;
    HVItem* m_updatedItem;
}

@property (readonly, nonatomic) enum HVItemChangeType changeType;
@property (readonly, nonatomic) NSString* changeID;
@property (readonly, nonatomic) NSTimeInterval timestamp;
@property (readonly, nonatomic) NSString* typeID;
@property (readonly, nonatomic) NSString* itemID;
@property (readonly, nonatomic) HVItemKey* itemKey;

@property (readwrite, nonatomic, retain) HVItemKey* updatedKey;

// The item whose changes are being comitted. Reserved for internal use only
@property (readwrite, nonatomic, retain) HVItem* localItem;
@property (readwrite, nonatomic, retain) HVItem* updatedItem;

@property (readwrite, nonatomic) int attemptCount;

-(id) initWithTypeID:(NSString *) typeID key:(HVItemKey *) key changeType:(enum HVItemChangeType) changeType;

-(void) assignNewChangeID;
-(void) assignNewTimestamp;
-(BOOL) isChangeForType:(NSString *) typeID;

+(BOOL) updateChange:(HVItemChange *) change withTypeID:(NSString *) typeID key:(HVItemKey *) key changeType:(enum HVItemChangeType) changeType;
+(NSComparisonResult) compareChange:(HVItemChange *) x to:(HVItemChange *) y;

@end
