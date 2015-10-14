//
//  HVProcedure.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVVocab.h"

@interface HVProcedure : HVItemDataTyped
{
@private
    HVApproxDateTime* m_when;
    HVCodableValue* m_name;
    HVCodableValue* m_anatomicLocation;
    HVPerson* m_primaryProvider;
    HVPerson* m_secondaryProvider;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required)
// Vocabulary: SNOMED (SnomedProcedures-Filtered)
//
@property (readwrite, nonatomic, retain) HVCodableValue* name;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVApproxDateTime* when;
//
// (Optional)
// Vocabulary: (SnomedBodyLocations-Filtered)
//
@property (readwrite, nonatomic, retain) HVCodableValue* anatomicLocation;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVPerson* primaryProvider;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVPerson* secondaryProvider;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithName:(NSString *) name;

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

+(HVItem *) newItem;

@end
