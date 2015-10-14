//
//  HVVocabIdentifier.h
//  HVLib
//
//

#import "HVType.h"
#import "HVCodableValue.h"

extern NSString* const c_rxNormFamily;
extern NSString* const c_snomedFamily;
extern NSString* const c_hvFamily;
extern NSString* const c_icdFamily;
extern NSString* const c_hl7Family;
extern NSString* const c_isoFamily;
extern NSString* const c_usdaFamily;

@interface HVVocabIdentifier : HVType
{
@private
    NSString* m_name;
    NSString* m_family;
    NSString* m_version;
    NSString* m_lang;
    NSString* m_codeValue;
    
    NSString* m_keyString;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) - the vocabulary name. E.g Rx Norm Active Medications
//
@property (readwrite, nonatomic, retain) NSString* name;
//
// (Optional) - e.g. RxNorm...
//
@property (readwrite, nonatomic, retain) NSString* family;
//
// (Optional) Vocabulary version
//
@property (readwrite, nonatomic, retain) NSString* version;
//
// (Optional) Language, in ISO code. E.g. 'en'. 
//
@property (readwrite, nonatomic, retain) NSString* language;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) NSString* codeValue;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithFamily:(NSString *) family andName:(NSString *) name;

//-------------------------
//
// Methods
//
//-------------------------
//
// Create a codedValue for the vocabItem
//
-(HVCodedValue *) codedValueForItem:(HVVocabItem *) vocabItem;
-(HVCodedValue *) codedValueForCode:(NSString *) code;
-(HVCodableValue *) codableValueForText:(NSString *) text andCode:(NSString *) code;
//
// Generate a single string representing this vocab identifier
//
-(NSString *) toKeyString;

@end

@interface HVVocabIdentifierCollection :  HVCollection 

@end