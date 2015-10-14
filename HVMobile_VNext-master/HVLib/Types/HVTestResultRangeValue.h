//
//  HVTestResultRangeValue.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVDouble.h"

@interface HVTestResultRangeValue : HVType
{
@private
    HVDouble* m_minRange;
    HVDouble* m_maxRange;
}

@property (readwrite, nonatomic, retain) HVDouble* minRange;
@property (readwrite, nonatomic, retain) HVDouble* maxRange;
//
// Convenience properties
//
@property (readwrite, nonatomic) double minRangeValue;
@property (readwrite, nonatomic) double maxRangeValue;

@end
