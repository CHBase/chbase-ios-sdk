
#import "HVCommon.h"
#import "HVClient.h"
#import "HVHba1c.h"

static NSString* const c_element_mmolPerMol = @"mmol-per-mol";

@implementation HVHbA1CValue
@synthesize mmolPerMol = m_mmolPerMol;
@synthesize display = m_display;

-(void)dealloc
{
    [m_mmolPerMol release];
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
    HVSERIALIZE(m_mmolPerMol, c_element_mmolPerMol);
    HVSERIALIZE(m_display, c_element_display);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_mmolPerMol, c_element_mmolPerMol,HVPositiveDouble);
    HVDESERIALIZE(m_display, c_element_display, HVDisplayValue);
}

@end
