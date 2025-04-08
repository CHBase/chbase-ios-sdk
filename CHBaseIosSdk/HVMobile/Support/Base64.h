//
//  Base64.h
//  CHBase Mobile Library for iOS
//
//

#import <Foundation/Foundation.h>


/// Provides Base64 encoding/decoding functionality.
@interface Base64 : NSObject {
}

/// Encodes incoming data to base64 string.
/// @param dataToEncode - data for encoding.
/// @returns encoded base64 string.
+ (NSString *)encodeBase64WithData:(NSData *)dataToEncode;

/// Decodes base64 string.
/// @param stringToDecode - string for decoding.
/// @returns decoded data.
+ (NSData *)decodeBase64WithString:(NSString *)stringToDecode;

@end
