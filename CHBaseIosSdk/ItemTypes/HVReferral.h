#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVReferralTask.h"

@interface HVReferral : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVCodableValue* m_type;
    HVCodableValue* m_reason;
    HVPerson* m_referredBy;
    HVTaskCollection* m_task;
    HVPerson* m_referredTo;
}

@property (readwrite, nonatomic, retain) HVDateTime* when;
@property (readwrite, nonatomic, retain) HVCodableValue* referralType;
@property (readwrite, nonatomic, retain) HVCodableValue* reason;
@property (readwrite, nonatomic, retain) HVPerson* referredBy;
@property (readwrite, nonatomic, retain) HVTaskCollection* task;
@property (readwrite, nonatomic, retain) HVPerson* referredTo;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end
