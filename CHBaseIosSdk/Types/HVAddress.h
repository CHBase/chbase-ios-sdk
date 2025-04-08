//
//  HVAddress.h
//  HVLib
//
//

#import "HVType.h"
#import "HVBaseTypes.h"
#import "HVCollection.h"
#import "HVVocab.h"

@interface HVAddress : HVType
{
@private
    NSString* m_type;
    HVBool* m_isprimary;
    HVStringCollection* m_street;
    NSString* m_city;
    NSString* m_state;
    NSString* m_postalCode;
    NSString* m_country;
    NSString* m_county;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Optional) A description of this address, such as "Home"
//
@property (readwrite, nonatomic, retain) NSString* type;
@property (readwrite, nonatomic, retain) HVBool* isPrimary;
//
// (Required)
//
@property (readwrite, nonatomic, retain) HVStringCollection* street;
//
// (Required)
// 
@property (readwrite, nonatomic, retain) NSString* city;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) NSString* state;
//
// (Required)
//
@property (readwrite, nonatomic, retain) NSString* postalCode;
//
// (Required)
//
@property (readwrite, nonatomic, retain) NSString* country;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) NSString* county;

@property (readonly, nonatomic) BOOL hasStreet;

//-------------------------
//
// Vocabs
//
//-------------------------
+(HVVocabIdentifier *) vocabForCountries;
+(HVVocabIdentifier *) vocabForUSStates;
+(HVVocabIdentifier *) vocabForCanadianProvinces;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;

@end


//-------------------------
//
// HVAddressCollection
//
//-------------------------

@interface HVAddressCollection : HVCollection

-(HVAddress *) itemAtIndex:(NSUInteger) index;

@end
