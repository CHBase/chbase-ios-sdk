//
//  HVCryptographer.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>

@protocol HVCryptographer <NSObject>

-(NSString *)computeSha256Hash: (NSString *)data;
-(NSString *)computeSha256Hmac:(NSData *)key data:(NSString *)data;

@end

@interface HVCryptographer : NSObject<HVCryptographer>

@end
