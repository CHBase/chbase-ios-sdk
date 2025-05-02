#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVBmiValue : HVItemDataTyped
{
@private
    HVNonNegativeDouble* m_kgm2;
    HVDisplayValue* m_display;
}

@property (readwrite, nonatomic, retain) HVNonNegativeDouble* kgm2;
@property (readwrite, nonatomic, retain) HVDisplayValue* display;

@end