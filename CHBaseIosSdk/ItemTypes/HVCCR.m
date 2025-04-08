//
//  HVCCR.m
//  HVLib
//
//
//

#import "HVCommon.h"
#import "HVCCR.h"

static NSString* const c_typeid = @"1e1ccbfc-a55d-4d91-8940-fa2fbf73c195";
static NSString* const c_typename = @"ContinuityOfCareRecord";

@implementation HVCCR

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_STRING(m_xml, HVClientError_InvalidCCR);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

+(NSString *)typeID
{
    return c_typeid;
}

+(NSString *) XRootElement
{
    return c_typename;
}

+(HVItem *) newItem
{
    return [[HVItem alloc] initWithType:[HVCCR typeID]];
}

@end
