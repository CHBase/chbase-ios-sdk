//
//  HVFamilyHistory.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVVocab.h"

@interface HVFamilyHistory : HVItemDataTyped
{
@private
    HVRelative* m_relative;
    HVConditionEntryCollection* m_conditions;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Optional) Relative 
//
@property (readwrite, nonatomic, retain) HVRelative* relative;
//
// (Optional) Any conditions this relative had
//
@property (readwrite, nonatomic, retain) HVConditionEntryCollection* conditions;
//
// Convenience 
//
@property (readonly, nonatomic) BOOL hasConditions;
@property (readonly, nonatomic) HVConditionEntry* firstCondition;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithRelative:(HVRelative *) relative andCondition:(HVConditionEntry *) condition;

+(HVItem *) newItem;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;

//-------------------------
//
// Type info
//
//-------------------------

+(NSString *) typeID;
+(NSString *) XRootElement;

@end
