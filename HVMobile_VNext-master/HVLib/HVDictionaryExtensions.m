//
//  HVDictionaryExtensions.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVDictionaryExtensions.h"

@implementation NSDictionary (HVDictionaryExtensions)

+(BOOL)isNilOrEmpty:(NSDictionary *)dictionary
{
    return (dictionary == nil || dictionary.count == 0);
}

+(NSMutableDictionary *)fromArgumentString:(NSString *)args
{
    if ([NSString isNilOrEmpty:args])
    {
        return nil;
    }
    
    NSArray* parts = [args componentsSeparatedByString:@"&"];
    if ([NSArray isNilOrEmpty:parts])
    {
        return nil;
    }
    
    NSMutableDictionary* nvPairs = [NSMutableDictionary dictionary];
    HVCHECK_NOTNULL(nvPairs);
    
    for (NSUInteger i = 0, count = parts.count; i < count; ++i)
    {
        NSString* part = [parts objectAtIndex:i];
        if ([NSString isNilOrEmpty:part])
        {
            continue;
        }

        NSString* key = part;
        NSString* value = c_emptyString;

        NSUInteger nvSepPos = [part indexOfFirstChar:'='];
        if (nvSepPos != NSNotFound)
        {
            key = [part substringToIndex:nvSepPos];
            value = [part substringFromIndex:nvSepPos + 1]; // Handles the case where = is at the end of the string
        }

        [nvPairs setValue:value forKey:key];

    }

    return nvPairs;
    
LError:
    return nil;    
}

-(BOOL)hasKey:(id)key
{
    return ([self objectForKey:key] != nil);
}

-(BOOL)boolValueForKey:(id)key
{
    NSNumber* value = [self objectForKey:key];
    return value.boolValue;
}

@end

@implementation NSMutableDictionary (HVDictionaryExtensions)

-(void)setBoolValue:(BOOL)value forKey:(id<NSCopying>)key
{
    NSNumber* boolValue = [[NSNumber alloc] initWithBool:value];
    [self setObject:boolValue forKey:key];
    [boolValue release];
}

@end
