//
//  HVDuration.h
//  HVLib
//
//


#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVApproxDateTime.h"

@interface HVDuration : HVType
{
    HVApproxDateTime* m_startDate;
    HVApproxDateTime* m_endDate;
}

//-------------------------
//
// Data
//
//-------------------------
@property (readwrite, nonatomic, retain) HVApproxDateTime* startDate;
@property (readwrite, nonatomic, retain) HVApproxDateTime* endDate;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithStartDate:(NSDate *) start endDate:(NSDate *) end;
-(id) initWithDate:(NSDate *)start andDurationInSeconds:(double) duration;

@end
