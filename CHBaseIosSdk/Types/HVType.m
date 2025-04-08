//
//  HVType.m
//  HVLib
//
//


#import "HVCommon.h"
#import "HVType.h"

@implementation HVType

-(BOOL) isValid
{
    return ([self validate] == HVClientResult_Success);
}

-(HVClientResult *) validate
{
    HVVALIDATE_SUCCESS;
}

@end
