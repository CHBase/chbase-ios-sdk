//
//  Logger.h
//  CHBase Mobile Library for iOS
//
//

#import <Foundation/Foundation.h>
#import "HealthVaultConfig.h"

#if HEALTH_VAULT_TRACE_ENABLED
#	define TraceMessage(s, ... ) [Logger write: [NSString stringWithFormat: @"[%s, line = %d] %@", __func__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__]]]
#	define TraceComponentEvent(component, code, s, ... ) [Logger write: [NSString stringWithFormat: @"[%@, code = %d]: %@", component, code, [NSString stringWithFormat:(s), ##__VA_ARGS__]]]
#	define TraceComponentMessage(component, s, ... ) TraceComponentEvent(component, 0, s, ##__VA_ARGS__)
#	define TraceComponentError(component, s, ... ) TraceComponentEvent(component, -1, s, ##__VA_ARGS__)
#else
#	define TraceMessage(s, ... ) {}
#	define TraceComponentEvent(component, code, s, ... ) {}
#	define TraceComponentMessage(component, s, ... ) {}
#	define TraceComponentError(component, s, ... ) {}
#endif

/// Implements logging related functionality.
@interface Logger: NSObject

/// Writes the message to a log.
/// @param text - text to write.
+ (void)write: (NSString *)text;

@end 