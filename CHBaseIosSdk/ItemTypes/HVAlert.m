#import "HVCommon.h"
#import "HVClient.h"
#import "HVAlert.h"

static NSString* const c_element_dow = @"dow";
static NSString* const c_element_time = @"time";
static const xmlChar* x_element_dow = XMLSTRINGCONST("dow");

@implementation HVAlert
@synthesize dow = m_dow;
@synthesize time = m_time;

-(void)dealloc
{
    [m_dow release];
    [m_time release];
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
    HVSERIALIZE_ARRAY(m_dow, c_element_dow);
    HVSERIALIZE_ARRAY(m_time, c_element_time);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_TYPEDARRAY(m_dow, c_element_dow, HVNonNegativeInt, HVNonNegativeIntCollection);
    HVDESERIALIZE_TYPEDARRAY(m_time, c_element_time, HVTime,HVTimeCollection);
}


@end


@implementation HVAlertCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVAlert class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)addItem:(HVAlert *)item
{
    [super addObject:item];
}

-(HVAlert *)itemAtIndex:(NSUInteger)index
{
    return [super objectAtIndex:index];
}

@end
