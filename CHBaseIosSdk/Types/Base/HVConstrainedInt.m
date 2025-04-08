//
//  constrainedInt.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVConstrainedInt.h"

@implementation HVConstrainedInt

-(BOOL) inRange
{
    return [self validateValue:m_value];
}

-(int) min
{
    return INT32_MIN;
}
-(int) max
{
    return INT32_MAX;
}

-(HVClientResult *) validate
{
    HVCHECK_SUCCESS([self validateValue:m_value]);
    
    HVVALIDATE_SUCCESS;

LError:
    return HVMAKE_ERROR(HVClientError_ValueOutOfRange);
}

-(BOOL) validateValue:(int)value
{
    return(self.min <= value && value <= self.max);
}

@end
