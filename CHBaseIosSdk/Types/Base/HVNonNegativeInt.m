//
//  HVNonNegativeInt.m
//  HVLib
//
//

#import "HVNonNegativeInt.h"
#import "HVCommon.h"
@implementation HVNonNegativeInt

-(int) min
{
    return 0;
}

@end


@implementation HVNonNegativeIntCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVNonNegativeInt class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)addItem:(HVNonNegativeInt *)item
{
    [super addObject:item];
}

-(HVNonNegativeInt *)itemAtIndex:(NSUInteger)index
{
    return [super objectAtIndex:index];
}

@end
