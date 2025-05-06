#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVLevel : HVItemDataTyped
{
@private
    HVTime* m_startTime;
    HVNonNegativeInt* m_minutes;
    HVCodableValue* m_state;
}

@property (readwrite, nonatomic, retain) HVTime* startTime;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* minutes;
@property (readwrite, nonatomic, retain) HVCodableValue* state;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end


@interface HVLevelCollection : HVCollection

-(void) addItem:(HVLevel *) item;
-(HVLevel *) itemAtIndex:(NSUInteger) index;

@end
