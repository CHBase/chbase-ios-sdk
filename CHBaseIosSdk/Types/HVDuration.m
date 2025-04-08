//
//  HVDuration.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVDuration.h"

static NSString* const c_element_start = @"start-date";
static NSString* const c_element_end = @"end-date";

@implementation HVDuration

@synthesize startDate = m_startDate;
@synthesize endDate = m_endDate;

-(id)initWithStartDate:(NSDate *)start endDate:(NSDate *)end
{
    HVCHECK_NOTNULL(start);
    HVCHECK_NOTNULL(end);
        
    m_startDate = [[HVApproxDateTime alloc] initWithDate:start];
    HVCHECK_NOTNULL(m_startDate);
    
    m_endDate = [[HVApproxDateTime alloc] initWithDate:end];
    HVCHECK_NOTNULL(m_endDate);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(id)initWithDate:(NSDate *)start andDurationInSeconds:(double)duration
{
    return [self initWithStartDate:start endDate:[start dateByAddingTimeInterval:duration]];
}

-(void)dealloc
{
    [m_startDate release];
    [m_endDate release];
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_startDate, HVClientError_InvalidDuration);
    HVVALIDATE(m_endDate, HVClientError_InvalidDuration);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_startDate, c_element_start);
    HVSERIALIZE(m_endDate, c_element_end);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_startDate, c_element_start, HVApproxDateTime);    
    HVDESERIALIZE(m_endDate, c_element_end, HVApproxDateTime);    
}

@end
