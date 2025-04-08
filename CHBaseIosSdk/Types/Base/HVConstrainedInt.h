//
//  constrainedInt.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVInt.h"

@interface HVConstrainedInt : HVInt

@property (readonly, nonatomic) BOOL inRange;
@property (readonly, nonatomic) int min;
@property (readonly, nonatomic) int max;

-(BOOL) validateValue:(int) value;

@end
