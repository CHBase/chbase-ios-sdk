//
//  HVVocabCodeSet.h
//  HVLib
//
//

#import "HVType.h"
#import "HVBaseTypes.h"
#import "HVVocabItem.h"
#import "HVVocabIdentifier.h"

@interface HVVocabCodeSet : HVType
{
    NSString* m_name;
    NSString* m_family;
    NSString* m_version;
    HVVocabItemCollection* m_items;
    HVBool* m_isTruncated;
}

@property (readwrite, nonatomic, retain) NSString* name;
@property (readwrite, nonatomic, retain) NSString* family;
@property (readwrite, nonatomic, retain) NSString* version;
@property (readwrite, nonatomic, retain) HVVocabItemCollection* items;
@property (readwrite, nonatomic, retain) HVBool* isTruncated;

@property (readonly, nonatomic) BOOL hasItems;

-(NSArray *) displayStrings;
-(void) sortItemsByDisplayText;

-(HVVocabIdentifier *) getVocabID;

@end

@interface HVVocabSetCollection : HVCollection 

-(HVVocabCodeSet *) itemAtIndex:(NSUInteger) index;

@end


@interface HVVocabSearchResults : HVType 
{
    HVVocabCodeSet* m_match;
}

@property (readwrite, nonatomic, retain) HVVocabCodeSet* match;
@property (readonly, nonatomic) BOOL hasMatches;

@end
