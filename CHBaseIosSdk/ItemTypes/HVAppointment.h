#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVAppointment : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVDuration* m_duration;
    HVCodableValue* m_service;
    HVPerson* m_clinic;
    HVCodableValue* m_specialty;
    HVCodableValue* m_status;
    HVCodableValue* m_careClass;
}

@property (readwrite, nonatomic, retain) HVDateTime* when;
@property (readwrite, nonatomic, retain) HVDuration* duration;
@property (readwrite, nonatomic, retain) HVCodableValue* service;
@property (readwrite, nonatomic, retain) HVPerson* clinic;
@property (readwrite, nonatomic, retain) HVCodableValue* specialty;
@property (readwrite, nonatomic, retain) HVCodableValue* status;
@property (readwrite, nonatomic, retain) HVCodableValue* careClass;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end