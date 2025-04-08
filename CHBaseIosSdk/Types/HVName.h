//
//  HVName.h
//  HVLib
//
//

#import "HVType.h"
#import "HVCodableValue.h"
#import "HVVocab.h"

@interface HVName : HVType
{
@private
    NSString* m_full;
    HVCodableValue* m_title;
    NSString* m_first;
    NSString* m_middle;
    NSString* m_last;
    HVCodableValue* m_suffix;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required)
//
@property (readwrite, nonatomic, retain) NSString* fullName;
//
// (Optional)
// Vocabulary: name-prefixes
//
@property (readwrite, nonatomic, retain) HVCodableValue* title;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) NSString* first;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) NSString* middle;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) NSString* last;
//
// (Optional)
// Vocabulary: name-suffixes
@property (readwrite, nonatomic, retain) HVCodableValue* suffix;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithFirst:(NSString *) first andLastName:(NSString *) last;
-(id) initWithFirst:(NSString *) first middle:(NSString *) middle andLastName:(NSString *) last;
-(id) initWithFullName:(NSString *) name;

//-------------------------
//
// Methods
//
//-------------------------
-(BOOL) buildFullName;

+(HVVocabIdentifier *) vocabForTitle;
+(HVVocabIdentifier *) vocabForSuffix;

//-------------------------
//
// Text
//
//-------------------------
// Returns the full name
-(NSString *) toString;

@end
