#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVAwakening.h"
#import "HVLevel.h"

@interface HVSleepSession : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVTime* m_bedTime;
    HVTime* m_wakeTime;
    HVNonNegativeInt* m_sleepMinutes;
    HVNonNegativeInt* m_settlingMinutes;
    HVAwakeningCollection* m_awakening;
    HVCodableValue* m_medications;
    HVNonNegativeInt* m_wakeState;
    HVNonNegativeInt* m_lightSleepDuration;
    HVNonNegativeInt* m_deepSleepDuration;
    HVNonNegativeInt* m_remSleepDuration;
    HVNonNegativeInt* m_awakeDuration;
    HVNonNegativeInt* m_wakeupDuration;
    HVLevelCollection* m_level;
    HVNonNegativeInt* m_timesWokenUp;
    HVNonNegativeInt* m_averageRestingHr;
    HVNonNegativeInt* m_caloriesBurned;
}

@property (readwrite, nonatomic, retain) HVDateTime* when;
@property (readwrite, nonatomic, retain) HVTime* bedTime;
@property (readwrite, nonatomic, retain) HVTime* wakeTime;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* sleepMinutes;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* settlingMinutes;
@property (readwrite, nonatomic, retain) HVAwakeningCollection* awakening;
@property (readwrite, nonatomic, retain) HVCodableValue* medications;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* wakeState;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* lightSleepDuration;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* deepSleepDuration;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* remSleepDuration;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* awakeDuration;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* wakeupDuration;
@property (readwrite, nonatomic, retain) HVLevelCollection* level;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* timesWokenUp;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* averageRestingHr;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* caloriesBurned;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end
