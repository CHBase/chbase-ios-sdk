//
//  HVDataExtensions.m
//  HVLib
//
//
//

#import "HVDataExtensions.h"

@implementation NSData (HVDataExtensions)

-(NSString *)newUTF8String
{
    return [[NSString alloc] initWithData:self encoding: NSUTF8StringEncoding];    
}

-(NSString *)toUTF8String
{
    return [[self newUTF8String] autorelease];
}
@end
