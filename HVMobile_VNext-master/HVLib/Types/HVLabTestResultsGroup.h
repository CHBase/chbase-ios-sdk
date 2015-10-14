//
//  HVLabTestResultsGroup.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVLabTestResultsDetails.h"
#import "HVOrganization.h"

@class HVLabTestResultsGroupCollection;

@interface HVLabTestResultsGroup : HVType
{
@private
    HVCodableValue* m_groupName;
    HVOrganization* m_laboratory;
    HVCodableValue* m_status;
    HVLabTestResultsGroupCollection* m_subGroups;
    HVLabTestResultsDetailsCollection* m_results;
}

@property (readwrite, nonatomic, retain) HVCodableValue* groupName;
@property (readwrite, nonatomic, retain) HVOrganization* laboratory;
@property (readwrite, nonatomic, retain) HVCodableValue* status;
@property (readwrite, nonatomic, retain) HVLabTestResultsGroupCollection* subGroups;
@property (readwrite, nonatomic, retain) HVLabTestResultsDetailsCollection* results;

@property (readonly, nonatomic) BOOL hasSubGroups;

-(void) addToCollection:(HVLabTestResultsGroupCollection *) groups;

@end

@interface HVLabTestResultsGroupCollection : HVCollection

-(void) addItem:(HVLabTestResultsGroup *) item;
-(HVLabTestResultsGroup *) itemAtIndex:(NSUInteger) index;

-(void) addItemsToCollection:(HVLabTestResultsGroupCollection *) groups;

@end
