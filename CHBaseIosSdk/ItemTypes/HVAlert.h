#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVAlert : HVItemDataTyped
{
@private
    HVNonNegativeInt* m_dow;
    HVTime* m_time;
}

@property (readwrite, nonatomic, retain) HVNonNegativeInt* dow;
@property (readwrite, nonatomic, retain) HVTime* time;

@end



@interface HVAlertCollection : HVCollection

-(void) addItem:(HVAlert *) item;
-(HVAlert *) itemAtIndex:(NSUInteger) index;

@end
