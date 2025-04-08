//
//  HVVocabSearchText.h
//  HVLib
//
//

#import "HVType.h"
#import "HVString255.h"

enum HVVocabMatchType 
{
    HVVocabMatchTypeFullText,
    HVVocabMatchTypePrefix,
    HVVocabMatchTypeNone
};

NSString* HVVocabMatchTypeToString(enum HVVocabMatchType type);
enum HVVocabMatchType HVVocabMatchTypeFromString(NSString* string);

@interface HVVocabSearchText : HVString255
{
@private
    enum HVVocabMatchType m_type;
}

@property (readwrite, nonatomic) enum HVVocabMatchType matchType;

@end
