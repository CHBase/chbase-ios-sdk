//
//  HVEmotionalState.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVEmotionalState.h"


NSString* stringFromMood(enum HVMood mood)
{
    switch (mood) 
    {
        case HVMoodDepressed:
            return @"Depressed";
        
        case HVMoodSad:
            return @"Sad";
        
        case HVMoodNeutral:
            return @"Neutral";
        
        case HVMoodHappy:
            return @"Happy";
        
        case HVMoodElated:
            return @"Elated";
            
        default:
            break;
    }
    
    return c_emptyString;
}

NSString* stringFromWellBeing(enum HVWellBeing wellBeing)
{
    switch (wellBeing) 
    {
        case HVWellBeingSick:
            return @"Sick";
        
        case HVWellBeingImpaired:
            return @"Impaired";
        
        case HVWellBeingAble:
            return @"Able";
        
        case HVWellBeingHealthy:
            return @"Healthy";
        
        case HVWellBeingVigorous:
            return @"Vigorous";
            
        default:
            break;
    }
    
    return c_emptyString;
}

static NSString* const c_typeid = @"4b7971d6-e427-427d-bf2c-2fbcf76606b3";
static NSString* const c_typename = @"emotion";

static const xmlChar* x_element_when = XMLSTRINGCONST("when");
static const xmlChar* x_element_mood = XMLSTRINGCONST("mood");
static const xmlChar* x_element_stress = XMLSTRINGCONST("stress");
static const xmlChar* x_element_wellbeing = XMLSTRINGCONST("wellbeing");

@implementation HVEmotionalState

@synthesize when = m_when;

-(NSDate *)getDate
{
    return [m_when toDate];
}

-(NSDate *)getDateForCalendar:(NSCalendar *)calendar
{
    return [m_when toDateForCalendar:calendar];
}

-(enum HVMood)mood
{
    return (m_mood) ? (enum HVMood) m_mood.value : HVMoodUnknown;
}

-(void)setMood:(enum HVMood)mood
{
    if (mood == HVMoodUnknown)
    {
        HVCLEAR(m_mood);
    }
    else
    {
        HVENSURE(m_mood, HVOneToFive);
        m_mood.value = (int) mood;
    }
}


-(enum HVRelativeRating)stress
{
    return (m_stress) ? (enum HVRelativeRating) m_stress.value : HVRelativeRating_None;
}

-(void)setStress:(enum HVRelativeRating)stress
{
    if (stress == HVRelativeRating_None)
    {
        HVCLEAR(m_stress);
    }
    else
    {
        HVENSURE(m_stress, HVOneToFive);
        m_stress.value = (int) stress;
    }
}

-(enum HVWellBeing)wellbeing
{
    return (m_wellbeing) ? (enum HVWellBeing) m_wellbeing.value : HVWellBeingUnknown;    
}

-(void)setWellbeing:(enum HVWellBeing)wellbeing
{
    if (wellbeing == HVWellBeingUnknown)
    {
        HVCLEAR(m_wellbeing);
    }
    else
    {
        HVENSURE(m_wellbeing, HVOneToFive);
        m_wellbeing.value = (int) wellbeing;
    }    
}

-(void)dealloc
{
    [m_when release];
    [m_mood release];
    [m_stress release];
    [m_wellbeing release];
    [super dealloc];
}

-(NSString *)moodAsString
{
    return stringFromMood(self.mood);
}

-(NSString *)wellBeingAsString
{
    return stringFromWellBeing(self.wellbeing);
}

-(NSString *)stressAsString
{
    return stringFromRating(self.stress);
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    return [self toStringWithFormat:@"Mood=%@, Stress=%@, Wellbeing=%@"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    return [NSString stringWithFormat:format, [self moodAsString], [self stressAsString], [self wellBeingAsString]];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_OPTIONAL(m_when);
    HVVALIDATE_OPTIONAL(m_mood);
    HVVALIDATE_OPTIONAL(m_stress);
    HVVALIDATE_OPTIONAL(m_wellbeing);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_when, x_element_when);
    HVSERIALIZE_X(m_mood, x_element_mood);
    HVSERIALIZE_X(m_stress, x_element_stress);
    HVSERIALIZE_X(m_wellbeing, x_element_wellbeing);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_when, x_element_when, HVDateTime);
    HVDESERIALIZE_X(m_mood, x_element_mood, HVOneToFive);
    HVDESERIALIZE_X(m_stress, x_element_stress, HVOneToFive);
    HVDESERIALIZE_X(m_wellbeing, x_element_wellbeing, HVOneToFive);
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
    return [[HVItem alloc] initWithType:[HVEmotionalState typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Emotional state", @"Emotional state Type Name");
}

@end
