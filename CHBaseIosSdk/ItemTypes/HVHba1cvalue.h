#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVHbA1CValue : HVItemDataTyped
{
@private
    HVPositiveDouble* m_mmolPerMol;
    HVDisplayValue* m_display;
}

@property (readwrite, nonatomic) HVPositiveDouble* mmolPerMol;
@property (readwrite, nonatomic, retain) HVDisplayValue* display;


@end
