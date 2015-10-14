//
//  HVEmailAddress.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVEmailAddress.h"

@implementation HVEmailAddress

-(NSUInteger) minLength
{
    return 6;
}

-(NSUInteger) maxLength
{
    return 128;
}

@end
