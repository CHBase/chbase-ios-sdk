#import "HVCommon.h"
#import "HVClient.h"
#import "HVAsthmaInhaler.h"

static NSString* const c_typeid = @"ff9ce191-2096-47d8-9300-5469a9883746";
static NSString* const c_typename = @"asthma-inhaler";

static NSString* const c_element_drug = @"drug";
static NSString* const c_element_strength = @"strength";
static NSString* const c_element_purpose = @"purpose";
static NSString* const c_element_startDate = @"start-date";
static NSString* const c_element_stopDate = @"stop-date";
static NSString* const c_element_expirationDate = @"expiration-date";
static NSString* const c_element_deviceId = @"device-id";
static NSString* const c_element_initialDoses = @"initial-doses";
static NSString* const c_element_minDailyDoses = @"min-daily-doses";
static NSString* const c_element_maxDailyDoses = @"max-daily-doses";
static NSString* const c_element_canAlert = @"can-alert";
static NSString* const c_element_alert = @"alert";
static const xmlChar* x_element_alert = XMLSTRINGCONST("alert");

@implementation HVAsthmaInhaler
@synthesize drug = m_drug;
@synthesize strength = m_strength;
@synthesize purpose = m_purpose;
@synthesize startDate = m_startDate;
@synthesize stopDate = m_stopDate;
@synthesize expirationDate = m_expirationDate;
@synthesize deviceId = m_deviceId;
@synthesize initialDoses = m_initialDoses;
@synthesize minDailyDoses = m_minDailyDoses;
@synthesize maxDailyDoses = m_maxDailyDoses;
@synthesize canAlert = m_canAlert;
@synthesize alert = m_alert;

-(void)dealloc
{
    [m_drug release];
    [m_strength release];
    [m_purpose release];
    [m_startDate release];
    [m_stopDate release];
    [m_expirationDate release];
    [m_deviceId release];
    [m_initialDoses release];
    [m_minDailyDoses release];
    [m_maxDailyDoses release];
    [m_canAlert release];
    [m_alert release];
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
    HVSERIALIZE(m_drug, c_element_drug);
    HVSERIALIZE(m_strength, c_element_strength);
    HVSERIALIZE_STRING(m_purpose, c_element_purpose);
    HVSERIALIZE(m_startDate, c_element_startDate);
    HVSERIALIZE(m_stopDate, c_element_stopDate);
    HVSERIALIZE(m_expirationDate, c_element_expirationDate);
    HVSERIALIZE_STRING(m_deviceId, c_element_deviceId);
    HVSERIALIZE(m_initialDoses, c_element_initialDoses);
    HVSERIALIZE(m_minDailyDoses, c_element_minDailyDoses);
    HVSERIALIZE(m_maxDailyDoses, c_element_maxDailyDoses);
    HVSERIALIZE_BOOL(m_canAlert, c_element_canAlert);
    HVSERIALIZE_ARRAY(m_alert, c_element_alert);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_drug, c_element_drug, HVCodableValue);
    HVDESERIALIZE(m_strength, c_element_strength, HVCodableValue);
    HVDESERIALIZE_STRING(m_purpose, c_element_purpose);
    HVDESERIALIZE(m_startDate, c_element_startDate, HVApproxDateTime);
    HVDESERIALIZE(m_stopDate, c_element_stopDate, HVApproxDateTime);
    HVDESERIALIZE(m_expirationDate, c_element_expirationDate, HVApproxDateTime);
    HVDESERIALIZE_STRING(m_deviceId, c_element_deviceId);
    HVDESERIALIZE(m_initialDoses, c_element_initialDoses, HVNonNegativeInt);
    HVDESERIALIZE(m_minDailyDoses, c_element_minDailyDoses, HVNonNegativeInt);
    HVDESERIALIZE(m_maxDailyDoses, c_element_maxDailyDoses, HVNonNegativeInt);
    HVDESERIALIZE_BOOL(m_canAlert, c_element_canAlert);
    HVDESERIALIZE_ARRAY(m_alert, x_element_alert, HVAlert);
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
    return [[HVItem alloc] initWithType:[HVAsthmaInhaler typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"AsthmaInhaler", @"AsthmaInhaler");
}

@end