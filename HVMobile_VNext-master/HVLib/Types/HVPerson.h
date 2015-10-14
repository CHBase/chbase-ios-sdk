//
//  HVPerson.h
//  HVLib
//
//

#import "HVType.h"
#import "HVCodableValue.h"
#import "HVContact.h"
#import "HVName.h"

@interface HVPerson : HVType
{
@private
    HVName* m_name;
    NSString* m_organization;
    NSString* m_training;
    NSString* m_id;
    HVContact* m_contact;
    HVCodableValue* m_type;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) Person's name
//
@property (readwrite, nonatomic, retain) HVName* name;
//
// (Optional) 
//
@property (readwrite, nonatomic, retain) NSString* organization;
//
// (Optional) 
//
@property (readwrite, nonatomic, retain) NSString* training;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) NSString* idNumber;
//
// (Optional) Contact information
//
@property (readwrite, nonatomic, retain) HVContact* contact;
//
// (Optional) 
// Vocabulary: person-types
//
@property (readwrite, nonatomic, retain) HVCodableValue* type;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithName:(NSString *) name andPhone:(NSString *) number;
-(id) initWithName:(NSString *)name andEmail:(NSString *)email;
-(id) initWithName:(NSString *)name phone:(NSString *) number andEmail:(NSString *)email;

-(id) initWithFirstName:(NSString *) first lastName:(NSString *) last andPhone:(NSString *) number;
-(id) initWithFirstName:(NSString *) first lastName:(NSString *) last andEmail:(NSString *)email;
-(id) initWithFirstName:(NSString *) first lastName:(NSString *) last phone:(NSString *) phone andEmail:(NSString *)email;


//-------------------------
//
// Vocab
//
//-------------------------
+(HVVocabIdentifier *) vocabForPersonType;

//-------------------------
//
// Text
//
//-------------------------
//
// Returns the person's full name, if any
//
-(NSString *) toString;

@end
