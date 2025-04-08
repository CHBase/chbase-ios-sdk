//
//  HVDailyMedicationUsage.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVDailyMedicationUsage : HVItemDataTyped
{
@private
    HVDate* m_when;
    HVCodableValue* m_drugName;
    HVInt* m_dosesConsumed;
    HVCodableValue* m_purpose;
    HVInt* m_dosesIntended;
    HVCodableValue* m_usageSchedule;
    HVCodableValue* m_drugForm;
    HVCodableValue* m_prescriptionType;
    HVCodableValue* m_singleDoseDescription;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) The day when the medication was consumed
//
@property (readwrite, nonatomic, retain) HVDate* when;
//
// (Required) The drug/substance/supplement used
// Vocabulary: RxNorm
//
@property (readwrite, nonatomic, retain) HVCodableValue* drugName;
//
// (Required) number of doses. 
// 
@property (readwrite, nonatomic, retain) HVInt* dosesConsumed;
//
// (Optional) why the medication was taken
//
@property (readwrite, nonatomic, retain) HVCodableValue* purpose;
//
// (Optional) How many doses were meant to be taken 
//
@property (readwrite, nonatomic, retain) HVInt* dosesIntended;
//
// All Optional
//
@property (readwrite, nonatomic, retain) HVCodableValue* usageSchedule;
@property (readwrite, nonatomic, retain) HVCodableValue* drugForm;
@property (readwrite, nonatomic, retain) HVCodableValue* prescriptionType;
@property (readwrite, nonatomic, retain) HVCodableValue* singleDoseDescription;

//
// Convenience
//
@property (readwrite, nonatomic) int dosesConsumedValue;
@property (readwrite, nonatomic) int dosesIntendedValue;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithDoses:(int) doses forDrug:(HVCodableValue *) drug onDay:(NSDate *) day;
-(id) initWithDoses:(int)doses forDrug:(HVCodableValue *)drug onDate:(HVDate *)date;

+(HVItem *) newItem;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;

//-------------------------
//
// Type Info
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;


@end
