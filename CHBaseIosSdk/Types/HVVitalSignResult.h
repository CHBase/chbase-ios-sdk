//
//  HVVitalSignResult.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVBaseTypes.h"
#import "HVType.h"
#import "HVCodableValue.h"

@interface HVVitalSignResult : HVType
{
@private
    HVCodableValue* m_title;
    HVDouble* m_value;
    HVCodableValue* m_unit;
    HVDouble* m_referenceMin;
    HVDouble* m_referenceMax;
    NSString* m_textValue;
    HVCodableValue* m_flag;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required)
// Vocabulary: vital-statistics
//
@property (readwrite, nonatomic, retain) HVCodableValue* title;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVDouble* value;
//
// (Optional)
// Vocabulary: lab-results-units
@property (readwrite, nonatomic, retain) HVCodableValue* unit;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVDouble* referenceMin;
// 
// (Optional)
//
@property (readwrite, nonatomic, retain) HVDouble* referenceMax;
@property (readwrite, nonatomic, retain) NSString* textValue;
@property (readwrite, nonatomic, retain) HVCodableValue* flag;

//-------------------------
//
// Initializers
//
//-------------------------

-(id) initWithTitle:(HVCodableValue *) title value:(double)value andUnit:(NSString *) unit;
-(id) initWithTemperature:(double) value inCelsius:(BOOL) celsius;

//-------------------------
//
// Text
//
//-------------------------

// 
// Format template => %@ %f %@
//
-(NSString *) toString;

@end


@interface HVVitalSignResultCollection : HVCollection 

-(HVVitalSignResult *) itemAtIndex:(NSUInteger) index;

@end