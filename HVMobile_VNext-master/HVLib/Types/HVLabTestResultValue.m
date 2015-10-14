//
//  HVLabTestResultValue.m
//  HVLib
//
//
//
//
#import "HVCommon.h"
#import "HVLabTestResultValue.h"

static const xmlChar* x_element_measurement = XMLSTRINGCONST("measurement");
static NSString* const c_element_ranges = @"ranges";
static const xmlChar* x_element_ranges = XMLSTRINGCONST("ranges");
static const xmlChar* x_element_flag = XMLSTRINGCONST("flag");

@implementation HVLabTestResultValue

@synthesize measurement = m_measurement;
@synthesize ranges = m_ranges;
@synthesize flag = m_flag;
-(BOOL)hasRanges
{
    return ![NSArray isNilOrEmpty:m_ranges];
}

-(void)dealloc
{
    [m_measurement release];
    [m_ranges release];
    [m_flag release];
    
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_measurement, HVClientError_InvalidLabTestResultValue);
    HVVALIDATE_ARRAYOPTIONAL(m_ranges, HVClientError_InvalidLabTestResultValue);
    HVVALIDATE_OPTIONAL(m_flag);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_measurement, x_element_measurement);
    HVSERIALIZE_ARRAY(m_ranges, c_element_ranges);
    HVSERIALIZE_X(m_flag, x_element_flag);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_measurement, x_element_measurement, HVApproxMeasurement);
    HVDESERIALIZE_TYPEDARRAY_X(m_ranges, x_element_ranges, HVTestResultRange, HVTestResultRangeCollection);
    HVDESERIALIZE_X(m_flag, x_element_flag, HVCodableValue);
}

@end
