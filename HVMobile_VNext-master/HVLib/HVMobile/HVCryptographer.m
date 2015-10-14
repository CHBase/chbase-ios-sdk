//
//  HVCryptographer.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVCryptographer.h"
#import "MobilePlatform.h"

@implementation HVCryptographer

-(NSString *)computeSha256Hash: (NSString *)data
{
    return [MobilePlatform computeSha256Hash:data];
}

-(NSString *)computeSha256Hmac: (NSData *)key data:(NSString *)data
{
    return [MobilePlatform computeSha256Hmac:key data:data];
}

@end
