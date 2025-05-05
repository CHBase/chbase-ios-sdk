#import "HVCommon.h"
#import "HVClient.h"
#import "HVAppointment.h"

static NSString* const c_typeid = @"4B18AEB6-5F01-444C-8C70-DBF13A2F510B";
static NSString* const c_typename = @"appointment";

static NSString* const c_element_when = @"when";
static NSString* const c_element_duration = @"duration";
static NSString* const c_element_service = @"service";
static NSString* const c_element_clinic = @"clinic";
static NSString* const c_element_specialty = @"specialty";
static NSString* const c_element_status = @"status";
static NSString* const c_element_careClass = @"care-class";

@implementation HVAppointment
@synthesize when = m_when;
@synthesize duration = m_duration;
@synthesize service = m_service;
@synthesize clinic = m_clinic;
@synthesize specialty = m_specialty;
@synthesize status = m_status;
@synthesize careClass = m_careClass;

-(void)dealloc
{
    [m_when release];
    [m_duration release];
    [m_service release];
    [m_clinic release];
    [m_specialty release];
    [m_status release];
    [m_careClass release];
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
    HVSERIALIZE(m_duration, c_element_duration);
    HVSERIALIZE(m_service, c_element_service);
    HVSERIALIZE(m_clinic, c_element_clinic);
    HVSERIALIZE(m_specialty, c_element_specialty);
    HVSERIALIZE(m_status, c_element_status);
    HVSERIALIZE(m_careClass, c_element_careClass);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_when, c_element_when, HVDateTime);
    HVDESERIALIZE(m_duration, c_element_duration, HVDuration);
    HVDESERIALIZE(m_service, c_element_service, HVCodableValue);
    HVDESERIALIZE(m_clinic, c_element_clinic, HVPerson);
    HVDESERIALIZE(m_specialty, c_element_specialty, HVCodableValue);
    HVDESERIALIZE(m_status, c_element_status, HVCodableValue);
    HVDESERIALIZE(m_careClass, c_element_careClass, HVCodableValue);
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
    return [[HVItem alloc] initWithType:[HVAppointment typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Appointment", @"Appointment");
}

@end