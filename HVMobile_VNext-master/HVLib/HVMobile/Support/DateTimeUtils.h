//
//  DateTimeUtils.h
//  CHBase Mobile Library for iOS
//
//

#import <Foundation/Foundation.h>

/// Provides date conversion utilities.
@interface DateTimeUtils : NSObject

/// Converts date to UTC formatted string.
/// @param date - date to be converted.
/// @returns UTC formatted string.
+ (NSString *)dateToUtcString: (NSDate *)date;

/// Converts string with date in UTC format to date object.
/// @param string - string to be converted.
/// @returns date in UTC format.
//+ (NSDate *)UtcStringToDate: (NSString *)string;

@end
