//
//  HVRecord.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVRecord.h"
#import "HVPersonalImage.h"
#import "HVBlobPayloadItem.h"

static NSString* const c_element_displayname = @"display-name";
static NSString* const c_element_relationship = @"rel-name";

@implementation HVRecord

@synthesize name = m_name;
@synthesize displayName = m_displayName;
@synthesize relationship = m_relationship;

-(id)initWithRecord:(HealthVaultRecord *)record
{
    HVCHECK_NOTNULL(record);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.ID = record.recordId;
    self.personID = record.personId;
    self.name = record.recordName;
    self.displayName = record.displayName;
    self.relationship = record.relationship;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void) dealloc
{
    [m_name release];
    [m_displayName release];
    [m_relationship release];
    
    [super dealloc];
}

-(HVGetPersonalImageTask *)downloadPersonalImageWithCallback:(HVTaskCompletion)callback
{
    HVGetPersonalImageTask* task = [[HVGetPersonalImageTask alloc] initWithRecord:self andCallback:callback];
    HVCHECK_NOTNULL(task);
    
    [task start];
    return task;
    
LError:
    return nil;
}

-(HVClientResult *)validate
{    
    HVVALIDATE_BEGIN;
    
    HVCHECK_RESULT([super validate]);
    
    HVVALIDATE_STRING(m_name, HVClientError_InvalidRecord);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
   
}

-(void) serializeAttributes:(XWriter *)writer
{
    [super serializeAttributes:writer];
    
    HVSERIALIZE_ATTRIBUTE(m_displayName, c_element_displayname);
    HVSERIALIZE_ATTRIBUTE(m_relationship, c_element_relationship);
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_TEXT(m_name);
}

-(void) deserializeAttributes:(XReader *)reader
{
    [super deserializeAttributes:reader];
    
    HVDESERIALIZE_ATTRIBUTE(m_displayName, c_element_displayname);
    HVDESERIALIZE_ATTRIBUTE(m_relationship, c_element_relationship);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_TEXT(m_name);
}

@end

@implementation HVRecordCollection

-(id) init
{
    return [self initWithRecordArray:nil];
}

-(id)initWithRecordArray:(NSArray *)records
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVRecord class];
    
    if (records)
    {
        for (HealthVaultRecord* record in records) 
        {
            HVRecord *hvRecord = [[HVRecord alloc] initWithRecord:record];
            [self addObject:hvRecord];
            [hvRecord release];
        }
    }
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVRecord *)itemAtIndex:(NSUInteger)index
{
    return (HVRecord *) [m_inner objectAtIndex:index];
}

-(NSInteger)indexOfRecordID:(NSString *)recordID
{
    for (NSUInteger i = 0, count = self.count; i < count; ++i)
    {
        HVRecord* record = [self itemAtIndex:i];
        if ([record.ID isEqualToString:recordID])
        {
            return i;
        }
    }
    
    return NSNotFound;
}

@end

