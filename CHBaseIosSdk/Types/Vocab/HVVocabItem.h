//
//  HVVocabItem.h
//  HVLib
//
//

#import "HVType.h"
#import "HVCollection.h"

@interface HVVocabItem : HVType
{
@private
    NSString* m_code;
    NSString* m_displayText;
    NSString* m_abbrv;
    NSString* m_data;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) - Vocabulary Code - such as RxNorm or Snomed code
//
@property (readwrite, nonatomic, retain) NSString* code;
//
// (Required) - Vocab Display Text - the actual text
//
@property (readwrite, nonatomic, retain) NSString* displayText;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) NSString* abbreviation;
//
// (Optional) - additional information about this vocab entry
// E.g. RxNorm can contain information about dosages and strengths
//
@property (readwrite, nonatomic, retain) NSString* dataXml;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;
//
// Will do a trimmed, lower case comparison
//
-(BOOL) matchesDisplayText:(NSString *) text;

@end

//-------------------------
//
// Collection of Vocabulary Items
//
//-------------------------
@interface HVVocabItemCollection : HVCollection 

-(HVVocabItem *) itemAtIndex:(NSUInteger) index;

-(void) sortByDisplayText;
-(void) sortByCode;

//------------------------
// 
// Search vocabs
//
// Basic linear scans
// You'll be working with small vocabs locally
// 
//------------------------
-(NSUInteger) indexOfVocabCode:(NSString *) code;
-(HVVocabItem *) getItemWithCode:(NSString *) code;
-(NSString *) displayTextForCode:(NSString *) code;

-(NSArray *) displayStrings;
-(void) addDisplayStringsTo:(NSMutableArray *) strings;

@end
