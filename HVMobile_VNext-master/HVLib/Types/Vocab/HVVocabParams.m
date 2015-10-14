//
//  HVVocabParams.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVVocabParams.h"

static NSString* const c_element_vocabkey = @"vocabulary-key";
static NSString* const c_element_culture = @"fixed-culture";

@implementation HVVocabParams

-(HVVocabIdentifierCollection *)vocabIDs
{
    HVENSURE(m_vocabIDs, HVVocabIdentifierCollection);
    return m_vocabIDs;
}

@synthesize fixedCulture = m_fixedCulture;

-(id)initWithVocabID:(HVVocabIdentifier *)vocabID
{
    HVCHECK_NOTNULL(vocabID);
    
    self = [super init];
    HVCHECK_SELF;

    [self.vocabIDs addObject:vocabID];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(id)initWithVocabIDs:(HVVocabIdentifierCollection *)vocabIDs
{
    HVCHECK_NOTNULL(vocabIDs);
    
    self = [super init];
    HVCHECK_SELF;
    
    HVRETAIN(m_vocabIDs, vocabIDs);
    
    return self;
    
LError:
    HVALLOC_FAIL;    
}

-(void)dealloc
{
    [m_vocabIDs release];
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_ARRAY(m_vocabIDs, HVClientError_InvalidVocabIdentifier);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_ARRAY(m_vocabIDs, c_element_vocabkey);
    HVSERIALIZE_BOOL(m_fixedCulture, c_element_culture);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_TYPEDARRAY(m_vocabIDs, c_element_vocabkey, HVVocabIdentifier, HVVocabIdentifierCollection);
    HVDESERIALIZE_BOOL(m_fixedCulture, c_element_culture);
}

@end
