#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVReferralTask : HVItemDataTyped
{
@private
    HVCodableValue* m_businessStatus;
    HVCodableValue* m_taskReason;
    HVDateTime* m_createdDate;
    HVDateTime* m_updatedDate;
    HVDateTime* m_completedDate;
    HVCodableValue* m_statusReason;
    HVPerson* m_owner;
    NSString* m_note;
}

@property (readwrite, nonatomic, retain) HVCodableValue* businessStatus;
@property (readwrite, nonatomic, retain) HVCodableValue* taskReason;
@property (readwrite, nonatomic, retain) HVDateTime* createdDate;
@property (readwrite, nonatomic, retain) HVDateTime* updatedDate;
@property (readwrite, nonatomic, retain) HVDateTime* completedDate;
@property (readwrite, nonatomic, retain) HVCodableValue* statusReason;
@property (readwrite, nonatomic, retain) HVPerson* owner;
@property (readwrite, nonatomic, retain) NSString* note;

@end



@interface HVTaskCollection : HVCollection

-(void) addItem:(HVReferralTask *) item;
-(HVReferralTask *) itemAtIndex:(NSUInteger) index;

@end
