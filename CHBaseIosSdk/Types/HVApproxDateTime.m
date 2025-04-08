//
//  HVApproxDateTime.m
//  HVLib
//
//


#import "HVCommon.h"
#import "HVApproxDateTime.h"

static NSString* const c_element_descriptive = @"descriptive";
static NSString* const c_element_structured = @"structured";

@implementation HVApproxDateTime

@synthesize descriptive = m_descriptive;
@synthesize dateTime = m_dateTime;

-(void)setDescriptive:(NSString *)descriptive
{
    if (![NSString isNilOrEmpty:descriptive])
    {
        HVCLEAR(m_dateTime);    
    }
    HVRETAIN(m_descriptive, descriptive);
}

-(void)setDateTime:(HVDateTime *)dateTime
{
    if (dateTime)
    {
        HVCLEAR(m_descriptive);
    }
    HVRETAIN(m_dateTime, dateTime);
}

-(BOOL)isStructured
{
    return (m_dateTime != nil);
}

-(id)initWithDescription:(NSString *)descr
{
    HVCHECK_NOTNULL(descr);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.descriptive = descr;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(id)initWithDate:(NSDate *)date
{
    HVDateTime* dateTime = [[HVDateTime alloc] initWithDate:date];
    HVCHECK_NOTNULL(dateTime);
    
    self = [self initWithDateTime:dateTime];
    [dateTime release];
    
    return self;

LError:
    HVALLOC_FAIL;
}

-(id)initWithDateTime:(HVDateTime *)dateTime
{
    HVCHECK_NOTNULL(dateTime);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.dateTime = dateTime;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(id)initNow
{
    return [self initWithDate:[NSDate date]];
}

-(void)dealloc
{
    [m_descriptive release];
    [m_dateTime release];
    [super dealloc];
}

+(HVApproxDateTime *)fromDate:(NSDate *)date
{
    return [[[HVApproxDateTime alloc] initWithDate:date] autorelease];
}

+(HVApproxDateTime *)fromDescription:(NSString *)descr
{
    return [[[HVApproxDateTime alloc] initWithDescription:descr] autorelease];
}

+(HVApproxDateTime *)now
{
    return [[[HVApproxDateTime alloc] initNow] autorelease];
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    if (m_dateTime)
    {
        return [m_dateTime toString];
    }
    
    return (m_descriptive) ? m_descriptive : c_emptyString;
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    if (m_dateTime)
    {
        return [m_dateTime toStringWithFormat:format];
    }
    
    return (m_descriptive) ? m_descriptive : c_emptyString;
}

-(NSDate *)toDate
{
    if (m_dateTime)
    {
        return [m_dateTime toDate];
    }
    
    return nil;
}

-(NSDate *)toDateForCalendar:(NSCalendar *)calendar
{
    if (m_dateTime)
    {
        return [m_dateTime toDateForCalendar:calendar];
    }
    
    return nil;    
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    //
    // The data type is a choice. You can do one or the other
    //
    HVVALIDATE_TRUE((m_dateTime || m_descriptive), HVClientError_InvalidApproxDateTime);
    HVVALIDATE_TRUE((!(m_dateTime && m_descriptive)), HVClientError_InvalidApproxDateTime);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING(m_descriptive, c_element_descriptive);
    HVSERIALIZE(m_dateTime, c_element_structured);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING(m_descriptive, c_element_descriptive);
    HVDESERIALIZE(m_dateTime, c_element_structured, HVDateTime);
}

@end
