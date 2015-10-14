//
//  HVQuestionAnswer.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVQuestionAnswer : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVCodableValue* m_question;
    HVCodableValueCollection* m_answerChoices;
    HVCodableValueCollection* m_answers;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required)
//
@property (readwrite, nonatomic, retain) HVDateTime* when;
//
// (Required)
//
@property (readwrite, nonatomic, retain) HVCodableValue* question;
//
// (Optional)
// Was this a multiple choice question. If so, useful to capture the original choices
//
@property (readwrite, nonatomic, retain) HVCodableValueCollection* answerChoices;
//
// (Optional)
// One or more answers
//
@property (readwrite, nonatomic, retain) HVCodableValueCollection* answers;
//
// Convenience Properties
//
@property (readonly, nonatomic) HVCodableValue* firstAnswer;
@property (readonly, nonatomic) BOOL hasAnswerChoices;
@property (readonly, nonatomic) BOOL hasAnswers;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithQuestion:(NSString *) question andDate:(NSDate *) date;
-(id) initWithQuestion:(NSString *) question answer:(NSString *) answer andDate:(NSDate *) date;

+(HVItem *) newItem;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;

//-------------------------
//
// Type Info
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;

@end
