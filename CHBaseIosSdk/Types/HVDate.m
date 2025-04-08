//
//  HVDate.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVDate.h"

static const xmlChar* x_element_year  = XMLSTRINGCONST("y");
static const xmlChar* x_element_month = XMLSTRINGCONST("m");
static const xmlChar* x_element_day   = XMLSTRINGCONST("d");

@implementation HVDate

-(int) year
{
    return (m_year) ? m_year.value : -1;
}

-(void) setYear:(int)year
{
    if (year >= 0)
    {
        HVENSURE(m_year, HVYear);
        m_year.value = year;
    }
    else
    {
        HVCLEAR(m_year);
    }
}

-(int) month
{
    return (m_month) ? m_month.value : -1;
}

-(void) setMonth:(int) month
{
    if (month >= 0)
    {
        HVENSURE(m_month, HVMonth);
        m_month.value = month;
    }
    else
    {
        HVCLEAR(m_month);
    }
}

-(int) day
{
    return (m_day) ? m_day.value : -1;
}

-(void) setDay:(int)day
{
    if (day >= 0)
    {
        HVENSURE(m_day, HVDay);
        m_day.value = day;
    }
    else
    {
        HVCLEAR(m_day);
    }
}

-(id) initNow
{
    return [self initWithDate:[NSDate date]];
}

-(id) initWithDate:(NSDate *) date
{
    HVCHECK_NOTNULL(date);
    
    self = [self initWithComponents:[NSCalendar componentsFromDate:date]];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(id) initWithComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
    
    return [self initWithYear:[components year] month:[components month] day:[components day]];
    
LError:
    HVALLOC_FAIL;
}

-(id) initWithYear:(int) yearValue month:(int) monthValue day:(int) dayValue
{
    self = [super init];
    HVCHECK_SELF;
    
    if (yearValue != NSUndefinedDateComponent)
    {
        m_year = [[HVYear alloc] initWith:yearValue];
    }
    if (monthValue != NSUndefinedDateComponent)
    {
        m_month = [[HVMonth alloc] initWith:monthValue];
    }
    if (dayValue != NSUndefinedDateComponent)
    {
        m_day = [[HVDay alloc] initWith:dayValue];
    }
    
    HVCHECK_TRUE(m_year && m_month && m_day);
  
    return self;

LError:
    HVALLOC_FAIL;
}

-(void) dealloc
{
    [m_year release];
    [m_month release];
    [m_day release];
    [super dealloc];
}

-(BOOL)setWithDate:(NSDate *)date
{
    return [self setWithComponents:[NSCalendar componentsFromDate:date]];
}

-(BOOL)setWithComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
    
    HVCLEAR(m_year);
    HVCLEAR(m_month);
    HVCLEAR(m_day);
    
    m_year = [[HVYear alloc] initWith:components.year];
    m_month = [[HVMonth alloc] initWith:components.month];
    m_day = [[HVDay alloc] initWith:components.day];

    HVCHECK_TRUE(m_year && m_month && m_day);
    
    return TRUE;
    
LError:
    return FALSE;
}

+(HVDate *)fromDate:(NSDate *)date
{
    return [[[HVDate alloc] initWithDate:date] autorelease];
}

+(HVDate *)fromYear:(int)year month:(int)month day:(int)day
{
    return [[[HVDate alloc] initWithYear:year month:month day:day] autorelease];
}

+(HVDate *)now
{
    return [[[HVDate alloc] initNow] autorelease];
}

-(NSDateComponents *) toComponents
{
    NSDateComponents *components = [[NSCalendar newComponents] autorelease];
    HVCHECK_NOTNULL(components);
    
    HVCHECK_SUCCESS([self getComponents:components]);
    
    return components;
    
LError:
    return nil;
}

-(NSDateComponents *)toComponentsForCalendar:(NSCalendar *)calendar
{
    NSDateComponents *components = [calendar componentsForCalendar];
    HVCHECK_NOTNULL(components);
    
    HVCHECK_SUCCESS([self getComponents:components]);
    
    return components;
    
LError:
    return nil;    
}

-(BOOL) getComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
    
    if (m_year)
    {
        [components setYear:self.year];
    }
    if (m_month)
    {
        [components setMonth:self.month];
    }
    if (m_day)
    {
        [components setDay:self.day];
    }
     
    return TRUE;

LError:
    return FALSE;
}

-(NSDate *) toDate
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

-(NSString *)description
{
    return [self toString];
}

-(NSString *) toString
{
    return [self toStringWithFormat:@"MM/dd/yy"];   
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    NSDate* date = [self toDate];
    return [date toStringWithFormat:format];
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_year, HVClientError_InvalidDate);
    HVVALIDATE(m_month, HVClientError_InvalidDate);
    HVVALIDATE(m_day, HVClientError_InvalidDate);
      
    HVVALIDATE_SUCCESS;

LError:
    HVVALIDATE_FAIL;
}

-(void) serialize:(XWriter *) writer
{
    HVSERIALIZE_X(m_year, x_element_year);
    HVSERIALIZE_X(m_month, x_element_month);
    HVSERIALIZE_X(m_day, x_element_day);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_year, x_element_year, HVYear);
    HVDESERIALIZE_X(m_month, x_element_month, HVMonth);
    HVDESERIALIZE_X(m_day, x_element_day, HVDay);
}

@end

