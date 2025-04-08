//
//  HVResponseStatus.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVResponseStatus.h"

static const xmlChar* x_element_code = XMLSTRINGCONST("code");
static const xmlChar* x_element_error = XMLSTRINGCONST("error");

@implementation HVResponseStatus

@synthesize code = m_code;
@synthesize error = m_error;

-(BOOL)hasError
{
    return (m_code != 0 || m_error != nil);
}

-(void)dealloc
{
    [m_error release];
    
    [super dealloc];
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_INT_X(m_code, x_element_code);
    HVSERIALIZE_X(m_error, x_element_error);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_INT_X(m_code, x_element_code);
    HVDESERIALIZE_X(m_error, x_element_error, HVServerError);
}

@end
