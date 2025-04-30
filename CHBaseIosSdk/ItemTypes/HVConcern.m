#import "HVCommon.h"
#import "HVClient.h"
#import "HVConcern.h"

static NSString* const c_typeid = @"AEA2E8F2-11DD-4A7D-AB43-1D58764EBC19";
static NSString* const c_typename = @"concern";

static NSString* const c_element_description = @"description";
static NSString* const c_element_status = @"status";

@implementation HVConcern
@synthesize description = m_description;
@synthesize status = m_status;

-(void)dealloc
{
    [m_description release];
    [m_status release];
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
    HVSERIALIZE(m_description, c_element_description);
    HVSERIALIZE(m_status, c_element_status);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_description, c_element_description, HVCodableValue);
    HVDESERIALIZE(m_status, c_element_status, HVCodableValue);
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
    return [[HVItem alloc] initWithType:[HVConcern typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Concern", @"Concern");
}

@end