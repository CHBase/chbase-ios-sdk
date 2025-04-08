//
//  HVCondition.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVVocab.h"

@interface HVCondition : HVItemDataTyped
{
@private
    HVCodableValue* m_name;
    HVApproxDateTime* m_onsetDate;
    HVCodableValue* m_status;
    HVApproxDateTime* m_stopDate;
    NSString* m_stopReason;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) This condition's name
// Vocabularies: icd9cm, Snomed etc
//
@property (readwrite, nonatomic, retain) HVCodableValue* name;
//
// Optional: 
//
@property (readwrite, nonatomic, retain) HVApproxDateTime* onsetDate;
//
// Optional: 'acute', 'chronic' etc
// Vocabulary: condition-occurrence
//
@property (readwrite, nonatomic, retain) HVCodableValue* status;
//
// Optional: Has the condition stoped? 
//
@property (readwrite, nonatomic, retain) HVApproxDateTime* stopDate;
//
// Optional
//
@property (readwrite, nonatomic, retain) NSString* stopReason;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithName:(NSString *) name;

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
+(HVVocabIdentifier *) vocabForStatus;

//-------------------------
//
// Type Information
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;

+(HVItem *) newItem;

@end
