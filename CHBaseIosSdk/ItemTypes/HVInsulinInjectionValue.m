#import "HVCommon.h"
#import "HVClient.h"
#import "HVInsulinInjectionValue.h"

static NSString* const c_element_ie = @"IE";

@implementation HVInsulinInjectionValue
@synthesize ie = m_ie;
@synthesize display = m_display;

-(void)dealloc
{
    [m_ie release];
    [m_display release];
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
    HVSERIALIZE(m_ie, c_element_ie);
    HVSERIALIZE(m_display, c_element_display);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_ie, c_element_ie,HVPositiveDouble);
    HVDESERIALIZE(m_display, c_element_display, HVDisplayValue);
}

@end
