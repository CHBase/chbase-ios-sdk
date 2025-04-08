//
//  HVDictionaryExtensions.h
//  HVLib
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HVDictionaryExtensions)

+(BOOL) isNilOrEmpty:(NSDictionary *) dictionary;

// Argument string separated by '&'
+(NSMutableDictionary *) fromArgumentString:(NSString *) qs;

-(BOOL) hasKey:(id) key;
-(BOOL) boolValueForKey:(id) key;

@end

@interface NSMutableDictionary (HVDictionaryExtensions)

- (void)setBoolValue:(BOOL)value forKey:(id <NSCopying>)key;

@end
