//
//  XException.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import <libxml/XmlReader.h>

extern NSString* const XExceptionInvalidNodeType;
extern NSString* const XExceptionNotElement;
extern NSString* const XExceptionElementMismatch;
extern NSString* const XExceptionTypeConversion;
extern NSString* const XExceptionNotText;
extern NSString* const XExceptionReaderError;
extern NSString* const XExceptionWriterError;
extern NSString* const XExceptionRequiredDataMissing;

@interface XException : NSException

+(void) throwException:(NSString*) exceptionName reason:(NSString *) reason;
+(void) throwException:(NSString*) exceptionName reason:(NSString *) reason fromReader:(xmlTextReader *) reader;
+(void) throwException:(NSString*) exceptionName xmlReason:(const xmlChar *) reason fromReader:(xmlTextReader *) reader;
+(void) throwException:(NSString*) exceptionName fromReader:(xmlTextReader *) reader;
+(void) throwException:(NSString*) exceptionName lineNumber:(int) line columnNumber:(int) col;

@end
