//
//  HVNonNegativeInt.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVConstrainedInt.h"

@interface HVNonNegativeInt : HVConstrainedInt

@end

@interface HVNonNegativeIntCollection : HVCollection

-(void) addItem:(HVNonNegativeInt *) item;
-(HVNonNegativeInt *) itemAtIndex:(NSUInteger) index;

@end
