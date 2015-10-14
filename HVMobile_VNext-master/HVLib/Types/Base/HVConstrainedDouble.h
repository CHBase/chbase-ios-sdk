//
//  HVConstrainedDouble.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVDouble.h"

@interface HVConstrainedDouble : HVDouble

@property (readonly, nonatomic) BOOL inRange;
@property (readonly, nonatomic) double min;
@property (readonly, nonatomic) double max;

-(HVClientResult *) validate;
-(BOOL) validateValue:(double) value;

@end
