//
//  MobilePlatform.h
//  HealthVault Mobile Library for iPhone
//
//

#import <Foundation/Foundation.h>

/// Implements the platform-specific methods used by the HealthVaultService class.
@interface MobilePlatform : NSObject {

}

/// Gets a name and version for this platform/library combination.
+ (NSString *)platformAbbreviationAndVersion;

/// Gets a name for the device.
+ (NSString *)deviceName;

/// Computes a SHA 256 hash.
/// @param data - the data to hash.</param>
/// @returns the hash as a base64-encoded string.</returns>
+ (NSString *)computeSha256Hash: (NSString *)data;

/// Computes a SHA 256 HMAC.
/// @param key - the key to use.</param>
/// @param data - the input data.</param>
/// @returns a base-64 encoded HMAC.</returns>
+ (NSString *)computeSha256Hmac:(NSData *)key data:(NSString *)data;

@end
