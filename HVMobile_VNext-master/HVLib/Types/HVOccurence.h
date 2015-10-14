//
//  HVOccurence.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVBaseTypes.h"
#import "HVTime.h"

@interface HVOccurence : HVType
{
@private
    HVTime* m_when;
    HVNonNegativeInt* m_minutes;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required)
//
@property(readwrite, nonatomic, retain) HVTime* when;
//
// (Required)
//
@property(readwrite, nonatomic, retain) HVNonNegativeInt* durationMinutes;

//-------------------------
//
// Initializers
//
//-------------------------

-(id) initForDuration:(int)minutes startingAt:(HVTime *) time;
-(id) initForDuration:(int)minutes startingAtHour:(int) hour andMinute:(int) minute;

+(HVOccurence *) forDuration:(int) minutes atHour:(int) hour andMinute:(int) minute;

@end

@interface HVOccurenceCollection : HVCollection

-(HVOccurence *) itemAtIndex:(NSUInteger) index;

@end
