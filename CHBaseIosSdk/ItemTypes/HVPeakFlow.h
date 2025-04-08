//
//  HVPeakFlow.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVPeakFlow : HVItemDataTyped
{
@private
    HVApproxDateTime* m_when;
    HVFlowValue* m_pef;
    HVVolumeValue* m_fev1;
    HVVolumeValue* m_fev6;
    HVCodableValue* m_flags;
}

//
// Required
//
@property (readwrite, nonatomic, retain) HVApproxDateTime* when;
//
// (Optional) liters/second
//
@property (readwrite, nonatomic, retain) HVFlowValue* peakExpiratoryFlow;
//
// (Optiona) Volume in 1 second
//
@property (readwrite, nonatomic, retain) HVVolumeValue* forcedExpiratoryVolume1;
//
// (Optional) Volume in 6 seconds
//
@property (readwrite, nonatomic, retain) HVVolumeValue* forcedExpiratoryVolume6;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVCodableValue* flags;

//
// Convenience
//
@property (readwrite, nonatomic, assign) double pefValue;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithDate:(NSDate *) when;

+(HVItem *) newItem;


//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;

//-------------------------
//
// Type information
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;

@end
