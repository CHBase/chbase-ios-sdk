//
//  HVEmotionalState.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

enum HVMood 
{
    HVMoodUnknown = 0,
    HVMoodDepressed,
    HVMoodSad,
    HVMoodNeutral,
    HVMoodHappy,
    HVMoodElated
};

NSString* stringFromMood(enum HVMood mood);

enum HVWellBeing 
{
    HVWellBeingUnknown = 0,
    HVWellBeingSick,
    HVWellBeingImpaired,
    HVWellBeingAble,
    HVWellBeingHealthy,
    HVWellBeingVigorous
};

NSString* stringFromWellBeing(enum HVWellBeing wellBeing);

@interface HVEmotionalState : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVOneToFive* m_mood;
    HVOneToFive* m_stress;
    HVOneToFive* m_wellbeing;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Optional) Emotional state this THIS time
//
@property (readwrite, nonatomic, retain) HVDateTime* when;
//
// (Optional) Mood rating - happy, depressed, sad..
//
@property (readwrite, nonatomic) enum HVMood mood;
//
// (Optional) A relative stress level
//
@property (readwrite, nonatomic) enum HVRelativeRating stress;
//
// (Optional) Sick, Healthy etc
//
@property (readwrite, nonatomic) enum HVWellBeing wellbeing;

//-------------------------
//
// Initializers
//
//-------------------------
+(HVItem *) newItem;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) moodAsString;
-(NSString *) stressAsString;
-(NSString *) wellBeingAsString;

-(NSString *) toString;
// @Mood @Stress @WellBeing
-(NSString *) toStringWithFormat:(NSString *) format;

//-------------------------
//
// Type Info
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;


@end
