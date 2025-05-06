#import "HVCommon.h"
#import "HVClient.h"
#import "HVAwakening.h"

static NSString* const c_element_when = @"when";
static NSString* const c_element_minutes = @"minutes";

@implementation HVAwakening
@synthesize when = m_when;
@synthesize minutes = m_minutes;

-(void)dealloc
{
    [m_when release];
    [m_minutes release];
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
    HVSERIALIZE(m_when, c_element_when);
    HVSERIALIZE(m_minutes, c_element_minutes);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_when, c_element_when, HVTime);
    HVDESERIALIZE(m_minutes, c_element_minutes, HVNonNegativeInt);
}

@end


@implementation HVAwakeningCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVTask class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)addItem:(HVAwakening *)item
{
    [super addObject:item];
}

-(HVAwakening *)itemAtIndex:(NSUInteger)index
{
    return [super objectAtIndex:index];
}

@end
