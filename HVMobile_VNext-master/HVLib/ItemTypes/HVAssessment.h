//
//  HVAssessment.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVAssessment : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    NSString* m_name;
    HVCodableValue* m_category;
    HVAssessmentFieldCollection* m_results;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required)
//
@property (readwrite, nonatomic, retain) HVDateTime* when;
//
// (Required)
//
@property (readwrite, nonatomic, retain) NSString* name;
// 
// (Required)
//
@property (readwrite, nonatomic, retain) HVCodableValue* category;
//
// (Required)
//
@property (readwrite, nonatomic, retain) HVAssessmentFieldCollection* results;

//-------------------------
//
// Initializers
//
//-------------------------
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
