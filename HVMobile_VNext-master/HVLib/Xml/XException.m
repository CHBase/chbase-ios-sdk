//
//  XException.m
//  HVLib
//
//

#import "XException.h"
#import "XString.h"

NSString* const XExceptionInvalidNodeType = @"X_InvalidNodeType";
NSString* const XExceptionNotElement = @"X_NotElement";
NSString* const XExceptionElementMismatch = @"X_ElementMismatch";
NSString* const XExceptionTypeConversion = @"X_TypeConversion";
NSString* const XExceptionNotText = @"X_NotText";
NSString* const XExceptionReaderError = @"X_ReaderError";
NSString* const XExceptionWriterError = @"X_WriterError";
NSString* const XExceptionRequiredDataMissing = @"X_RequiredDataMissing";

@implementation XException

+(void) throwException:(NSString*) exceptionName reason:(NSString *) reason
{
    @throw [[[XException alloc] initWithName:exceptionName reason:reason userInfo:nil] autorelease];  
}

+(void) throwException:(NSString *)exceptionName lineNumber:(int)line columnNumber:(int)col
{
    NSString *reason = [NSString stringWithFormat:@"line=%d, col=%d", line, col];
    @throw [[[XException alloc] initWithName:exceptionName reason:reason userInfo:nil] autorelease];
}

+(void) throwException:(NSString *)exceptionName reason:(NSString *) reason fromReader:(xmlTextReader *)reader
{
    int line = 0;
    int col = 0;
    if (reader)
    {
        line = xmlTextReaderGetParserLineNumber(reader);
        col = xmlTextReaderGetParserColumnNumber(reader);
    }
    
    NSString *message;
    if (reason == nil)
    {
        message = [NSString stringWithFormat:@"line=%d, col=%d", line, col];
    }
    else
    {
        message = [NSString stringWithFormat:@"%@ line=%d, col=%d", reason, line, col];       
    }
    @throw [[[XException alloc] initWithName:exceptionName reason:message userInfo:nil] autorelease];
}

+(void)throwException:(NSString *)exceptionName xmlReason:(const xmlChar *)reason fromReader:(xmlTextReader *)reader
{
    return [XException throwException:exceptionName reason:[NSString fromConstXmlString:reason] fromReader:reader];
}

+(void) throwException:(NSString *)exceptionName fromReader:(xmlTextReader *)reader
{
    [XException throwException:exceptionName reason:nil fromReader:reader];
}

@end
