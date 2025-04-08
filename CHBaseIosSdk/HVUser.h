//
//  HVUser.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HVTypes.h"
#import "XLib.h"
#import "HealthVaultService.h"

//
// The user of your HealthVault application
// 
@interface HVUser : XSerializableType
{
@private
    NSString * m_name;
    HVRecordCollection *m_records;
    NSInteger m_currentIndex;
    NSString* m_environment;
    NSString* m_instanceID;
}

//
// The user's display name in HealthVault
//
@property (readwrite, nonatomic, retain) NSString* name;
//
// Records this user is authorized to access
//
@property (readwrite, nonatomic, retain) HVRecordCollection* records;
@property (readonly, nonatomic) BOOL hasRecords; // true if user has authorized records
//
// The records the application is currently working with
// To change the current record, set the currentRecordIndex property
//
@property (readwrite, nonatomic) NSInteger currentRecordIndex;
@property (readonly, nonatomic) HVRecord* currentRecord;

//
// Which service environment this user set up their app to work with
//
@property (readwrite, nonatomic, retain) NSString* environment;

@property (readwrite, nonatomic, retain) NSString* instanceID;

@property (readonly, nonatomic) BOOL hasEnvironment;
@property (readonly, nonatomic) BOOL hasInstanceID;

//-------------------------
//
// Methods
//
//-------------------------

-(id) initFromLegacyRecords:(NSArray *) recordArray;  // Infrastructure - will eventually go away
//
// Refresh the list of authorized records - in case there were changes made using the HealthVault Shell
// It is possible that when this returns, you no longer have any authorized records
//
-(HVTask *) refreshAuthorizedRecords:(HVTaskCompletion) callback;
//
// Authorize additional records for this application to work with
// It is possible that when this returns, you no longer have any authorized records
//
-(HVTask *) authorizeAdditionalRecords:(UIViewController *) parentController andCallback:(HVTaskCompletion) callback;
//
// Remove authorization for the given record
//
-(HVTask *) removeAuthForRecord:(HVRecord *) record withCallback:(HVTaskCompletion) callback;
//
// Refresh personal images for each record
// Automatically store the downloaded image in local storage
//
-(HVTask *) downloadRecordImageFor:(HVRecord *) record withCallback:(HVTaskCompletion) callback;


-(void) clear;

-(HVClientResult *) validate;

//
// For internal use only. 
//
-(BOOL) updateWithLegacyRecords:(NSArray *) records;
-(void) configureCurrentRecordForService:(HealthVaultService *) service;
-(void) clearRecordsForService:(HealthVaultService *) service;

@end
