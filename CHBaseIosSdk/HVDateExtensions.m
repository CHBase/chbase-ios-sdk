//
//  HVDateExtensions.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVDateExtensions.h"
#import "HVValidator.h"


@implementation NSDate (HVExtensions)

-(NSString *)toString
{
    return self.description;
}

-(NSString*) toStringWithFormat:(NSString *)format
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init]; 
    HVCHECK_NOTNULL(formatter);
    
    NSString* string = [formatter dateToString:self withFormat:format];
    [formatter release];
    
    return string;
    
LError:
    return nil;
}

-(NSString *)toZuluString
{
    NSDateFormatter* formatter = [NSDateFormatter newZuluFormatter];
    HVCHECK_NOTNULL(formatter);
    
    NSString* string = [formatter dateTimeToString:self];
    
    [formatter release];
    
    return string;

LError:
    return nil;
}

-(NSString *)toStringWithStyle:(NSDateFormatterStyle)style
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init]; 
    HVCHECK_NOTNULL(formatter);
    
    NSString* string = [formatter dateToString:self withStyle:style];
    [formatter release];
    
    return string;
    
LError:
    return nil;
}

-(NSComparisonResult) compareDescending:(NSDate *)other
{
    return -([self compare:other]);
}

-(BOOL)isEqualToDateAccuracySeconds:(NSDate *)other
{
    double interval = (double) [self timeIntervalSinceDate:other];
    return (interval <= 1);
}

-(NSTimeInterval)offsetFromNow
{
    return [[NSDate date] timeIntervalSinceDate:self];
}

+(NSDate *)fromHour:(int)hour
{
    return [NSDate fromHour:hour andMinute:0];
}

+(NSDate *)fromHour:(int)hour andMinute:(int)minute
{
    NSDateComponents *components = [NSCalendar newComponents];
    HVCHECK_NOTNULL(components);
    
    components.hour = hour;
    components.minute = minute;
    
    NSDate* newDate = [components date];
    [components release];
    
    return newDate;
    
LError:
    [components release];
    return nil;
}

+(NSDate *)fromYear:(int)year month:(int)month andDay:(int)day
{
    NSDateComponents *components = [NSCalendar newComponents];
    HVCHECK_NOTNULL(components);
    
    components.year = year;
    components.month = month;
    components.day = day;
    
    NSDate* newDate = [components date];
    [components release];
    
    return newDate;
    
LError:
    [components release];
    return nil;    
}

-(NSDate *)toStartOfDay
{
    NSCalendar* calendar = [NSCalendar newGregorian];
    HVCHECK_NOTNULL(calendar);
    
    NSDate* day = [[calendar yearMonthDayFrom:self] date];
    
    [calendar release];
    
    return day;
    
LError:
    return nil;
}

-(NSDate *)toEndOfDay
{
    NSCalendar* calendar = [NSCalendar newGregorian];
    HVCHECK_NOTNULL(calendar);
    
    NSDateComponents* dateComponents = [calendar getComponentsFor:self];
    dateComponents.hour = 23;
    dateComponents.minute = 59;
    dateComponents.second = 59;
    
    NSDate* day = [calendar dateFromComponents:dateComponents];
    [calendar release];
    
    return day;
    
LError:
    return nil;    
}

+(NSDate *)yesterday
{
    //
    // 86400 seconds in a day
    // This method doesn't need to be perfect - just good enough.
    //
    return [NSDate dateWithTimeIntervalSinceNow:-86400]; 
}

@end


const NSUInteger NSAllCalendarUnits =   NSDayCalendarUnit       | 
                                        NSMonthCalendarUnit     | 
                                        NSYearCalendarUnit      | 
                                        NSHourCalendarUnit      | 
                                        NSMinuteCalendarUnit    | 
                                        NSSecondCalendarUnit;

@implementation NSCalendar (HVExtensions)

-(NSDateComponents *)componentsForCalendar
{
    NSDateComponents* components = [[[NSDateComponents alloc] init] autorelease];
    [components setCalendar:self];
    
    return components;
}

-(NSDateComponents *)getComponentsFor:(NSDate *)date
{
    return [self components: NSAllCalendarUnits fromDate: date];
}

