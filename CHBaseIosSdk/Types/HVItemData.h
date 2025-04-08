//
//  HVItemData.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVItemDataCommon.h"
#import "HVItemDataTyped.h"

//-------------------------
//
// Xml data associated with an HVItem
//   - Typed data [e.g. Medication, Allergy, Exercise etc.] with associated HV Schemas
//   - Common data [Notes, tags, extensions...] 
//
//-------------------------
@interface HVItemData : HVType
{
@private
    HVItemDataCommon* m_common;
    HVItemDataTyped* m_typed;
}

//-------------------------
//
// Data
//
//-------------------------
@property (readwrite, nonatomic, retain) HVItemDataCommon* common;
@property (readwrite, nonatomic, retain) HVItemDataTyped* typed;

@property (readonly, nonatomic) BOOL hasCommon;
@property (readonly, nonatomic) BOOL hasTyped;


@end
