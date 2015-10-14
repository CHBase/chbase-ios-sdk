//
//  HVAssessmentField.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVCodableValue.h"

@interface HVAssessmentField : HVType
{
@private
    HVCodableValue* m_name;
    HVCodableValue* m_value;
    HVCodableValue* m_group;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required)
//
@property (readwrite, nonatomic, retain) HVCodableValue* name;
//
// (Required)
//
@property (readwrite, nonatomic, retain) HVCodableValue* value;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVCodableValue* fieldGroup;

//-------------------------
//
// Data
//
//-------------------------
-(id) initWithName:(NSString *) name andValue:(NSString *) value;
-(id) initWithName:(NSString *) name value:(NSString *) value andGroup:(NSString *) group;

+(HVAssessmentField *) from:(NSString *) name andValue:(NSString *) value;

@end


@interface HVAssessmentFieldCollection : HVCollection

@end