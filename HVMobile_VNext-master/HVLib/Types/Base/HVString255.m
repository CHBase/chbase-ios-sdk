//
//  HVString255.m
//  HVLib
//
//

#import "HVString255.h"

@implementation HVString255

-(NSUInteger) maxLength
{
    return 255;
}

@end

@implementation HVStringZ255

-(NSUInteger) minLength
{
    return 0;
}

-(NSUInteger) maxLength
{
    return 255;
}

@end