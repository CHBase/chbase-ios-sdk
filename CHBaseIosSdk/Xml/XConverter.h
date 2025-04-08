//
//  XConverter.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import "XException.h"

@interface XConverter : NSObject
{
    NSDateFormatter *m_parser;
    NSDateFormatter *m_utcParser;
    NSDateFormatter *m_formatter;
    NSCalendar* m_calendar;
    NSLocale* m_dateLocale;
    NSMutableString *m_stringBuffer;
}

-(BOOL) tryString:(NSString *) source toInt:(int *) result;
-(int) stringToInt:(NSString *) source;
-(BOOL) tryInt:(int) source toString:(NSString **) result;
-(NSString *) intToString:(int) source;

-(BOOL) tryString:(NSString *) source toFloat:(float *) result;
-(float) stringToFloat:(NSString *) source;
-(BOOL) tryFloat:(float) source toString:(NSString **) result;
-(NSString *) floatToString:(float) source;

//
// Try to parse the given Xml string into a double.
// Automatically takes care of trimming for leading/trailing spaces
//
-(BOOL) tryString:(NSString *) source toDouble:(double *) result;
-(double) stringToDouble:(NSString *) source;

-(BOOL) tryDouble:(double) source toString:(NSString **) result;
-(BOOL) tryDoubleRoundtrip:(double) source toString:(NSString **) result;
-(NSString *) doubleToString:(double) source;

-(BOOL) tryString:(NSString *) source toBool:(BOOL *) result;
-(BOOL) stringToBool:(NSString *) source;
-(NSString *) boolToString:(BOOL) source;

-(BOOL) tryString:(NSString *) source toDate:(NSDate **) result;
-(NSDate*) stringToDate:(NSString *) source;
-(BOOL) tryDate:(NSDate *) source toString:(NSString **) result;
-(NSString*) dateToString:(NSDate *) source;

-(BOOL) tryString:(NSString *) source toGuid:(CFUUIDRef *) result;
-(CFUUIDRef) stringToGuid:(NSString *) source;
-(BOOL) tryGuid:(CFUUIDRef)guid toString:(NSString **) result;
-(NSString *) guidToString:(CFUUIDRef) guid;

@end
