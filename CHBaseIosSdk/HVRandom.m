//
//  HVRandom.m
//  HVLib
//
//

#import "HVRandom.h"

@implementation HVRandom

+(uint) randomUintInRangeMin:(uint)min max:(uint)max
{
    if (min < max)
    {
        return min + arc4random_uniform((max - min) + 1);
    }
    
    return max + arc4random_uniform((min - max) + 1);
}

+(int) randomIntInRangeMin:(int) min max:(int)max
{
    if (min < max)
    {
        return min + arc4random_uniform((max - min) + 1);
    }
    
    return max + arc4random_uniform((min - max) + 1);    
}

+(double) randomDouble
{
    return ((double) arc4random_uniform(UINT32_MAX)) / (UINT32_MAX);
}

+(double) randomDoubleInRangeMin:(int)min max:(int)max
{
    if (min < max)
    {
        return min + arc4random_uniform((max - min)) + [HVRandom randomDouble];
    }
    
    return max + arc4random_uniform((min - max)) + [HVRandom randomDouble];   
}

+(NSDate *) newRandomDayOffsetFromTodayInRangeMin:(int)min max:(int)max
{
    int nextDay = [HVRandom randomIntInRangeMin:min max:max];
    
    return [[NSDate alloc] initWithTimeIntervalSinceNow:(nextDay * (24 * 3600))];
}

@end
