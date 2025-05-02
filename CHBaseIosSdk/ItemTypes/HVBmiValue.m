#import "HVCommon.h"
#import "HVClient.h"
#import "HVBmiValue.h"

static NSString* const c_element_kgm2 = @"kgm2";

@implementation HVBmiValue
@synthesize kgm2 = m_kgm2;
@synthesize display = m_display;

-(void)dealloc
{
    [m_kgm2 release];
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
    HVSERIALIZE(m_kgm2, c_element_kgm2);
    HVSERIALIZE(m_display, c_element_display);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_kgm2, c_element_kgm2, HVNonNegativeDouble);
    HVDESERIALIZE(m_display, c_element_display, HVDisplayValue);
}

@end
