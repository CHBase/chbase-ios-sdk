//
//  HVPersonInfo.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVBaseTypes.h"
#import "HVType.h"
#import "HVRecord.h"

@interface HVPersonInfo : HVType
{
@private
    NSString* m_id;
    NSString* m_name;
    NSString* m_appSettingsXml;
    NSString* m_selectedRecordID;
    HVBool* m_moreRecords;
    NSString* m_groupsXml;
    HVRecordCollection* m_records;
    NSString* m_preferredCultureXml;
    NSString* m_preferredUICultureXml;
}

@property (readwrite, nonatomic, retain) NSString* ID;
@property (readwrite, nonatomic, retain) NSString* name;
@property (readwrite, nonatomic, retain) NSString* appSettingsXml;
@property (readwrite, nonatomic, retain) NSString* selectedRecordID;
@property (readwrite, nonatomic, retain) HVBool* moreRecords;
@property (readwrite, nonatomic, retain) HVRecordCollection* records;
@property (readwrite, nonatomic, retain) NSString* groupsXml;
@property (readwrite, nonatomic, retain) NSString* preferredCultureXml;
@property (readwrite, nonatomic, retain) NSString* preferredUICultureXml;

@property (readonly, nonatomic) BOOL hasRecords;

@end
