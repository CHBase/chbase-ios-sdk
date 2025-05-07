#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVAlert.h"

@interface HVAsthmaInhaler : HVItemDataTyped
{
@private
    HVCodableValue* m_drug;
    HVCodableValue* m_strength;
    NSString* m_purpose;
    HVApproxDateTime* m_startDate;
    HVApproxDateTime* m_stopDate;
    HVApproxDateTime* m_expirationDate;
    NSString* m_deviceId;
    HVNonNegativeInt* m_initialDoses;
    HVNonNegativeInt* m_minDailyDoses;
    HVNonNegativeInt* m_maxDailyDoses;
    HVBool* m_canAlert;
    HVAlertCollection* m_alert;
}

@property (readwrite, nonatomic, retain) HVCodableValue* drug;
@property (readwrite, nonatomic, retain) HVCodableValue* strength;
@property (readwrite, nonatomic, retain) NSString* purpose;
@property (readwrite, nonatomic, retain) HVApproxDateTime* startDate;
@property (readwrite, nonatomic, retain) HVApproxDateTime* stopDate;
@property (readwrite, nonatomic, retain) HVApproxDateTime* expirationDate;
@property (readwrite, nonatomic, retain) NSString* deviceId;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* initialDoses;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* minDailyDoses;
@property (readwrite, nonatomic, retain) HVNonNegativeInt* maxDailyDoses;
@property (readwrite, nonatomic, retain) HVBool* canAlert;
@property (readwrite, nonatomic, retain) HVAlertCollection* alert;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end
