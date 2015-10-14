//
//  HVKeyChain.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface HVKeyChain : NSObject

+(NSMutableDictionary *) attributesForPasswordName:(NSString *) passwordName;
+(NSMutableDictionary *) queryForPasswordName:(NSString *) passwordName;

+(NSData *) runQuery:(NSMutableDictionary *) query;

+(NSData *) getPassword:(NSString *) passwordName;
+(NSString *) getPasswordString:(NSString *) passwordName;

+(BOOL) setPassword:(NSString *) password forName:(NSString *) passwordName;
+(BOOL) removePassword:(NSString *) passwordName;

@end
