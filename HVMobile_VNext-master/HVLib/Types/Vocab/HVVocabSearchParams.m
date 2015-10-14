//
//  HVVocabSearch.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVVocabSearchParams.h"

static NSString* const c_element_text = @"search-string";
static NSString* const c_element_max = @"max-results";

@implementation HVVocabSearchParams

@synthesize text = m_text;
@synthesize maxResults = m_maxResults;

-(id)initWithText:(NSString *)text
{
    HVCHECK_STRING(text);
    
    self = [super init];
    HVCHECK_SELF;
    
    m_text = [[HVVocabSearchText alloc] initWith:text];
    HVCHECK_NOTNULL(m_text);
    
    m_maxResults = 25;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_text release];
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN

    HVVALIDATE(m_text, HVClientError_InvalidVocabSearch);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_text, c_element_text);
    if (m_maxResults > 0)
    {
        HVSERIALIZE_INT(m_maxResults, c_element_max);
    }
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_text, c_element_text, HVVocabSearchText);
    HVDESERIALIZE_INT(m_maxResults, c_element_max);
}

@end
