//
//  HVItem.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVItemKey.h"
#import "HVItemType.h"
#import "HVItemState.h"
#import "HVAudit.h"
#import "HVItemData.h"
#import "HVBlobPayload.h"
#import "HVBlobSource.h"
#import "HVAsyncTask.h"
#import "HVApproxDateTime.h"

@class HVRecordReference;
@class HVItemBlobUploadTask;

enum HVItemFlags
{
    HVItemFlagNone = 0x00,
    HVItemFlagPersonal = 0x01,      // Item is only accessible to custodians
    HVItemFlagDownVersioned = 0x02, // Item converted from a newer format to an older format [cannot update]
    HVItemFlagUpVersioned = 0x04,   // Item converted from an older format to a new format [can update]
    HVItemFlagImmutable = 0x10      // Item is locked and cannot be modified, except for updated-end-date
};

//-------------------------
//
// A single Item ("thing") in a record
// Each item has:
//   - Key and Version 
//   - Metadata, such as creation dates
//   - Xml Data
//      - Typed data [e.g. Medication, Allergy, Exercise etc.] with associated HV Schemas
//      - Common data [Related Items, Notes, tags, extensions...] 
//   - Blob Data
//      - A collection of named blob streams. 
//
//-------------------------
@interface HVItem : HVType
{
@private
    HVItemKey* m_key;
    HVItemType* m_type;
    enum HVItemState m_state;
    int m_flags;
    NSDate* m_effectiveDate;
    HVAudit* m_created;
    HVAudit* m_updated;    
    HVItemData* m_data;
    HVBlobPayload* m_blobs;
    HVConstrainedXmlDate* m_updatedEndDate;
}

//-------------------------
//
// Data
//
//-------------------------

//
// (Optional) The key for this item (id + version)
// All existing items that have been successfully committed to HealthVault
// will always have a key. 
//
@property (readwrite, nonatomic, retain) HVItemKey* key;

@property (readwrite, nonatomic, retain) HVItemType* type;

@property (readwrite, nonatomic) enum HVItemState state;
//
// (Optional) See HVItemFlags enumeration...
//
@property (readwrite, nonatomic) int flags;
//
// 
// The effective date impacts the default sort order of returned results
//
@property (readwrite, nonatomic, retain) NSDate* effectiveDate;

@property (readwrite, nonatomic, retain) HVAudit* created;
@property (readwrite, nonatomic, retain) HVAudit* updated;
//
// (Optional) Structured data for this item. May be null if you did not 
// ask for Core data (see enum HVItemSection) when you issued a query for items
//
@property (readwrite, nonatomic, retain) HVItemData* data;
//
// (Optional) Information about unstructured blob streams associated with this item
// May be null if you did not ask for Blob information (see enum HVItemSectionBlob)
//
@property (readwrite, nonatomic, retain) HVBlobPayload* blobs;

// (Optional) RAW Xml - see HealthVault Thing schema
@property (readwrite, nonatomic, retain) NSString* effectivePermissionsXml;

// (Optional) Tags associated with this item
@property (readwrite, nonatomic, retain) HVStringZ512* tags;

// (Optional) Signature. Raw Xml
@property (readwrite, nonatomic, retain) NSString* signatureInfoXml;

// (Optional) Some items are immutable (locked). Users an still update the "effective"
// end date of some item - such as the date they stopped taking a medication
@property (readwrite, nonatomic, retain) HVConstrainedXmlDate* updatedEndDate;

//-----------------------
//
// Convenience Properties
//
//------------------------
@property (readonly, nonatomic) NSString* itemID;
@property (readonly, nonatomic) NSString* typeID;
//
// (Optional) All items can have arbitrary notes...
// References data.common.note 
//
@property (readwrite, nonatomic, retain) NSString* note;

