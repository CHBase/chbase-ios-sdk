//
//  HVOccurence.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVOccurence.h"

static NSString* const c_element_when = @"when";
static NSString* const c_element_minutes = @"minutes";

@implementation HVOccurence

@synthesize when = m_when;
@synthesize durationMinutes = m_minutes;

-(void)dealloc
{
    [m_when release];
    [m_minutes release];
    [super dealloc];
}

-(id)initForDuration:(int)minutes startingAt:(HVTime *)time
{
    HVCHECK_NOTNULL(time);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.when = time;
    
    m_minutes = [[HVNonNegativeInt alloc] initWith:minutes];
    HVCHECK_NOTNULL(m_minutes);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(id)initForDuration:(int)minutes startingAtHour:(int)hour andMinute:(int)minute
{
    HVTime* time = [[HVTime alloc] initWithHour:hour minute:minute];
    HVCHECK_NOTNULL(time);
    
    self = [self initForDuration:minutes startingAt:time];
    [time release];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

+(HVOccurence *)forDuration:(int)minutes atHour:(int)hour andMinute:(int)minute
{
    return [[[HVOccurence alloc] initForDuration:minutes startingAtHour:hour andMinute:minute] autorelease];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_when, HVClientError_InvalidOccurrence);
    HVVALIDATE(m_minutes, HVClientError_InvalidOccurrence);
    
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

@implementation HVOccurenceCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVOccurence class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVOccurence *)itemAtIndex:(NSUInteger)index
{
    return (HVOccurence *) [self objectAtIndex:0];
}
@end