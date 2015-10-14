//
//  HVPhone.h
//  HVLib
//
//

#import "HVType.h"
#import "HVBaseTypes.h"
#import "HVCollection.h"
#import "HVVocab.h"

@interface HVPhone : HVType
{
@private
    NSString* m_type;
    HVBool* m_isprimary;
    NSString* m_number;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) Phone number
// Note: the SDK does not validate if the phone number is in valid
// phone number format. 
//
@property (readwrite, nonatomic, retain) NSString* number;
//
// (Optional) A description of this number (Cell, Home, Work)
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
-(id) initWithNumber:(NSString *) number;

//-------------------------
//
// Text
//
//-------------------------

-(NSString *) toString;

+(HVVocabIdentifier *) vocabForType;

@end

//-------------------------
//
// HVPhoneCollection
//
//-------------------------
@interface HVPhoneCollection : HVCollection

-(HVPhone *) itemAtIndex:(NSUInteger) index;

@end
