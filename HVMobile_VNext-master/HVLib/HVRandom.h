//
//  HVRandom.h
//  HVLib
//
//

#import <Foundation/Foundation.h>

@interface HVRandom : NSObject

+(uint) randomUintInRangeMin:(uint) min max:(uint) max;
+(int) randomIntInRangeMin:(int) min max:(int) max;
+(double) randomDouble;
+(double) randomDoubleInRangeMin:(int) min max:(int) max;
+(NSDate *) newRandomDayOffsetFromTodayInRangeMin:(int) min max:(int) max;

@end
