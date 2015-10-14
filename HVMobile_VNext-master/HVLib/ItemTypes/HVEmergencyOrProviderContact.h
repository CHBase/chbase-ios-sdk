//
//  HVEmergencyOrProviderContact.h
//  HVLib
//
//


#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVVocab.h"

@interface HVEmergencyOrProviderContact : HVItemDataTyped
{
@private
    HVPerson* m_person;
}

//-------------------------
//
// Data
//
//-------------------------
@property (readwrite, nonatomic, retain) HVPerson* person;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithPerson:(HVPerson *) person;

+(HVItem *) newItem;

//-------------------------
//
// Type info
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;


@end
