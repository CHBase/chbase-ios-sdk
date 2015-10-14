//
//  HVPositiveDouble.m
//  HVLib
//
//

#import "HVPositiveDouble.h"

@implementation HVPositiveDouble

-(double) min
{
    return 0;
}

-(BOOL) validateValue:(double)value
{
    return(self.min < value && value <= self.max);
}

@end
