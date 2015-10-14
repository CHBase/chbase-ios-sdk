//
//  HVFlowValue.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVPositiveDouble.h"
#import "HVDisplayValue.h"

@interface HVFlowValue : HVType
{
@private
    HVPositiveDouble* m_litersPerSecond;
    HVDisplayValue* m_display;
}

-(id) initWithLitersPerSecond:(double) value;

//
// Required
//
@property (readwrite, nonatomic, retain) HVPositiveDouble* litersPerSecond;
//
// Optional
//
@property (readwrite, nonatomic, retain) HVDisplayValue* displayValue;

@property (readwrite, nonatomic) double litersPerSecondValue;

-(NSString *) toString;
-(NSString *)toStringWithFormat:(NSString *)format;

+(NSString *) flowUnits;

@end
