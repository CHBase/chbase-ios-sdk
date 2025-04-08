//
//  HVCondition.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVCondition.h"
#import "HVClient.h"
#import "HVLocalVocabStore.h"

static NSString* const c_typeid = @"7ea7a1f9-880b-4bd4-b593-f5660f20eda8";
static NSString* const c_typename = @"condition";

static NSString* const c_element_name = @"name";
static NSString* const c_element_onset = @"onset-date";
static NSString* const c_element_status = @"status";
static NSString* const c_element_stop = @"stop-date";
static NSString* const c_element_reason = @"stop-reason";

@implementation HVCondition

@synthesize name = m_name;
@synthesize onsetDate = m_onsetDate;
@synthesize status = m_status;
@synthesize stopDate = m_stopDate;
@synthesize stopReason = m_stopReason;

-(id)initWithName:(NSString *)name
{
    HVCHECK_STRING(name);
    
    self = [super init];
    HVCHECK_SELF;
    
    m_name = [[HVCodableValue alloc] initWithText:name];
    HVCHECK_NOTNULL(m_name);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    return (m_name) ? [m_name toString] : c_emptyString;
}

-(void)dealloc
{
    [m_name release];
    [m_onsetDate release];
    [m_status release];
    [m_stopDate release];
    [m_stopReason release];
    
    [super dealloc];
}

+(HVVocabIdentifier *)vocabForStatus
{
    return [[[HVVocabIdentifier alloc] initWithFamily:c_hvFamily andName:@"condition-occurrence"] autorelease];    
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_name, HVClientError_InvalidCondition);
    HVVALIDATE_OPTIONAL(m_onsetDate);
    HVVALIDATE_OPTIONAL(m_status);
    HVVALIDATE_OPTIONAL(m_stopDate);
    HVVALIDATE_STRINGOPTIONAL(m_stopReason, HVClientError_InvalidCondition);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_name, c_element_name);
    HVSERIALIZE(m_onsetDate, c_element_onset);
    HVSERIALIZE(m_status, c_element_status);
    HVSERIALIZE(m_stopDate, c_element_stop);
    HVSERIALIZE_STRING(m_stopReason, c_element_reason);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_name, c_element_name, HVCodableValue);
    HVDESERIALIZE(m_onsetDate, c_element_onset, HVApproxDateTime);
    HVDESERIALIZE(m_status, c_element_status, HVCodableValue);
    HVDESERIALIZE(m_stopDate, c_element_stop, HVApproxDateTime);
    HVDESERIALIZE_STRING(m_stopReason, c_element_reason);
}

+(NSString *)typeID
{
    return c_typeid;
}

+(NSString *) XRootElement
{
    return c_typename;
}

+(HVItem *) newItem
{
    return [[HVItem alloc] initWithType:[HVCondition typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Condition", @"Condition Type Name");
}

@end
