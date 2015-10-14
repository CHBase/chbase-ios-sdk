//
//  HVAudit.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVAudit.h"

static NSString* const c_element_when = @"timestamp";
static NSString* const c_element_appID = @"app-id";
static NSString* const c_element_action = @"audit-action";

@implementation HVAudit

@synthesize when = m_when;
@synthesize appID = m_appID;
@synthesize action = m_action;


-(void) dealloc
{
    [m_when release];
    [m_appID release];
    [m_action release];
    
    [super dealloc];
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_DATE(m_when, c_element_when);
    HVSERIALIZE_STRING(m_appID, c_element_appID);
    HVSERIALIZE_STRING(m_action, c_element_action);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_DATE(m_when, c_element_when);
    HVDESERIALIZE_STRING(m_appID, c_element_appID);
    HVDESERIALIZE_STRING(m_action, c_element_action);    
}

@end
