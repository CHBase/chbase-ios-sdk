#import "HVCommon.h"
#import "HVClient.h"
#import "HVReferralTask.h"

static NSString* const c_element_businessStatus = @"business-status";
static NSString* const c_element_taskReason = @"task-reason";
static NSString* const c_element_createdDate = @"created-date";
static NSString* const c_element_updatedDate = @"updated-date";
static NSString* const c_element_completedDate = @"completed-date";
static NSString* const c_element_statusReason = @"status-reason";
static NSString* const c_element_owner = @"owner";
static NSString* const c_element_note = @"note";

@implementation HVReferralTask
@synthesize businessStatus = m_businessStatus;
@synthesize taskReason = m_taskReason;
@synthesize createdDate = m_createdDate;
@synthesize updatedDate = m_updatedDate;
@synthesize completedDate = m_completedDate;
@synthesize statusReason = m_statusReason;
@synthesize owner = m_owner;
@synthesize note = m_note;

-(void)dealloc
{
    [m_businessStatus release];
    [m_taskReason release];
    [m_createdDate release];
    [m_updatedDate release];
    [m_completedDate release];
    [m_statusReason release];
    [m_owner release];
    [m_note release];
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    HVVALIDATE_SUCCESS
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_businessStatus, c_element_businessStatus);
    HVSERIALIZE(m_taskReason, c_element_taskReason);
    HVSERIALIZE(m_createdDate, c_element_createdDate);
    HVSERIALIZE(m_updatedDate, c_element_updatedDate);
    HVSERIALIZE(m_completedDate, c_element_completedDate);
    HVSERIALIZE(m_statusReason, c_element_statusReason);
    HVSERIALIZE(m_owner, c_element_owner);
    HVSERIALIZE_STRING(m_note, c_element_note);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_businessStatus, c_element_businessStatus, HVCodableValue);
    HVDESERIALIZE(m_taskReason, c_element_taskReason, HVCodableValue);
    HVDESERIALIZE(m_createdDate, c_element_createdDate, HVDateTime);
    HVDESERIALIZE(m_updatedDate, c_element_updatedDate, HVDateTime);
    HVDESERIALIZE(m_completedDate, c_element_completedDate, HVDateTime);
    HVDESERIALIZE(m_statusReason, c_element_statusReason, HVCodableValue);
    HVDESERIALIZE(m_owner, c_element_owner, HVPerson);
    HVDESERIALIZE_STRING(m_note, c_element_note);
}

@end


@implementation HVTaskCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVReferralTask class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)addItem:(HVReferralTask *)item
{
    [super addObject:item];
}

-(HVReferralTask *)itemAtIndex:(NSUInteger)index
{
    return [super objectAtIndex:index];
}

@end
