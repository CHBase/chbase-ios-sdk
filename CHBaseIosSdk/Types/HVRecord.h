//
//  HVRecord.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVRecordReference.h"
#import "HVCollection.h"
#import "HealthVaultRecord.h"
#import "HVGetPersonalImageTask.h"

//-------------------------
//
// A HealthVault Record!
//
// Basic information about the record
// This will eventually fully replace the HealthVaultRecord object from HVMobile
//
//-------------------------
@interface HVRecord : HVRecordReference
{
@private
    NSString *m_name;
    NSString *m_displayName;
    NSString *m_relationship;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) Record name
//
@property (readwrite, nonatomic, retain) NSString* name;
//
// (Optional) Display name of the person whose record this is
//
@property (readwrite, nonatomic, retain) NSString* displayName;
//
// (Optional) Such as mother, father, etc...
//
@property (readwrite, nonatomic, retain) NSString* relationship;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithRecord:(HealthVaultRecord *) record;

//-------------------------
//
// Methods
//
//-------------------------
-(HVGetPersonalImageTask  *) downloadPersonalImageWithCallback:(HVTaskCompletion) callback;

@end

//-------------------------
//
// Collection of Records
//
//-------------------------
@interface HVRecordCollection : HVCollection

-(id) initWithRecordArray:(NSArray *) records;
-(HVRecord *) itemAtIndex:(NSUInteger) index;

-(NSInteger) indexOfRecordID:(NSString *) recordID;

@end