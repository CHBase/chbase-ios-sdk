//
//  HVOrganization.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVContact.h"
#import "HVCodableValue.h"

@interface HVOrganization : HVType
{
@private
    NSString* m_name;
    HVContact* m_contact;
    HVCodableValue* m_type;
    NSString* m_webSite;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required)
//
@property (readwrite, nonatomic, retain) NSString* name;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVContact* contact;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVCodableValue* type;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) NSString* website;

-(NSString *) toString;

@end
