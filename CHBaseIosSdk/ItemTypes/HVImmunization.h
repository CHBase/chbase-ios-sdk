//
//  HVImmunization.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVVocab.h"

@interface HVImmunization : HVItemDataTyped
{
@private
    HVCodableValue* m_name;
    HVApproxDateTime* m_administeredDate;
    HVPerson* m_administrator;
    HVCodableValue* m_manufacturer;
    NSString* m_lot;
    HVCodableValue* m_route;
    HVApproxDate* m_expiration;
    NSString* m_sequence;
    HVCodableValue* m_anatomicSurface;
    NSString* m_adverseEvent;
    NSString* m_consent;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) immunization name
// Vocabularies: vaccines-cvx (HL7), immunizations, immunizations-common
//
@property (readwrite, nonatomic, retain) HVCodableValue* name;
//
// (Optional) when the immunization was given
//
@property (readwrite, nonatomic, retain) HVApproxDateTime* administeredDate;
//
// (Optional) who gave it
//
@property (readwrite, nonatomic, retain) HVPerson* administrator;
//
// (Optional) Immunization made by
// Vocabularies: vaccine-manufacturers-mvx (HL7)
//
@property (readwrite, nonatomic, retain) HVCodableValue* manufacturer;
//
// (Optional) Lot #
//
@property (readwrite, nonatomic, retain) NSString* lot;
//
// (Optional) how the immunization was given
// Vocabulary: immunization-routes
//
@property (readwrite, nonatomic, retain) HVCodableValue* route;
//
// (Optional) Expiration date
//
@property (readwrite, nonatomic, retain) HVApproxDate* expiration;
//
// (Optional) Sequence #
//
@property (readwrite, nonatomic, retain) NSString* sequence;
//
// (Optional) Where on the body the immunzation was given
// Vocabulary: immunization-anatomic-surface
//
@property (readwrite, nonatomic, retain) HVCodableValue* anatomicSurface;
//
// (Optional) Any adverse reaction to the immunization
// Vocabulary: immunization-adverse-effect
//
@property (readwrite, nonatomic, retain) NSString* adverseEvent;
//
// (Optional): Consent description
//
@property (readwrite, nonatomic, retain) NSString* consent;

//-------------------------
//
// Initializers
//
//-------------------------

-(id) initWithName:(NSString *) name;

+(HVItem *) newItem;

//-------------------------
//
// Text
//
//-------------------------

-(NSString *) toString;

//-------------------------
//
// Standard Vocabs
//
//-------------------------
+(HVVocabIdentifier *) vocabForName;

+(HVVocabIdentifier *) vocabForManufacturer;
+(HVVocabIdentifier *) vocabForAdverseEvent;
+(HVVocabIdentifier *) vocabForRoute;
+(HVVocabIdentifier *) vocabForSurface;

//-------------------------
//
// Type information
//
//-------------------------

+(NSString *) typeID;
+(NSString *) XRootElement;

@end
