//
//  HVApproxDate.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVApproxDate.h"

@implementation HVApproxDate

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_year, HVClientError_InvalidDate);
    HVVALIDATE_OPTIONAL(m_month);
    HVVALIDATE_OPTIONAL(m_day);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

@end
