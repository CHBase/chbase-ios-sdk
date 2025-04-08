//
//  HVServerError.m
//  HVLib
//
//
//

#import "HVCommon.h"
#import "HVServerError.h"

static const xmlChar* x_element_message = XMLSTRINGCONST("message");
static const xmlChar* x_element_context = XMLSTRINGCONST("context");
static const xmlChar* x_element_errorInfo = XMLSTRINGCONST("error-info");

@implementation HVServerError

@synthesize message = m_message;
@synthesize context = m_context;
@synthesize errorInfo = m_errorInfo;

-(void)dealloc
{
    [m_message release];
    [m_context release];
    [m_errorInfo release];
    
    [super dealloc];
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING_X(m_message, x_element_message);
    HVDESERIALIZE_RAW_X(m_context, x_element_context);
    HVDESERIALIZE_STRING_X(m_errorInfo, x_element_errorInfo);
}

@end
