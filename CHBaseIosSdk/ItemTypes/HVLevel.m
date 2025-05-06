#import "HVCommon.h"
#import "HVClient.h"
#import "HVLevel.h"

static NSString* const c_element_startTime = @"start-time";
static NSString* const c_element_minutes = @"minutes";
static NSString* const c_element_state = @"state";

@implementation HVLevel
@synthesize startTime = m_startTime;
@synthesize minutes = m_minutes;
@synthesize state = m_state;

-(void)dealloc
{
    [m_startTime release];
    [m_minutes release];
    [m_state release];
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
    HVSERIALIZE(m_startTime, c_element_startTime);
    HVSERIALIZE(m_minutes, c_element_minutes);
    HVSERIALIZE(m_state, c_element_state);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_startTime, c_element_startTime, HVTime);
    HVDESERIALIZE(m_minutes, c_element_minutes, HVNonNegativeInt);
    HVDESERIALIZE(m_state, c_element_state, HVCodableValue);
}


@end


@implementation HVLevelCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVTask class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)addItem:(HVLevel *)item
{
    [super addObject:item];
}

-(HVLevel *)itemAtIndex:(NSUInteger)index
{
    return [super objectAtIndex:index];
}

@end
