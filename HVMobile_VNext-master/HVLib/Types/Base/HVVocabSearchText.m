//
//  HVVocabSearchText.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVVocabSearchText.h"

NSString* HVVocabMatchTypeToString(enum HVVocabMatchType type)
{
    switch (type) {
        case HVVocabMatchTypeFullText:
            return @"FullText";
        
        case HVVocabMatchTypePrefix:
            return @"Prefix";
            
        default:
            break;
    }
    
    return c_emptyString;
}

enum HVVocabMatchType HVVocabMatchTypeFromString(NSString* string)
{
    if ([string isEqualToString:@"FullText"])
    {
        return HVVocabMatchTypeFullText;
    }
    
    if ([string isEqualToString:@"Prefix"])
    {
        return HVVocabMatchTypePrefix;
    }
    
    return HVVocabMatchTypeNone;
}

static NSString* const c_attribute_matchType = @"search-mode";

@implementation HVVocabSearchText

@synthesize matchType = m_type;

-(void)serializeAttributes:(XWriter *)writer
{
    NSString* matchType = HVVocabMatchTypeToString(m_type);
    
    HVSERIALIZE_ATTRIBUTE(matchType, c_attribute_matchType);
}

-(void)deserializeAttributes:(XReader *)reader
{
    NSString* mode = nil;

    HVDESERIALIZE_ATTRIBUTE(mode, c_attribute_matchType);
    if (![NSString isNilOrEmpty:mode])
    {
        m_type = HVVocabMatchTypeFromString(mode);
    }
}

@end