//
// Convenience
//
@property (readonly, nonatomic) BOOL hasKey;
@property (readonly, nonatomic) BOOL hasTypeInfo;
@property (readonly, nonatomic) BOOL hasData;
@property (readonly, nonatomic) BOOL hasTypedData;
@property (readonly, nonatomic) BOOL hasCommonData;
@property (readonly, nonatomic) BOOL hasBlobData;
@property (readonly, nonatomic) BOOL isReadOnly;
@property (readonly, nonatomic) BOOL hasUpdatedEndDate;

//-------------------------
//
// Initializers
//
//-------------------------

-(id) initWithType:(NSString *) typeID;
-(id) initWithTypedData:(HVItemDataTyped *) data;
-(id) initWithTypedDataClassName:(NSString *) name;
-(id) initWithTypedDataClass:(Class) cls;

//-------------------------
//
// Serialization
//
//-------------------------
-(NSString *) toXmlString;
+(HVItem *) newFromXmlString:(NSString *) xml;

//-------------------------
//
// Methods
//
//-------------------------
//
// Does a SHALLOW CLONE. 
// You get a new HVItem but pointed at all the same internal objects
//
-(HVItem*) shallowClone;
//
// Sometimes you will take an existing item object, edit it inline and them PUT it back to HealthVault
// Call this to clear fields that are typically set by the HV service
// - EffectiveDate, UpdateDate, etc...
//
// NOTE: if you call HVRecordReference::update, this method will get called automatically
//
-(void) prepareForUpdate;
//
// After this call, if you put the item into HealthVault, you will add a new item
//
-(void) prepareForNew;

-(BOOL) setKeyToNew;
-(BOOL) ensureKey;
-(BOOL) ensureEffectiveDate;

-(BOOL) removeEndDate;
-(BOOL) updateEndDate:(NSDate *) date;
-(BOOL) updateEndDateWithApproxDate:(HVApproxDateTime *) date;

-(NSDate *) getDate;

-(BOOL) isVersion:(NSString *) version;
-(BOOL) isType:(NSString *) typeID;

//-------------------------
//
// Blob
//
//-------------------------
//
// Refreshes information about blobs associated with this item
//
-(HVTask *) updateBlobDataFromRecord:(HVRecordReference *) record andCallback:(HVTaskCompletion) callback;
//
// Upload data into the default blob and put the item...
//
-(HVItemBlobUploadTask *) uploadBlob:(id<HVBlobSource>) data contentType:(NSString *) contentType record:(HVRecordReference *) record andCallback:(HVTaskCompletion) callback;
-(HVItemBlobUploadTask *) uploadBlob:(id<HVBlobSource>) data forBlobName:(NSString *) name contentType:(NSString *) contentType record:(HVRecordReference *) record andCallback:(HVTaskCompletion) callback;

-(HVItemBlobUploadTask *) newUploadBlobTask:(id<HVBlobSource>) data forBlobName:(NSString *) name contentType:(NSString *) contentType record:(HVRecordReference *) record andCallback:(HVTaskCompletion) callback;

@end

//-------------------------
//
// A serializable collection of items
//
//-------------------------
@interface HVItemCollection : HVCollection <XSerializable>

-(id) initwithItem:(HVItem *) item;
-(id) initWithItems:(NSArray *) items;

-(void) addItem:(HVItem *) item;
-(HVItem *) itemAtIndex:(NSUInteger) index;

-(BOOL) containsItemID:(NSString *) itemID;
-(NSUInteger) indexOfItemID:(NSString *) itemID;

-(NSMutableDictionary *) newIndexByID;
-(NSMutableDictionary *) getItemsIndexedByID;

-(NSUInteger) indexOfTypeID:(NSString *) typeID;
-(HVItem *) firstItemOfType:(NSString *) typeID;

+(HVStringCollection *) idsFromItems:(NSArray *) items;

-(HVClientResult *) validate;

-(BOOL) shallowCloneItems;
-(void) prepareForUpdate;
-(void) prepareForNew;

@end
