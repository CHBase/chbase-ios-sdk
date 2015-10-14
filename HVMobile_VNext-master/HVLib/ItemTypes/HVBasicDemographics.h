//
//  HVBasicDemographics.h
//  HVLib
//
//


#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVVocab.h"

enum HVGender 
{
    HVGenderNone = 0,
    HVGenderFemale,
    HVGenderMale
};

NSString* stringFromGender(enum HVGender gender);
enum HVGender stringToGender(NSString* genderString);

//
// Basic demographics contain less private information about the person - and may be
// easier for the user to share with others. 
//
// HVPersonalDemographics contains more personal information that the user may wish to
// keep entirely private. 
//
@interface HVBasicDemographics : HVItemDataTyped
{
@private
    enum HVGender m_gender;
    HVYear* m_birthYear;
    HVCodableValue* m_country;
    NSString* m_postalCode;
    NSString* m_city;
    HVCodableValue* m_state;
    HVInt* m_firstDOW;
    NSString* m_languageXml;
}

//-------------------------
//
// Data
//
//-------------------------
//
// ALL fields are optional
//
@property (readwrite, nonatomic) enum HVGender gender;
@property (readwrite, nonatomic, retain) HVYear* birthYear;
@property (readwrite, nonatomic, retain) HVCodableValue* country;
@property (readwrite, nonatomic, retain) NSString* postalCode;
@property (readwrite, nonatomic, retain) NSString* city;
@property (readwrite, nonatomic, retain) HVCodableValue* state;
@property (readwrite, nonatomic, retain) NSString* languageXml;

//-------------------------
//
// Initializers
//
//-------------------------
+(HVItem *) newItem;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) genderAsString;

//-------------------------
//
// Vocab
//
//-------------------------
+(HVVocabIdentifier *) vocabForGender;

//-------------------------
//
// Type Information
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;

@end
