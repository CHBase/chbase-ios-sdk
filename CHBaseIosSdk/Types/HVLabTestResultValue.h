//
//  HVLabTestResultValue.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVApproxMeasurement.h"
#import "HVTestResultRange.h"

@interface HVLabTestResultValue : HVType
{
@private
    HVApproxMeasurement* m_measurement;
    HVTestResultRangeCollection* m_ranges;
    HVCodableValue* m_flag;
}

@property (readwrite, nonatomic, retain) HVApproxMeasurement* measurement;
@property (readwrite, nonatomic, retain) HVTestResultRangeCollection* ranges;
@property (readwrite, nonatomic, retain) HVCodableValue* flag;

@property (readonly, nonatomic) BOOL hasRanges;

@end
