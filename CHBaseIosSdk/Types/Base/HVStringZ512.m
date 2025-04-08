//
//  HVStringZ512.m
//  HVLib
//
//

#import "HVStringZ512.h"

@implementation HVStringZ512

-(NSUInteger) minLength
{
    return 0;
}

-(NSUInteger) maxLength
{
    return 512;
}

@end

@implementation HVStringNZ512

-(NSUInteger)minLength
{
    return 1;
}

@end