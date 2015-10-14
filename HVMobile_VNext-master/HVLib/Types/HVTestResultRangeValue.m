//
//  HVTestResultRangeValue.m
//  HVLib
//
//
//

#import "HVCommon.h"
#import "HVTestResultRangeValue.h"

static const xmlChar* x_element_minRange = XMLSTRINGCONST("minimum-range");
static const xmlChar* x_element_maxRange = XMLSTRINGCONST("maximum-range");

@implementation HVTestResultRangeValue

@synthesize minRange = m_minRange;
@synthesize maxRange = m_maxRange;

-(double)minRangeValue
{
    return m_minRange ? m_minRange.value : NAN;
}
-(void)setMinRangeValue:(double)minRangeValue
{
    if (isnan(minRangeValue))
    {
        HVCLEAR(m_minRange);
    }
    else
    {
        HVENSURE(m_minRange, HVDouble);
        m_minRange.value = minRangeValue;
    }
}

-(double)maxRangeValue
{
    return m_maxRange ? m_maxRange.value : NAN;
}

-(void)setMaxRangeValue:(double)maxRangeValue
{
    if (isnan(maxRangeValue))
    {
        HVCLEAR(m_maxRange);
    }
    else
    {
        HVENSURE(m_maxRange, HVDouble);
        m_maxRange.value = maxRangeValue;
    }
}

-(void)dealloc
{
    [m_minRange release];
    [m_maxRange release];
    
    [super dealloc];
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_minRange, x_element_minRange);
    HVSERIALIZE_X(m_maxRange, x_element_maxRange);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_minRange, x_element_minRange, HVDouble);
    HVDESERIALIZE_X(m_maxRange, x_element_maxRange, HVDouble);
}

@end
