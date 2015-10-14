//
//  HVPersonalContactInfo.h
//  HVLib
//
//


#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVPersonalContactInfo : HVItemDataTyped
{
@private
    HVContact* m_contact;
}

//-------------------------
//
// Data
//
//-------------------------
@property (readwrite, nonatomic, retain) HVContact* contact;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithContact:(HVContact *) contact;

+(HVItem *) newItem;

//-------------------------
//
// Type Info
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;

@end
