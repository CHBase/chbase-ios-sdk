//
//  HVConstrainedDouble.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVConstrainedDouble.h"

@implementation HVConstrainedDouble

-(BOOL) inRange
{
    return [self validateValue:m_value];
}

-(double) min
{
    return DBL_MIN;
}

-(double) max
{
    return DBL_MAX;
}

-(HVClientResult *) validate
{
    HVCHECK_SUCCESS([self validateValue:m_value]);
    
    HVVALIDATE_SUCCESS;
    
LError:
    return HVMAKE_ERROR(HVClientError_ValueOutOfRange);
}

-(BOOL) validateValue:(double)value
{
    return(self.min <= value && value <= self.max);
}

@end
