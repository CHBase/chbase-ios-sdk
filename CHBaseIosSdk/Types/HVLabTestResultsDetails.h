//
//  HVLabTestResultsDetails.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVApproxDateTime.h"
#import "HVCodableValue.h"
#import "HVLabTestResultValue.h"
#import "HVCollection.h"

@interface HVLabTestResultsDetails : HVType
{
@private
    HVApproxDateTime* m_when;
    NSString* m_name;
    HVCodableValue* m_substance;
    HVCodableValue* m_collectionMethod;
    HVCodableValue* m_clinicalCode;
    HVLabTestResultValue* m_value;
    HVCodableValue* m_status;
    NSString* m_note;
}

@property (readwrite, nonatomic, retain) HVApproxDateTime* when;
@property (readwrite, nonatomic, retain) NSString* name;
@property (readwrite, nonatomic, retain) HVCodableValue* substance;
@property (readwrite, nonatomic, retain) HVCodableValue* collectionMethod;
@property (readwrite, nonatomic, retain) HVCodableValue* clinicalCode;
@property (readwrite, nonatomic, retain) HVLabTestResultValue* value;
@property (readwrite, nonatomic, retain) HVCodableValue* status;
@property (readwrite, nonatomic, retain) NSString* note;

@end

@interface HVLabTestResultsDetailsCollection : HVCollection

-(void) addItem:(HVLabTestResultsDetails *) item;
-(HVLabTestResultsDetails *) itemAtIndex:(NSUInteger) index;

@end
