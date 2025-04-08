//
//  HVExceptionExtensions.m
//  HVLib
//
//

#import "HVExceptionExtensions.h"
#import "HVCommon.h"

@implementation NSException (HVExceptionExtensions)

+(void) throwException:(NSString *)exceptionName
{
    @throw [NSException exceptionWithName:exceptionName reason:@"" userInfo:nil];
}

+(void) throwException:(NSString *)exceptionName reason:(NSString *)reason
{
    @throw [NSException exceptionWithName:exceptionName reason:reason userInfo:nil];
}

+(void) throwInvalidArg
{
    [NSException throwException:NSInvalidArgumentException];
}

+(void) throwInvalidArgWithReason:(NSString *)reason
{
    [NSException throwException:NSInvalidArgumentException reason:reason];    
}

+(void) throwOutOfMemory
{
    [NSException throwException:NSMallocException];
}

+(void) throwNotImpl
{
    [NSException throwException:@"NotImplementedException"];
}

-(void) printSymbolsTo:(NSMutableString *)buffer
{
    HVASSERT_NOTNULL(buffer);
    
    if (buffer)
    {
        NSArray* symbols = [self callStackSymbols];
        [buffer appendStringsAsLines:symbols];
    }    
}

-(NSString *) detailedDescription
{
    NSMutableString *buffer = [[[NSMutableString alloc] init]autorelease];
    if (buffer)
    {
        [buffer appendLines:1, [self description]];
        [buffer appendNewLine];
        [buffer appendLines:2, [self name], [self reason]];
#ifdef DEBUG
        [buffer appendNewLines:2];
        [self printSymbolsTo:buffer];
        [buffer appendNewLine];
#endif
    }
    
    return buffer;
}

@end
