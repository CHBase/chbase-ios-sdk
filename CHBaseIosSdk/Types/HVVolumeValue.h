//
//  HVVolumeValue.h
//  HVLib
//
//
//
#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVPositiveDouble.h"
#import "HVDisplayValue.h"

@interface HVVolumeValue : HVType
{
@private
    HVPositiveDouble* m_liters;
    HVDisplayValue* m_display;
}

-(id) initWithLiters:(double) value;

//
// Required
//
@property (readwrite, nonatomic, retain) HVPositiveDouble* liters;
//
// Optional
//
@property (readwrite, nonatomic, retain) HVDisplayValue* displayValue;

@property (readwrite, nonatomic) double litersValue;

-(NSString *) toString;
-(NSString *)toStringWithFormat:(NSString *)format;

// Liters
+(NSString *) volumeUnits;

@end
