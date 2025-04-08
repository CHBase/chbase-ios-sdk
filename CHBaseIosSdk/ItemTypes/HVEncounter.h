//
//  HVEncounter.h
//  HVLib
//
//


#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVEncounter : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVCodableValue* m_type;
    NSString* m_reason;
    HVDuration* m_duration;
    HVBool* m_constentGranted;
    HVOrganization* m_facility;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVDateTime* when;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVCodableValue* encounterType;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) NSString* reason;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVDuration* duration;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVBool* consent;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVOrganization* facility;

+(NSString *) typeID;
+(NSString *) XRootElement;

+(HVItem *) newItem;

@end
