//
//  HVExceptionExtensions.h
//  HVLib
//
//

#import <Foundation/Foundation.h>

@interface NSException (HVExceptionExtensions)

+(void) throwException:(NSString*) exceptionName;
+(void) throwException:(NSString*) exceptionName reason:(NSString *) reason;
+(void) throwInvalidArg;
+(void) throwInvalidArgWithReason:(NSString *) reason;
+(void) throwOutOfMemory;
+(void) throwNotImpl;

-(void) printSymbolsTo:(NSMutableString *) buffer;
-(NSString *) detailedDescription;

@end
