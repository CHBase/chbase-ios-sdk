//
//  HVCholesterol.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

extern double const c_cholesterolMolarMass;
extern double const c_triglyceridesMolarMass;

//
// DEPRECATED DEPRECATED DEPRECATED
//
// APPS SHOULD SWITCH TO HVCholesterolV2, which correctly handles international units
//
// Cholesterol (Lipid) profile
// Measures Cholesterol #s in mg/DL
// Use HVCholesterolV2, which uses the SI mmolPerl units
//
@interface HVCholesterol : HVItemDataTyped
{
@private
    HVDate* m_date;
    HVPositiveInt* m_ldl;
    HVPositiveInt* m_hdl;
    HVPositiveInt* m_total;
    HVPositiveInt* m_triglycerides;
}

//-------------------------
//
// Cholesterol Data
//
//-------------------------
//
// (Required) When the measurement was taken
//
@property (readwrite, nonatomic, retain) HVDate* when;
//
// (Optional) LDL value in mg/DL
// 
@property (readwrite, nonatomic, retain) HVPositiveInt* ldl;
//
// (Optional) HDL value in mg/DL
//
@property (readwrite, nonatomic, retain) HVPositiveInt* hdl;
//
// (Optional) Total cholesterol in mg/DL
//
@property (readwrite, nonatomic, retain) HVPositiveInt* total;
//
// (Optional) Triglycerides in mg/DL
//
@property (readwrite, nonatomic, retain) HVPositiveInt* triglycerides;
//
// Convenience properties
//
@property (readwrite, nonatomic) int ldlValue;
@property (readwrite, nonatomic) int hdlValue;
@property (readwrite, nonatomic) int totalValue;
@property (readwrite, nonatomic) int triglyceridesValue;
@property (readwrite, nonatomic) double ldlValueMmolPerLiter;
@property (readwrite, nonatomic) double hdlValueMmolPerLiter;
@property (readwrite, nonatomic) double totalValueMmolPerLiter;
@property (readwrite, nonatomic) double triglyceridesValueMmolPerLiter;

//-------------------------
//
// Initializers
//
//-------------------------
//
// Creates a string for ldl/hdl
//
-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;

//-------------------------
//
// Type information
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;

+(HVItem *) newItem;

@end
