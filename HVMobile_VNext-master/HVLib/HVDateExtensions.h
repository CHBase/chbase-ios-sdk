//
//  HVDateExtensions.h
//  HVLib
//
//

#import <Foundation/Foundation.h>

extern const NSUInteger NSAllCalendarUnits;

@interface NSDate (HVExtensions)

-(NSString*) toString;
-(NSString*) toStringWithFormat:(NSString*) format;
-(NSString *) toZuluString;
-(NSString*) toStringWithStyle:(NSDateFormatterStyle) style;

-(NSComparisonResult) compareDescending:(NSDate*) other;
-(BOOL) isEqualToDateAccuracySeconds:(NSDate *) other;

+(NSDate *) fromHour:(int) hour;
+(NSDate *) fromHour:(int)hour andMinute:(int) minute;
+(NSDate *) fromYear:(int)year month:(int) month andDay:(int)day;

-(NSTimeInterval) offsetFromNow;
-(NSDate *) toStartOfDay;
-(NSDate *) toEndOfDay;

+(NSDate *) yesterday;

@end


@interface NSCalendar (HVExtensions)

-(NSDateComponents *) componentsForCalendar;
-(NSDateComponents *) getComponentsFor:(NSDate *) date;
-(NSDateComponents *) yearMonthDayFrom:(NSDate *) date;

+(NSDateComponents *) componentsFromDate:(NSDate *) date;
+(NSDateComponents *) newComponents;

+(NSDateComponents *) newUtcComponents;
+(NSDateComponents *) utcComponentsFromDate:(NSDate *)date;

+(NSCalendar *) newGregorian;
+(NSCalendar *) newGregorianUtc;

@end

@interface NSDateFormatter (HVExtensions) 

+(NSDateFormatter *) newUtcFormatter;
+(NSDateFormatter *) newZuluFormatter;

-(NSString *) dateToString:(NSDate*) date withFormat:(NSString*) format;
-(NSString *) dateToString:(NSDate*) date withStyle:(NSDateFormatterStyle) style;
-(NSString *) dateTimeToString:(NSDate*) date withStyle:(NSDateFormatterStyle) style;
-(NSString *) dateTimeToString:(NSDate *)date;

+(NSLocale *) newCultureNeutralLocale;

@end

@interface NSDateComponents (HVExtensions)

+(BOOL)isEqualYearMonthDay:(NSDateComponents *)d1 and:(NSDateComponents *)d2;
+(NSComparisonResult) compareYearMonthDay:(NSDateComponents *)d1 and:(NSDateComponents *)d2;

@end

