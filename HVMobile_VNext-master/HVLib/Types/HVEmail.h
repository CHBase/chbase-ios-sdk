//
//  HVEmail.h
//  HVLib
//
//

#import "HVType.h"
#import "HVBaseTypes.h"
#import "HVCollection.h"
#import "HVVocab.h"

@interface HVEmail : HVType
{
@private
    NSString* m_type;
    HVBool* m_isprimary;
    HVEmailAddress* m_address;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required)
// Note: HVEmailAddress currently does the minimal validation, so you may want
// to run any RegEx or other validation scripts on the address
//
@property (readwrite, nonatomic, retain) HVEmailAddress* address;
//
// (Optional) A description of this email (Personal, Work, etc)
//
@property (readwrite, nonatomic, retain) NSString* type;
//
// (Optional) 
//
@property (readwrite, nonatomic, retain) HVBool* isPrimary;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithEmailAddress:(NSString *) email;

+(HVVocabIdentifier *) vocabForType;

//-------------------------
//
// TEXT
//
//-------------------------
-(NSString *) toString;

@end

//-------------------------
//
// HVEmailCollection
//
//-------------------------
@interface HVEmailCollection : HVCollection

-(HVEmail *) itemAtIndex:(NSUInteger) index;

@end
