//
//  HVRelative.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVCodableValue.h"
#import "HVPerson.h"
#import "HVApproxDate.h"
#import "HVVocab.h"

@interface HVRelative : HVType
{
@private
    HVCodableValue* m_relationship;
    HVPerson* m_person;
    HVApproxDate* m_dateOfBirth;
    HVApproxDate* m_dateOfDeath;
    HVCodableValue* m_regionOfOrigin;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) - Mom, Dad, uncle etc
// Vocabulary: personal-relationship
//
@property (readwrite, nonatomic, retain) HVCodableValue* relationship;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVPerson* person;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVApproxDate* dateOfBirth;
// 
// (Optional)
//
@property (readwrite, nonatomic, retain) HVApproxDate* dateOfDeath;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVCodableValue* regionOfOrigin;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithRelationship:(NSString *) relationship;
-(id) initWithPerson:(HVPerson *) person andRelationship:(HVCodableValue *) relationship;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;

//-------------------------
//
// Vocab
//
//-------------------------
+(HVVocabIdentifier *) vocabForRelationship;  
+(HVVocabIdentifier *) vocabForRegionOfOrigin;  

@end
