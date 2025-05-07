#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVMedicationFill : HVItemDataTyped
{
@private
    HVCodableValue* m_name;
    HVApproxDateTime* m_dateFilled;
    HVPositiveInt* m_daysSupply;
    HVDate* m_nextRefillDate;
    HVNonNegativeInt* m_refillsLeft;
    HVOrganization* m_pharmacy;
    NSString* m_prescriptionNumber;
    NSString* m_lotNumber;
}

@property (readwrite, nonatomic, retain) HVCodableValue* name;
@property (readwrite, nonatomic, retain) HVApproxDateTime* dateFilled;
@property (readwrite, nonatomic, retain) HVPositiveInt* daysSupply;
@property (readwrite, nonatomic, retain) HVDate* nextRefillDate;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* refillsLeft;
@property (readwrite, nonatomic, retain) HVOrganization* pharmacy;
@property (readwrite, nonatomic, retain) NSString* prescriptionNumber;
@property (readwrite, nonatomic, retain) NSString* lotNumber;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end