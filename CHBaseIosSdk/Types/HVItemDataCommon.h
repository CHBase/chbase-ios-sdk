//
//  HVItemDataStandard.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVString255.h"
#import "HVStringZ512.h"
#import "HVRelatedItem.h"

//-------------------------
//
// Common Xml data in a HVItem 
// [Notes, tags, extensions...] 
//
//-------------------------
@interface HVItemDataCommon : HVType
{
@private
    NSString* m_source;
    NSString* m_note;
    HVStringZ512* m_tags;
    NSMutableArray* m_extensions;
    HVRelatedItemCollection* m_relatedItems;
    HVString255* m_clientID;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Optional) The source of the HVItem
//
@property (readwrite, nonatomic, retain) NSString* source;
//
// (Optional) Arbitrary notes associated with the HVItem
//
@property (readwrite, nonatomic, retain) NSString* note;
//
// (Optional) One or more string tags
//
@property (readwrite, nonatomic, retain) HVStringZ512* tags;
//
// (Optional) Additional application specific "Extension" data injected
// into the HVItem. Can be ANY well-formed Xml node
//
@property (readwrite, nonatomic, retain) NSMutableArray* extensions;
//
// (Optional) Items related to the HVItem
//
@property (readwrite, nonatomic, retain) HVRelatedItemCollection* relatedItems;
//
// (Optional) Application injected ID
//
@property (readwrite, nonatomic, retain) HVString255* clientID;
//
// Convenience properties
//
@property (readwrite, nonatomic, retain) NSString* clientIDValue;

//----------------------
//
// Methods
//
//----------------------
-(HVRelatedItem *)addRelation:(NSString *)name toItem:(HVItem *)item;

@end
