//
//  HVArrayExtensions.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVBlock.h"

@interface NSArray (HVArrayExtensions)

-(NSRange) range;

-(NSUInteger) binarySearch:(id)object options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator)cmp;
-(NSUInteger) indexOfMatchingObject:(HVFilter) filter;

+(BOOL) isNilOrEmpty:(NSArray *) array;

@end

@interface NSMutableArray (HVArrayExtensions)

+(NSMutableArray *) ensure:(NSMutableArray **) pArray;
+(NSMutableArray *) fromEnumerator:(NSEnumerator *) enumerator;

-(BOOL) isEmpty;

-(void) addFromEnumerator:(NSEnumerator *) enumerator;

//---------------------
//
// STACK EXTENSIONS
//
//---------------------
-(void) pushObject:(id) object;
-(id) peek;
-(id) popObject;

//---------------------
//
// Queue EXTENSIONS
// Using a simple array is NOT the best way to build a queue, but will do in a pinch.
//
//---------------------
-(void) enqueueObject:(id) object;
-(void) enqueueObject:(id)object maxQueueSize:(NSUInteger) size;

-(id) dequeueObject;

@end
