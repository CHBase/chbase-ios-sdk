//
//  HVCCD.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVCCD.h"

static NSString* const c_typeid = @"9c48a2b8-952c-4f5a-935d-f3292326bf54";
static NSString* const c_typename = @"ClinicalDocument";

@implementation HVCCD

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_STRING(m_xml, HVClientError_InvalidCCD);
    
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
    return [[HVItem alloc] initWithType:[HVCCD typeID]];
}

@end
