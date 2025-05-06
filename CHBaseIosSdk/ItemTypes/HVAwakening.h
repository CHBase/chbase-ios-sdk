#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVAwakening : HVItemDataTyped
{
@private
    HVTime* m_when;
    HVNonNegativeInt* m_minutes;
}

@property (readwrite, nonatomic, retain) HVTime* when;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* minutes;

@end


@interface HVAwakeningCollection : HVCollection

-(void) addItem:(HVAwakening *) item;
-(HVAwakening *) itemAtIndex:(NSUInteger) index;

@end
