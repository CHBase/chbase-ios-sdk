//
//  XSerializableType.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "XSerializer.h"

@interface XSerializableType : NSObject <XSerializable>
//
// This is expensive. Clone serializes the object to Xml, then deserializes it back
// But quite useful in many situations, including UI.
//
-(id) deepCopy __deprecated;
-(id) newDeepClone;

@end
