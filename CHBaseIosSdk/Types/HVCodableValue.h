//
//  HVCodableValue.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVCodedValue.h"

//-------------------------
//
// A Text value with an optional set of associated vocabulary codes
// E.g. the name of a medication, with optional RXNorm codes
//
//-------------------------
@interface HVCodableValue : HVType
{
@private
    NSString* m_text;
    HVCodedValueCollection* m_codes;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required)
//
@property (readwrite, nonatomic, retain) NSString* text;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVCodedValueCollection* codes;
//
// Convenience properties
//
@property (readonly, nonatomic) BOOL hasCodes;
@property (readonly, nonatomic) HVCodedValue* firstCode;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithText:(NSString *) textValue;
-(id) initWithText:(NSString *)textValue andCode:(HVCodedValue *) code;
-(id) initWithText:(NSString *)textValue code:(NSString *) code andVocab:(NSString *) vocab;

+(HVCodableValue *) fromText:(NSString *) textValue;
+(HVCodableValue *) fromText:(NSString *)textValue andCode:(HVCodedValue *) code;
+(HVCodableValue *) fromText:(NSString *)textValue code:(NSString *) code andVocab:(NSString *) vocab;

//-------------------------
//
// Methods
//
//-------------------------

-(BOOL) containsCode:(HVCodedValue *) code;
-(BOOL) addCode:(HVCodedValue *) code;
-(void) clearCodes;

-(HVCodableValue *) clone;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;
//
// Expects a format containing @%
//
-(NSString *) toStringWithFormat:(NSString *) format;
//
// Does a trimmed case insensitive comparison
//
-(BOOL) matchesDisplayText:(NSString *) text;

@end

@interface HVCodableValueCollection : HVCollection

-(void) addItem:(HVCodableValue *) value;
-(HVCodableValue *) itemAtIndex:(NSUInteger) index;

@end
