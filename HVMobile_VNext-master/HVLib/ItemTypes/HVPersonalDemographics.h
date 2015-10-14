//
//  HVPersonalDemographics.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVPersonalDemographics : HVItemDataTyped
{
@private
    HVName* m_name;
    HVDateTime* m_birthdate;
    HVCodableValue* m_bloodType;
    HVCodableValue* m_ethnicity;
    NSString* m_ssn;
    HVCodableValue* m_maritalStatus;
    NSString* m_employmentStatus;
    HVBool* m_isDeceased;
    HVApproxDateTime* m_dateOfDeath;
    HVCodableValue* m_religion;
    HVBool* m_veteran;
    HVCodableValue* m_education;
    HVBool* m_disabled;
    NSString* m_donor;
}

//-------------------------
//
// Data
//
//-------------------------
//
// ALL information is optional
//
@property (readwrite, nonatomic, retain) HVName* name;
@property (readwrite, nonatomic, retain) HVDateTime* birthDate;
@property (readwrite, nonatomic, retain) HVCodableValue* bloodType;
@property (readwrite, nonatomic, retain) HVCodableValue* ethnicity;
@property (readwrite, nonatomic, retain) NSString* ssn;
@property (readwrite, nonatomic, retain) HVCodableValue* maritalStatus;
@property (readwrite, nonatomic, retain) NSString* employmentStatus;
@property (readwrite, nonatomic, retain) HVBool* isDeceased;
@property (readwrite, nonatomic, retain) HVApproxDateTime* dateOfDeath;
@property (readwrite, nonatomic, retain) HVCodableValue* religion;
@property (readwrite, nonatomic, retain) HVBool* isVeteran;
@property (readwrite, nonatomic, retain) HVCodableValue* education;
@property (readwrite, nonatomic, retain) HVBool* isDisabled;
@property (readwrite, nonatomic, retain) NSString* organDonor;

//-------------------------
//
// Initializers
//
//-------------------------
+(HVItem *) newItem;


-(NSString *) toString;

//-------------------------
//
// Vocab
//
//-------------------------
+(HVVocabIdentifier *) vocabForBloodType;
+(HVVocabIdentifier *) vocabForEthnicity;
+(HVVocabIdentifier *) vocabForMaritalStatus;

//-------------------------
//
// Type Information
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;


@end
