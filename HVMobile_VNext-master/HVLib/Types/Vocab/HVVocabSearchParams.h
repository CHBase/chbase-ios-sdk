//
//  HVVocabSearch.h
//  HVLib
//
//

#import "HVType.h"
#import "HVVocabSearchText.h"

@interface HVVocabSearchParams : HVType
{
@private
    HVVocabSearchText* m_text;
    int m_maxResults;
}

@property (readwrite, nonatomic, retain) HVVocabSearchText* text;
@property (readwrite, nonatomic) int maxResults;

-(id) initWithText:(NSString*) text;

@end
