//
//  HVArrayExtensions.m
//  HVLib
//
//

#import "HVArrayExtensions.h"
#import "HVRandom.h"

@implementation NSArray (HVArrayExtensions)

-(NSRange) range
{
    return NSMakeRange(0, self.count);
}

-(NSUInteger) binarySearch:(id)object options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator)cmp
{
    return [self indexOfObject:object inSortedRange:NSMakeRange(0, self.count) options:opts usingComparator:cmp];
}

+(BOOL) isNilOrEmpty:(NSArray *) array;
{
    return (array == nil || array.count == 0);
}

-(NSUInteger)indexOfMatchingObject:(HVFilter)filter
{
    if (filter)
    {
        for (NSUInteger i = 0, count = self.count; i < count; ++i)
        {
            id obj = [self objectAtIndex:i];
            if (filter(obj))
            {
                return i;
            }
        }
    }
    
    return NSNotFound;
}

@end

@implementation NSMutableArray (HVArrayExtensions)

+(NSMutableArray *) ensure:(NSMutableArray **)pArray
{
    if (!*pArray)
    {
        *pArray = [[NSMutableArray alloc] init];
    }
    
    return *pArray;
}

+(NSMutableArray *)fromEnumerator:(NSEnumerator *)enumerator
{
    NSMutableArray* array = [NSMutableArray array];
    [array addFromEnumerator:enumerator];
    return array;
}

-(void)addFromEnumerator:(NSEnumerator *)enumerator
{
    id obj;
    while ((obj = enumerator.nextObject) != nil)
    {
        [self addObject:obj];
    }
}

-(BOOL)isEmpty
{
    return (self.count == 0);
}

-(void)pushObject:(id)object
{
    [self addObject:object];
}

-(id)peek
{
    if (self.isEmpty)
    {
        return nil;
    }
    
    return [self lastObject];
}

-(id)popObject
{
    id popped = [self peek];
    if (popped)
    {
        popped = [[popped retain] autorelease];
        [self removeLastObject];
    }
    
    return popped;
}

-(void)enqueueObject:(id)object
{
    if (self.isEmpty)
    {
        [self addObject:object];
    }
    else 
    {
        [self insertObject:object atIndex:0];
    }
}

-(void)enqueueObject:(id)object maxQueueSize:(NSUInteger)size
{
    if (self.count >= size)
    {
        [self popObject];
    }
    
    [self enqueueObject:object];
}

-(id)dequeueObject
{
    return [self popObject];
}

@end
