#import "HVCommon.h"
#import "HVClient.h"
#import "HVSleepSession.h"

static NSString* const c_typeid = @"902E1A03-D7C7-409B-B566-CEDDD8B17297";
static NSString* const c_typename = @"sleep-session-v2";

static NSString* const c_element_when = @"when";
static NSString* const c_element_bedTime = @"bed-time";
static NSString* const c_element_wakeTime = @"wake-time";
static NSString* const c_element_sleepMinutes = @"sleep-minutes";
static NSString* const c_element_settlingMinutes = @"settling-minutes";
static NSString* const c_element_awakening = @"awakening";
static NSString* const c_element_medications = @"medications";
static NSString* const c_element_wakeState = @"wake-state";
static NSString* const c_element_lightSleepDuration = @"light-sleep-duration";
static NSString* const c_element_deepSleepDuration = @"deep-sleep-duration";
static NSString* const c_element_remSleepDuration = @"rem-sleep-duration";
static NSString* const c_element_awakeDuration = @"awake-duration";
static NSString* const c_element_wakeupDuration = @"wakeup-duration";
static NSString* const c_element_level = @"level";
static NSString* const c_element_timesWokenUp = @"times-woken-up";
static NSString* const c_element_averageRestingHr = @"average-resting-hr";
static NSString* const c_element_caloriesBurned = @"calories-burned";
static const xmlChar* x_element_awakening = XMLSTRINGCONST("awakening");
static const xmlChar* x_element_level = XMLSTRINGCONST("level");

@implementation HVSleepSession
@synthesize when = m_when;
@synthesize bedTime = m_bedTime;
@synthesize wakeTime = m_wakeTime;
@synthesize sleepMinutes = m_sleepMinutes;
@synthesize settlingMinutes = m_settlingMinutes;
@synthesize awakening = m_awakening;
@synthesize medications = m_medications;
@synthesize wakeState = m_wakeState;
@synthesize lightSleepDuration = m_lightSleepDuration;
@synthesize deepSleepDuration = m_deepSleepDuration;
@synthesize remSleepDuration = m_remSleepDuration;
@synthesize awakeDuration = m_awakeDuration;
@synthesize wakeupDuration = m_wakeupDuration;
@synthesize level = m_level;
@synthesize timesWokenUp = m_timesWokenUp;
@synthesize averageRestingHr = m_averageRestingHr;
@synthesize caloriesBurned = m_caloriesBurned;

-(void)dealloc
{
    [m_when release];
    [m_bedTime release];
    [m_wakeTime release];
    [m_sleepMinutes release];
    [m_settlingMinutes release];
    [m_awakening release];
    [m_medications release];
    [m_wakeState release];
    [m_lightSleepDuration release];
    [m_deepSleepDuration release];
    [m_remSleepDuration release];
    [m_awakeDuration release];
    [m_wakeupDuration release];
    [m_level release];
    [m_timesWokenUp release];
    [m_averageRestingHr release];
    [m_caloriesBurned release];
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
    HVSERIALIZE(m_bedTime, c_element_bedTime);
    HVSERIALIZE(m_wakeTime, c_element_wakeTime);
    HVSERIALIZE(m_sleepMinutes, c_element_sleepMinutes);
    HVSERIALIZE(m_settlingMinutes, c_element_settlingMinutes);
    HVSERIALIZE_ARRAY(m_awakening, c_element_awakening);
    HVSERIALIZE(m_medications, c_element_medications);
    HVSERIALIZE(m_wakeState, c_element_wakeState);
    HVSERIALIZE(m_lightSleepDuration, c_element_lightSleepDuration);
    HVSERIALIZE(m_deepSleepDuration, c_element_deepSleepDuration);
    HVSERIALIZE(m_remSleepDuration, c_element_remSleepDuration);
    HVSERIALIZE(m_awakeDuration, c_element_awakeDuration);
    HVSERIALIZE(m_wakeupDuration, c_element_wakeupDuration);
    HVSERIALIZE_ARRAY(m_level, c_element_level);
    HVSERIALIZE(m_timesWokenUp, c_element_timesWokenUp);
    HVSERIALIZE(m_averageRestingHr, c_element_averageRestingHr);
    HVSERIALIZE(m_caloriesBurned, c_element_caloriesBurned);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_when, c_element_when, HVDateTime);
    HVDESERIALIZE(m_bedTime, c_element_bedTime, HVTime);
    HVDESERIALIZE(m_wakeTime, c_element_wakeTime, HVTime);
    HVDESERIALIZE(m_sleepMinutes, c_element_sleepMinutes, HVNonNegativeInt);
    HVDESERIALIZE(m_settlingMinutes, c_element_settlingMinutes, HVNonNegativeInt);
    HVDESERIALIZE_TYPEDARRAY_X(m_awakening, x_element_awakening, HVAwakening,HVAwakeningCollection);
    HVDESERIALIZE(m_medications, c_element_medications, HVCodableValue);
    HVDESERIALIZE(m_wakeState, c_element_wakeState, HVNonNegativeInt);
    HVDESERIALIZE(m_lightSleepDuration, c_element_lightSleepDuration, HVNonNegativeInt);
    HVDESERIALIZE(m_deepSleepDuration, c_element_deepSleepDuration, HVNonNegativeInt);
    HVDESERIALIZE(m_remSleepDuration, c_element_remSleepDuration, HVNonNegativeInt);
    HVDESERIALIZE(m_awakeDuration, c_element_awakeDuration, HVNonNegativeInt);
    HVDESERIALIZE(m_wakeupDuration, c_element_wakeupDuration, HVNonNegativeInt);
    HVDESERIALIZE_TYPEDARRAY_X(m_level, x_element_level, HVLevel,HVLevelCollection);
    HVDESERIALIZE(m_timesWokenUp, c_element_timesWokenUp, HVNonNegativeInt);
    HVDESERIALIZE(m_averageRestingHr, c_element_averageRestingHr, HVNonNegativeInt);
    HVDESERIALIZE(m_caloriesBurned, c_element_caloriesBurned, HVNonNegativeInt);
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
    return [[HVItem alloc] initWithType:[HVSleepSession typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"SleepSession", @"SleepSession");
}

@end
