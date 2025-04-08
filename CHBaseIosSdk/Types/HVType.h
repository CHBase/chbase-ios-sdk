//
//  HVType.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVClientResult.h"
#import "HVCollection.h"
#import "XLib.h"

@interface HVType : XSerializableType

-(BOOL) isValid;
-(HVClientResult *) validate;

@end
