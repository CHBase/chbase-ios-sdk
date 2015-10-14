//
//  NSString+StringExtensions.h
//  HVLib
//
//

#import <Foundation/Foundation.h>

extern NSString* const c_emptyString;

//---------------------------------
//
// NSString
//
//---------------------------------
@interface NSString (HVNSStringExtensions)

+(BOOL) isNilOrEmpty:(NSString *) string;

-(BOOL) isEmpty;
-(NSString *) trim;

-(NSRange) getRange;
-(BOOL) isIndexInRange:(NSUInteger) index;

-(BOOL) isEqualToStringCaseInsensitive:(NSString *)aString;

-(NSScanner *) newScanner;

-(NSUInteger) indexOfFirstChar:(unichar) ch;
-(NSUInteger) indexOfFirstCharInSet:(NSCharacterSet *) charSet;
-(NSUInteger) indexOfFirstCharNotInSet:(NSCharacterSet *) charSet;

-(NSUInteger) indexOfLastChar:(unichar) ch;
-(NSUInteger) indexOfLastCharInSet:(NSCharacterSet *) charSet;
-(NSUInteger) indexOfLastCharNotInSet:(NSCharacterSet *) charSet;

-(BOOL) contains:(NSString *) other;

-(BOOL) parseDouble:(double*) pValue;
-(BOOL) parseFloat:(float*) pValue;
-(BOOL) parseInt:(int*) pValue;

-(NSString *) stringByAppendingName:(NSString *) name andExtension:(NSString *) ext;
-(NSString *) urlEncode;

-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;

@end

//---------------------------------
//
// NSString
//
//---------------------------------
@interface NSMutableString (HVNSMutableStringExtensions) 

-(void) clear;

-(BOOL) setStringAndVerify:(NSString *)aString;

-(void) appendNewLine;
-(void) appendNewLines:(int) count;
-(void) appendLines:(int) count, ...;
-(void) appendStrings:(NSArray *) strings;
-(void) appendStringAsLine:(NSString *) string;
-(void) appendStringsAsLines:(NSArray *) strings;

-(void) appendOptionalString:(NSString *) string;
-(void) appendOptionalString:(NSString *)string withSeparator:(NSString *) separator;
-(void) appendOptionalStringAsLine:(NSString *) string;
-(void) appendOptionalStringOnNewLine:(NSString *) string;
-(void) appendOptionalWords:(NSString *) string;

-(NSString *) trim;
-(void) trimLeft;
-(void) trimRight;

-(NSUInteger) replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement;

-(void) appendXmlElementStart:(NSString *) tag;
-(void) appendXmlElementEnd:(NSString *) tag;
-(void) appendXmlElement:(NSString *) tag text:(NSString *) text;

@end

CFStringRef HVUrlEncode(CFStringRef source);
