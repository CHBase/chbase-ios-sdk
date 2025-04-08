//
//  HVBloodGlucoseMeasurement.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVPositiveDouble.h"
#import "HVDisplayValue.h"
#import "HVConcentrationValue.h"

@interface HVBloodGlucoseMeasurement : HVType
{
@private
    HVPositiveDouble* m_mmolPerl;
    HVDisplayValue* m_display;
}

//
// Required
//
@property (readwrite, nonatomic, retain) HVPositiveDouble* value;
//
// Optional
//
@property (readwrite, nonatomic, retain) HVDisplayValue *display;

@property (readwrite, nonatomic) double mmolPerLiter;
@property (readwrite, nonatomic) double mgPerDL;

-(id) initWithMmolPerLiter:(double) value;
-(id) initWithMgPerDL:(double) value;

-(BOOL) updateDisplayValue:(double) displayValue units:(NSString *) unitValue andUnitsCode:(NSString *)code;

-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;

+(double) mgPerDLToMmolPerLiter:(double) value;
+(double) mMolPerLiterToMgPerDL:(double) value;

@end
