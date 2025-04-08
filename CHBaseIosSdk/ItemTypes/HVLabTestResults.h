//
//  HVLabTestResults.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVLabTestResults : HVItemDataTyped
{
@private
    HVApproxDateTime* m_when;
    HVLabTestResultsGroupCollection* m_labGroup;
    HVOrganization* m_orderedBy;
}

@property (readwrite, nonatomic, retain) HVApproxDateTime* when;
@property (readwrite, nonatomic, retain) HVLabTestResultsGroupCollection* labGroup;
@property (readwrite, nonatomic, retain) HVOrganization* orderedBy;
//
// Convenience properties
//
@property (readonly, nonatomic) HVLabTestResultsGroup* firstGroup;
//
// Lab groups can be nested.
// This returns all of them in a single collection
//
-(HVLabTestResultsGroupCollection *) getAllGroups;

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
// Type information
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;

@end
