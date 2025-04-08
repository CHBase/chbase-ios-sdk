//
//  HVSearchVocabTask.h
//  HVLib
//
//

#import "HVMethodCallTask.h"
#import "HVVocabIdentifier.h"
#import "HVVocabSearchParams.h"
#import "HVVocabCodeSet.h"

//-------------------------
//
// Search a given vocabulary
// Supports various options such as free text search
// Ideal for auto-complete scenarios
//
//-------------------------
@interface HVVocabSearchTask : HVMethodCallTask
{
@private
    HVVocabIdentifier* m_vocabID;
    HVVocabSearchParams* m_params;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) - vocabulary being searched
//
@property (readwrite, nonatomic, retain) HVVocabIdentifier* vocabID;
//
// (Required) - search parameters
//
@property (readwrite, nonatomic, retain) HVVocabSearchParams* params;
//
// RESULT - use this property to retrieve results when the task completes
//
@property (readonly, nonatomic) HVVocabCodeSet* searchResult;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithVocab:(HVVocabIdentifier *) vocab searchText:(NSString*) text andCallback:(HVTaskCompletion) callback;

+(HVVocabSearchTask *) searchForText:(NSString *) text inVocabFamily:(NSString *) family vocabName:(NSString *) name callback:(HVTaskCompletion) callback;

+(HVVocabSearchTask *) searchForText:(NSString *) text inVocab:(HVVocabIdentifier *) vocab callback:(HVTaskCompletion) callback;

+(HVVocabSearchTask *) searchMedications:(NSString *) text callback:(HVTaskCompletion) callback;

@end
