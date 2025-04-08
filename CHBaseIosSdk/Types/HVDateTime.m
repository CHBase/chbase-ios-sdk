//
//  DateTime.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVDateTime.h"

static const xmlChar* x_element_date = XMLSTRINGCONST("date");
static const xmlChar* x_element_time = XMLSTRINGCONST("time");
static const xmlChar* x_element_timeZone = XMLSTRINGCONST("tz");

@implementation HVDateTime

@synthesize date = m_date;
@synthesize time = m_time;
@synthesize timeZone = m_timeZone;

-(BOOL) hasTime
{
    return (m_time != nil);
}

-(BOOL) hasTimeZone
{
    return (m_timeZone != nil);
}

-(id) initNow
{
    return [self initWithDate:[NSDate date]];
}

-(id) initWithDate:(NSDate *) dateValue
{
    HVCHECK_NOTNULL(dateValue);
    
    NSDateComponents *components = [NSCalendar componentsFromDate:dateValue];
    HVCHECK_NOTNULL(components);
    
    return [self initwithComponents:components];
    
LError:
    HVALLOC_FAIL;
}

-(id) initwithComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
    
    self = [super init];
    HVCHECK_SELF;
    
    m_date = [[HVDate alloc] initWithComponents:components];
    m_time = [[HVTime alloc] initwithComponents:components];
    
    HVCHECK_TRUE(m_date && m_time);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

+(HVDateTime *)now
{
    return [[[HVDateTime alloc] initNow] autorelease];
}

+(HVDateTime *)fromDate:(NSDate *)date
{
    return [[[HVDateTime alloc] initWithDate:date] autorelease];
}

-(BOOL) setWithDate:(NSDate *) dateValue
{
    HVCHECK_NOTNULL(dateValue);
    
    NSDateComponents *components = [NSCalendar componentsFromDate:dateValue];
    HVCHECK_NOTNULL(components);
    
    return [self setWithComponents:components];

LError:
    return FALSE;
}

-(BOOL) setWithComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
    
    HVCLEAR(m_date);
    HVCLEAR(m_time);
    
    m_date = [[HVDate alloc] initWithComponents:components];
    m_time = [[HVTime alloc] initwithComponents:components];
    
    HVCHECK_TRUE(m_date && m_time);
    
    return TRUE;
    
LError:
    return FALSE;
}

-(void) dealloc
{
    [m_date release];
    [m_time release];
    [m_timeZone release];
    [super dealloc];
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *) toString
{
    return [self toStringWithFormat:@"MM/dd/yy hh:mm aaa"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    NSDate *date = [self toDate];
    return [date toStringWithFormat:format];
}

-(NSDateComponents *) toComponents
{
    NSDateComponents *components = [NSCalendar newComponents];
    HVCHECK_SUCCESS([self getComponents:components]);
    
    return [components autorelease];
    
LError:
    [components release];
    return nil;
}

-(BOOL) getComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
    HVCHECK_NOTNULL(m_date);
    
    [m_date getComponents:components];
    if (m_time)
    {
        [m_time getComponents:components];
    }
    
    return TRUE;
    
LError:
    return FALSE;
}

-(NSDate *)toDate
{
    NSCalendar* calendar = [NSCalendar newGregorian];
    HVCHECK_NOTNULL(calendar);
    
    NSDate *date = [self toDateForCalendar:calendar];
    [calendar release];
    
    return date;
    
LError:
    return nil;
}

-(NSDate *)toDateForCalendar:(NSCalendar *)calendar
{
    HVCHECK_NOTNULL(calendar);
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    HVCHECK_NOTNULL(components);
    
    HVCHECK_SUCCESS([self getComponents:components]);
    
    NSDate *date = [calendar dateFromComponents:components];
    [components release];
    
    return date;
    
LError:
    [components release];
    return nil;    
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_date, HVClientError_InvalidDateTime);
    HVVALIDATE_OPTIONAL(m_time);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_date, x_element_date);
    HVSERIALIZE_X(m_time, x_element_time);
    HVSERIALIZE_X(m_timeZone, x_element_timeZone);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_date, x_element_date, HVDate);
    HVDESERIALIZE_X(m_time, x_element_time, HVTime);
    HVDESERIALIZE_X(m_timeZone, x_element_timeZone, HVCodableValue);
}

@end
