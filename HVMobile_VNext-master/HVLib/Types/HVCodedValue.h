//
//  HVCodedValue.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVVocabItem.h"

@class HVCodedValueCollection;

//-------------------------
//
// A code from a standard vocabulary
// Includes the code, the vocabulary name, family and version
//
//-------------------------
@interface HVCodedValue : HVType
{
 
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) Vocabulary Code
//
@property (readwrite, nonatomic, retain) NSString* code;
//
// (Required)The vocabulary code is from E.g. "Rx Norm Active Medications"
//
@property (readwrite, nonatomic, retain) NSString* vocabularyName;
//
// (Optional) Vocabulary Family. E.g. "RxNorm"
//
@property (readwrite, nonatomic, retain) NSString* vocabularyFamily;
//
// (Optional) Vocabulary Version
//
@property (readwrite, nonatomic, retain) NSString* vocabularyVersion;

//-------------------------
//
// Initializers
//
//-------------------------

-(id) initWithCode:(NSString *) code andVocab:(NSString *) vocab; 
-(id) initWithCode:(NSString *) code vocab:(NSString *) vocab vocabFamily:(NSString *) family vocabVersion:(NSString *) version; 

+(HVCodedValue *) fromCode:(NSString *) code andVocab:(NSString *) vocab; 
+(HVCodedValue *) fromCode:(NSString *) code vocab:(NSString *) vocab vocabFamily:(NSString *) family vocabVersion:(NSString *) version; 

//-------------------------
//
// Methods
//
//-------------------------

-(BOOL) isEqualToCodedValue:(HVCodedValue *) value;
-(BOOL) isEqualToCode:(NSString *) code fromVocab:(NSString *) vocabName;
-(BOOL) isEqual:(id)object;

-(HVCodedValue *) clone;

@end

@interface HVCodedValueCollection : HVCollection 

-(HVCodedValue *) firstCode;

-(HVCodedValue *) itemAtIndex:(NSUInteger) index;
-(NSUInteger) indexOfCode:(HVCodedValue *) code;
-(BOOL) containsCode:(HVCodedValue *) code;

@end
