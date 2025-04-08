//
//  HVPositiveInt.m
//  HVLib
//
//

#import "HVPositiveInt.h"

@implementation HVPositiveInt

-(int) min
{
    return 0;
}

-(BOOL)validateValue:(int)value
{
    return(self.min < value && value <= self.max);
}

@end
