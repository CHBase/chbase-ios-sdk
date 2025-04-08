//
//  HVTime.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVTime.h"

static const xmlChar* x_element_hour = XMLSTRINGCONST("h");
static const xmlChar* x_element_minute = XMLSTRINGCONST("m");
static const xmlChar* x_element_second = XMLSTRINGCONST("s");
static const xmlChar* x_element_millis = XMLSTRINGCONST("f");

@implementation HVTime

-(int) hour
{
    return (m_hours ? m_hours.value : -1);
}

-(void) setHour:(int) hours
{
    if (hours >= 0)
    {
        HVENSURE(m_hours, HVHour);
        m_hours.value = hours;
    }
    else
    {
        HVCLEAR(m_hours);
    }
}

-(int) minute
{
    return (m_minutes ? m_minutes.value : -1);
}

-(void) setMinute:(int)minutes
{
    if (minutes >= 0)
    {
        HVENSURE(m_minutes, HVMinute);
        m_minutes.value = minutes;        
    }
    else
    {
        HVCLEAR(m_minutes);
    }
}

-(BOOL)hasSecond
{
    return (m_seconds != nil);
}

-(int) second
{
    return (m_seconds ? m_seconds.value : -1);
}

-(void) setSecond:(int)seconds
{
    if (seconds >= 0)
    {
        HVENSURE(m_seconds, HVSecond);
        m_seconds.value = seconds;       
    }
    else
    {
        HVCLEAR(m_seconds);
    }
}

-(BOOL)hasMillisecond
{
    return (m_seconds != nil);
}

-(int) millisecond
{
    return (m_milliseconds ? m_milliseconds.value : -1);
}

-(void) setMillisecond:(int)milliseconds
{
    if (milliseconds >= 0)
    {
        HVENSURE(m_milliseconds, HVMillisecond);
        m_milliseconds.value = milliseconds;
        
    }
    else
    {
        HVCLEAR(m_milliseconds);
    }
}

+(void)initialize
{
}

-(id)initWithHour:(int)hour minute:(int)minute
{
    return [self initWithHour:hour minute:minute second:-1];
}

-(id) initWithHour:(int)hour minute:(int)minute second:(int)second
{
    self = [super init];
    HVCHECK_SELF;
    
    if (hour != NSUndefinedDateComponent)
    {
        m_hours = [[HVHour alloc] initWith:hour];
    }
    HVCHECK_NOTNULL(m_hours);
    
    if (minute != NSUndefinedDateComponent)
    {
        m_minutes = [[HVMinute alloc] initWith:minute];
    }
    HVCHECK_NOTNULL(m_minutes);
    
    if (second >= 0 && second != NSUndefinedDateComponent)
    {
        m_seconds = [[HVSecond alloc] initWith:second];
        HVCHECK_NOTNULL(m_seconds);
    }
        
    return self;

LError:
    HVALLOC_FAIL;
}

-(id) initwithComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
    
    return [self initWithHour:[components hour] minute:[components minute] second:[components second]];
     
LError:
    HVALLOC_FAIL;    
}

-(id) initWithDate:(NSDate *)date
{
    HVCHECK_NOTNULL(date);
    
    return [self initwithComponents:[NSCalendar componentsFromDate:date]]; 
      
LError:
    HVALLOC_FAIL;
}

+(HVTime *)fromHour:(int)hour andMinute:(int)minute
{
    return [[[HVTime alloc] initWithHour:hour minute:minute] autorelease];
}

-(void) dealloc
{
    [m_hours release];
    [m_minutes release];
    [m_seconds release];
    [m_milliseconds release];
    [super dealloc];
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

-(BOOL) getComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
  
    if (m_hours)
    {
        [components setHour:self.hour];
    }
    if (m_minutes)
    {
        [components setMinute:self.minute];        
    }
    if (m_seconds)
    {
        [components setSecond:self.second];
    }
    
    return TRUE;
    
LError:
    return FALSE;
}

-(NSDate *) toDate
{
    NSDateComponents *components = [NSCalendar newComponents];
    HVCHECK_NOTNULL(components);
    
    HVCHECK_SUCCESS([self getComponents:components]);
    
    NSDate* newDate = [components date];
    [components release];
    
    return newDate;
    
LError:
    [components release];
    return nil;
}

-(BOOL)setWithComponents:(NSDateComponents *)components 
{
    HVCHECK_NOTNULL(components);
    
    self.hour = [components hour];
    self.minute = [components minute];
    self.second = [components second];
    
    return TRUE;

LError:
    return FALSE;
}

-(BOOL)setWithDate:(NSDate *)date
{
    HVCHECK_NOTNULL(date);
    
    return [self setWithComponents:[NSCalendar componentsFromDate:date]]; 
    
LError:
    return FALSE;
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *) toString
{
    return [self toStringWithFormat:@"hh:mm aaa"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    NSDate *date = [self toDate];
    return [date toStringWithFormat:format];
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_hours, HVClientError_InvalidTime);
    HVVALIDATE(m_minutes, HVClientError_InvalidTime);
    HVVALIDATE_OPTIONAL(m_seconds);
    HVVALIDATE_OPTIONAL(m_milliseconds);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_hours, x_element_hour);
    HVSERIALIZE_X(m_minutes, x_element_minute);
    HVSERIALIZE_X(m_seconds, x_element_second);
    HVSERIALIZE_X(m_milliseconds, x_element_millis);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_hours, x_element_hour, HVHour);
    HVDESERIALIZE_X(m_minutes, x_element_minute, HVMinute);
    HVDESERIALIZE_X(m_seconds, x_element_second, HVSecond);
    HVDESERIALIZE_X(m_milliseconds, x_element_millis, HVMillisecond);
}

@end

@implementation HVTimeCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVTime class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVTime *)itemAtIndex:(NSUInteger)index
{
    return (HVTime *) [self objectAtIndex:index];
}

@end