-(NSDateComponents *)yearMonthDayFrom:(NSDate *)date
{
    NSDateComponents* components =  [self components: NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    [components setCalendar:self];
    
    return components;
}

+(NSDateComponents *) componentsFromDate:(NSDate *)date
{
    HVCHECK_NOTNULL(date);
    
    NSCalendar* calendar = [NSCalendar newGregorian];
    HVCHECK_NOTNULL(calendar);
    
    NSDateComponents* components = [calendar getComponentsFor:date];
    [calendar release];
    
    return components;
    
LError:
    return nil;
    
}

+(NSDateComponents *) newComponents
{
    NSCalendar* calendar = [NSCalendar newGregorian];
    HVCHECK_NOTNULL(calendar);
    
    NSDateComponents* components = [[NSDateComponents alloc] init];
    HVCHECK_NOTNULL(components);
    
    [components setCalendar:calendar];
    [calendar release];
    
    return components;
    
LError:
    [calendar release];
    return nil;
}

+(NSDateComponents *) newUtcComponents
{
    NSCalendar* calendar = [NSCalendar newGregorianUtc];
    HVCHECK_NOTNULL(calendar);
    
    NSDateComponents* components = [[NSDateComponents alloc] init];
    HVCHECK_NOTNULL(components);
    
    [components setCalendar:calendar];
    [calendar release];
    
    return components;

LError:
    [calendar release];
    return nil;
}

+(NSDateComponents *) utcComponentsFromDate:(NSDate *)date
{
    HVCHECK_NOTNULL(date);
    
    NSCalendar* calendar = [NSCalendar newGregorianUtc];
    HVCHECK_NOTNULL(calendar);
    
    NSDateComponents* components = [calendar getComponentsFor:date];
    [calendar release];
    
    return components;

LError:
    return nil;
}

+(NSCalendar *) newGregorian
{
    return [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
}

+(NSCalendar *) newGregorianUtc
{
    NSCalendar *calendar = [NSCalendar newGregorian];
    if (calendar)
    {
        [calendar setTimeZone: [NSTimeZone timeZoneWithAbbreviation: @"UTC"]];
    }
    return calendar;
}

@end

@implementation NSDateFormatter (HVExtensions)

+(NSDateFormatter *) newUtcFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (formatter)
    {
        [formatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    }
    
    return formatter;
}

+(NSDateFormatter *) newZuluFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (formatter)
    {
        [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH:mm:ss.SSS'Z'"]; // Zulu time format
    }
    
    return formatter;
}

-(NSString *) dateToString:(NSDate *)date withFormat:(NSString *)format
{
    NSString* currentFormat = [self dateFormat];
    
    [self setDateFormat:format];
    NSString* dateString = [self stringFromDate:date];
    
    [self setDateFormat:currentFormat];
    
    return dateString;  
}

-(NSString *)dateToString:(NSDate *)date withStyle:(NSDateFormatterStyle)style
{
    NSDateFormatterStyle currentDateStyle = [self dateStyle];
    
    [self setDateStyle:style];
    NSString* dateString = [self stringFromDate:date];   
    
    [self setDateStyle:currentDateStyle];
    
    return dateString;  
}

-(NSString *)dateTimeToString:(NSDate *)date withStyle:(NSDateFormatterStyle)style
{
    NSDateFormatterStyle currentDateStyle = [self dateStyle];
    NSDateFormatterStyle currentTimeStyle = [self timeStyle];
    
    [self setDateStyle:style];
    [self setTimeStyle:style];
    
    NSString* dateString = [self stringFromDate:date];   
    
    [self setDateStyle:currentDateStyle];
    [self setTimeStyle:currentTimeStyle];
    
    return dateString;  

}

-(NSString *)dateTimeToString:(NSDate *)date
{
    return [self dateToString:date withFormat:@"MM/dd/yy hh:mm aaa"];
}

+(NSLocale *)newCultureNeutralLocale
{
    NSLocale* locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    return locale;
}

@end

@implementation NSDateComponents (HVExtensions)

+(BOOL)isEqualYearMonthDay:(NSDateComponents *)d1 and:(NSDateComponents *)d2
{
    return (d1.year == d2.year && d1.month == d2.month && d1.day == d2.day);
}

+(NSComparisonResult)compareYearMonthDay:(NSDateComponents *)d1 and:(NSDateComponents *)d2
{
    NSInteger cmp = d1.year - d2.year;
    if (cmp != 0)
    {
        return (cmp > 0) ? NSOrderedDescending : NSOrderedAscending;
    }
    //
    // Year is equal
    //
    cmp = d1.month - d2.month;
    if (cmp != 0)
    {
        return (cmp > 0) ? NSOrderedDescending : NSOrderedAscending;
    }
    //
    // Month is equal
    //
    cmp = d1.day - d2.day;
    if (cmp != 0)
    {
        return (cmp > 0) ? NSOrderedDescending : NSOrderedAscending;
    }
    
    return NSOrderedSame;
}

@end