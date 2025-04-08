//
//  HVContact.h
//  HVLib
//
//

#import "HVType.h"
#import "HVAddress.h"
#import "HVPhone.h"
#import "HVEmail.h"

@interface HVContact : HVType
{
@private
    HVAddressCollection* m_address;
    HVPhoneCollection* m_phone;
    HVEmailCollection* m_email;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVAddressCollection* address;
// 
// (Optional)
//
@property (readwrite, nonatomic, retain) HVPhoneCollection* phone;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVEmailCollection* email;

//
// Convenience
//
@property (readonly, nonatomic) BOOL hasAddress;
@property (readonly, nonatomic) BOOL hasPhone;
@property (readonly, nonatomic) BOOL hasEmail;

@property (readonly, nonatomic) HVAddress* firstAddress;
@property (readonly, nonatomic) HVPhone* firstPhone;
@property (readonly, nonatomic) HVEmail* firstEmail;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithPhone:(NSString *) phone;
-(id) initWithEmail:(NSString *) email;
-(id) initWithPhone:(NSString *) phone andEmail:(NSString *) email;

@end
