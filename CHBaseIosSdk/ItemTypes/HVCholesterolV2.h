//
//  HVCholesterolV2.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVCholesterol.h"

@interface HVCholesterolV2 : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVConcentrationValue* m_ldl;
    HVConcentrationValue* m_hdl;
    HVConcentrationValue* m_total;
    HVConcentrationValue* m_triglycerides;
}

//
// (Required) When the measurement was taken
//
@property (readwrite, nonatomic, retain) HVDateTime* when;
//
// (Optional) LDL value in mg/DL
//
@property (readwrite, nonatomic, retain) HVConcentrationValue* ldl;
//
// (Optional) HDL value in mg/DL
//
@property (readwrite, nonatomic, retain) HVConcentrationValue* hdl;
//
// (Optional) Total cholesterol in mg/DL
//
@property (readwrite, nonatomic, retain) HVConcentrationValue* total;
//
// (Optional) Triglycerides in mg/DL
//
@property (readwrite, nonatomic, retain) HVConcentrationValue* triglycerides;
//
// Convenience properties
//
@property (readwrite, nonatomic) double ldlValue;
@property (readwrite, nonatomic) double hdlValue;
@property (readwrite, nonatomic) double totalValue;
@property (readwrite, nonatomic) double triglyceridesValue;
@property (readwrite, nonatomic) double ldlValueMgDL;
@property (readwrite, nonatomic) double hdlValueMgDL;
@property (readwrite, nonatomic) double totalValueMgDL;
@property (readwrite, nonatomic) double triglyceridesValueMgDl;

//-------------------------
//
// Type information
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;

+(HVItem *) newItem;

@end
