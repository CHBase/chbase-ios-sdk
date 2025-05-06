#import "HVCommon.h"
#import "HVClient.h"
#import "HVReferral.h"

static NSString* const c_typeid = @"b861cb93-9cd3-408a-9c65-e5f58e4e2c30";
static NSString* const c_typename = @"referral";

static NSString* const c_element_when = @"when";
static NSString* const c_element_type = @"type";
static NSString* const c_element_reason = @"reason";
static NSString* const c_element_referredBy = @"referred-by";
static NSString* const c_element_task = @"task";
static NSString* const c_element_referredTo = @"referred-to";
static const xmlChar* x_element_task = XMLSTRINGCONST("task");
@implementation HVReferral
@synthesize when = m_when;
@synthesize referralType = m_type;
@synthesize reason = m_reason;
@synthesize referredBy = m_referredBy;
@synthesize task = m_task;
@synthesize referredTo = m_referredTo;

-(void)dealloc
{
    [m_when release];
    [m_type release];
    [m_reason release];
    [m_referredBy release];
    [m_task release];
    [m_referredTo release];
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    HVVALIDATE_SUCCESS
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_when, c_element_when);
    HVSERIALIZE(m_type, c_element_type);
    HVSERIALIZE(m_reason, c_element_reason);
    HVSERIALIZE(m_referredBy, c_element_referredBy);
    HVSERIALIZE_ARRAY(m_task, c_element_task);
    HVSERIALIZE(m_referredTo, c_element_referredTo);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_when, c_element_when, HVDateTime);
    HVDESERIALIZE(m_type, c_element_type, HVCodableValue);
    HVDESERIALIZE(m_reason, c_element_reason, HVCodableValue);
    HVDESERIALIZE(m_referredBy, c_element_referredBy, HVPerson);
    HVDESERIALIZE_TYPEDARRAY_X(m_task, x_element_task, HVReferralTask,HVTaskCollection);
    HVDESERIALIZE(m_referredTo, c_element_referredTo, HVPerson);
}

+(NSString *)typeID
{
    return c_typeid;
}

+(NSString *) XRootElement
{
    return c_typename;
}

+(HVItem *) newItem
{
    return [[HVItem alloc] initWithType:[HVReferral typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Referral", @"Referral");
}

@end
