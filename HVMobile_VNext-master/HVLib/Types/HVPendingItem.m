//
//  HVPendingItem.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVPendingItem.h"

static const xmlChar* x_element_id = XMLSTRINGCONST("thing-id");
static const xmlChar* x_element_type = XMLSTRINGCONST("type-id");
static const xmlChar* x_element_edate = XMLSTRINGCONST("eff-date");

@implementation HVPendingItem

@synthesize key = m_id;
@synthesize type = m_type;
@synthesize effectiveDate = m_effectiveDate;

-(void) dealloc
{
    [m_id release];
    [m_type release];
    [m_effectiveDate release];
    
    [super dealloc];
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_id, HVClientError_InvalidPendingItem);
    HVVALIDATE_OPTIONAL(m_type);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_id, x_element_id);
    HVSERIALIZE_X(m_type, x_element_type);
    HVSERIALIZE_DATE_X(m_effectiveDate, x_element_edate);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_id, x_element_id, HVItemKey);
    HVDESERIALIZE_X(m_type, x_element_type, HVItemType);
    HVDESERIALIZE_DATE_X(m_effectiveDate, x_element_edate);
}

@end

@implementation HVPendingItemCollection

-(id) init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVPendingItem class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

@end

