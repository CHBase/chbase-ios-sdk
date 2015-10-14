//
//  MobilePlatform.m
//  CHBase Mobile Library for iOS
//
//


#import "MobilePlatform.h"
#import <CommonCrypto/CommonHMAC.h>
#import "Base64.h"


@implementation MobilePlatform


+ (NSString *)platformAbbreviationAndVersion {

	return @"HV-iOS/2.2";
}

+ (NSString *)deviceName {

	return @"iOS Device";
}

+ (NSString *)computeSha256Hash: (NSString *)data {

	const char *chars = [data cStringUsingEncoding: NSUTF8StringEncoding];
	NSData *keyData = [NSData dataWithBytes: chars length: strlen(chars)];

	uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
	CC_SHA256(keyData.bytes, keyData.length, digest);

	NSString *base64String = [Base64 encodeBase64WithData: [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH]];

	return base64String;
}

+ (NSString *)computeSha256Hmac: (NSData *)key data:(NSString *)data {

	NSUInteger len = [key length];
	char *cKey = (char *)[key bytes];

	const char *cData = [data cStringUsingEncoding: NSUTF8StringEncoding];

	unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];

	CCHmac(kCCHmacAlgSHA256, cKey, len, cData, strlen(cData), cHMAC);

	NSData *hmac = [[NSData alloc] initWithBytes: cHMAC length: sizeof(cHMAC)];

	NSString *base64String = [Base64 encodeBase64WithData: hmac];

	[hmac release];
	return base64String;
}

@end
