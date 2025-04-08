//
//  HVContact.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVContact.h"

static NSString* const c_element_address = @"address";
static NSString* const c_element_phone = @"phone";
static NSString* const c_element_email = @"email";

@implementation HVContact

@synthesize phone = m_phone;
@synthesize email = m_email;

-(BOOL)hasAddress
{
    return ![NSArray isNilOrEmpty:m_address];
}

-(HVAddressCollection *)address
{
    HVENSURE(m_address, HVAddressCollection);
    return m_address;
}

-(void)setAddress:(HVAddressCollection *)address
{
    HVRETAIN(m_address, address);
}

-(BOOL)hasPhone
{
    return ![NSArray isNilOrEmpty:m_phone];
}

-(HVPhoneCollection *)phone
{
    HVENSURE(m_phone, HVPhoneCollection);
    return m_phone;
}

-(void)setPhone:(HVPhoneCollection *)phone
{
    HVRETAIN(m_phone, phone);
}

-(BOOL)hasEmail
{
    return ![NSArray isNilOrEmpty:m_email];
}

-(HVEmailCollection *)email
{
    HVENSURE(m_email, HVEmailCollection);
    return m_email;
}

-(void)setEmail:(HVEmailCollection *)email
{
    HVRETAIN(m_email, email);
}

-(HVAddress *)firstAddress
{
    return (self.hasAddress) ? [m_address itemAtIndex:0] : nil;
}

-(HVEmail *) firstEmail
{
    return (self.hasEmail) ? [m_email itemAtIndex:0] : nil;
}

-(HVPhone *)firstPhone
{
    return (self.hasPhone) ? [m_phone itemAtIndex:0] : nil;
}

-(id)initWithEmail:(NSString *)email
{
    return [self initWithPhone:nil andEmail:email];
}

-(id)initWithPhone:(NSString *)phone
{
    return [self initWithPhone:phone andEmail:nil];
}

-(id)initWithPhone:(NSString *)phone andEmail:(NSString *)email
{
    self = [super init];
    HVCHECK_SELF;
    
    if (phone)
    {
        HVPhone* phoneObj = [[HVPhone alloc] initWithNumber:phone];
        HVCHECK_NOTNULL(phoneObj);
        
        [self.phone addObject:phoneObj];
        [phoneObj release];
        
        HVCHECK_NOTNULL(m_phone);
    }
    
    if (email)
    {
        HVEmail* emailObj = [[HVEmail alloc] initWithEmailAddress:email];
        HVCHECK_NOTNULL(emailObj);
        [self.email addObject:emailObj];
        [emailObj release];
        
        HVCHECK_NOTNULL(m_email);
    }
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_address release];
    [m_phone release];
    [m_email release];
    
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_ARRAYOPTIONAL(m_address, HVClientError_InvalidContact);
    HVVALIDATE_ARRAYOPTIONAL(m_phone, HVClientError_InvalidContact);
    HVVALIDATE_ARRAYOPTIONAL(m_email, HVClientError_InvalidContact);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_ARRAY(m_address, c_element_address);
    HVSERIALIZE_ARRAY(m_phone, c_element_phone);
    HVSERIALIZE_ARRAY(m_email, c_element_email);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_TYPEDARRAY(m_address, c_element_address, HVAddress, HVAddressCollection);
    HVDESERIALIZE_TYPEDARRAY(m_phone, c_element_phone, HVPhone, HVPhoneCollection);
    HVDESERIALIZE_TYPEDARRAY(m_email, c_element_email, HVEmail, HVEmailCollection);    
}

@end
