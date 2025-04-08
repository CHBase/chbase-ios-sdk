//
//  HVVocabParams.h
//  HVLib
//
//
//
#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVBaseTypes.h"
#import "HVVocabIdentifier.h"

@interface HVVocabParams : HVType
{
    HVVocabIdentifierCollection* m_vocabIDs;
    BOOL m_fixedCulture;
}

@property (readonly, nonatomic) HVVocabIdentifierCollection* vocabIDs;
@property (readwrite, nonatomic) BOOL fixedCulture;

-(id) initWithVocabID:(HVVocabIdentifier *) vocabID;
-(id) initWithVocabIDs:(HVVocabIdentifierCollection *) vocabIDs;

@end

