//
//  HVResponse.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVResponse.h"

static const xmlChar* x_element_status = XMLSTRINGCONST("status");

@implementation HVResponse

@synthesize status = m_status;
@synthesize body = m_body;

-(BOOL)hasError
{
    return (m_status != nil && m_status.hasError);
}

-(void)dealloc
{
    [m_status release];
    [m_body release];
    
    [super dealloc];
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_status, x_element_status, HVResponseStatus);
    if (reader.isStartElement)
    {
        HVRETAIN(m_body, [reader readOuterXml]);
    }
}

@end
