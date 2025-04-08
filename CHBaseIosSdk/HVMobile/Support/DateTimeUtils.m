//
//  DateTimeUtils.m
//  CHBase Mobile Library for iOS
//
//

#import "DateTimeUtils.h"
#import "HVDateExtensions.h"


@implementation DateTimeUtils

+ (NSString *)dateToUtcString: (NSDate *)date {

	NSDateFormatter *formatter = [NSDateFormatter new];
    NSLocale* locale = [NSDateFormatter newCultureNeutralLocale];
    [formatter setLocale:locale];
    
	[formatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
	[formatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation: @"UTC"]];
	NSString *utcDateString = [formatter stringFromDate: date];
    
	[formatter release];
    [locale release];
    
	return utcDateString;
}
/*
+ (NSDate *)UtcStringToDate: (NSString *)string {
	
	NSDateFormatter *formatter = [NSDateFormatter new];
	[formatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation: @"UTC"]];
	
	[formatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSS"];
	NSDate *utcDate = [formatter dateFromString: string];
	
	if (utcDate == nil) {
		
		[formatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss"];
		utcDate = [formatter dateFromString: string];
	}
	
	[formatter release];
	
	return utcDate;
}
*/

@end
