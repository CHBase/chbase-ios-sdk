//
//  HVGetVocab.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVMethodCallTask.h"
#import "HVVocab.h"

@interface HVVocabGetResults : HVType 
{
    HVVocabSetCollection* m_vocabs;
}

@property (readwrite, nonatomic, retain) HVVocabSetCollection* vocabs;
@property (readonly, nonatomic) HVVocabCodeSet* firstVocab;

@end

//-------------------------
//
// Get Vocabularies from HealthVault
//
//-------------------------
@interface HVGetVocabTask : HVMethodCallTask
{
@private
    HVVocabParams* m_params;
}

//-------------------------
//
// Properties
//
//-------------------------
//
// (Required) - Request - which vocabularies to get
//
@property (readwrite, nonatomic, retain) HVVocabParams* params;
//
// Response - retrieved vocabulary data
//
@property (readonly, nonatomic) HVVocabGetResults* vocabResults;
//
// Convenience property to get the vocabulary from vocabResults
//
@property (readonly, nonatomic) HVVocabCodeSet* vocabulary;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithVocabID:(HVVocabIdentifier *) vocabID andCallback:(HVTaskCompletion) callback;

@end
