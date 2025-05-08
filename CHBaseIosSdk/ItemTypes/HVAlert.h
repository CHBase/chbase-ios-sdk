#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVAlert : HVItemDataTyped
{
@private
    HVNonNegativeIntCollection* m_dow;
    HVTimeCollection* m_time;
}

@property (readwrite, nonatomic, retain) HVNonNegativeIntCollection* dow;
@property (readwrite, nonatomic, retain) HVTimeCollection* time;

@end

@interface HVAlertCollection : HVCollection

-(void) addItem:(HVAlert *) item;
-(HVAlert *) itemAtIndex:(NSUInteger) index;

@end


