//
//  HVRelative.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVRelative.h"

static NSString* const c_element_relationship = @"relationship";
static NSString* const c_element_name = @"relative-name";
static NSString* const c_element_dateOfBirth = @"date-of-birth";
static NSString* const c_element_dateOfDeath = @"date-of-death";
static NSString* const c_element_region = @"region-of-origin";

@implementation HVRelative

@synthesize relationship = m_relationship;
@synthesize person = m_person;
@synthesize dateOfBirth = m_dateOfBirth;
@synthesize dateOfDeath = m_dateOfDeath;
@synthesize regionOfOrigin = m_regionOfOrigin;

-(id)initWithRelationship:(NSString *)relationship
{
    return [self initWithPerson:nil andRelationship:[HVCodableValue fromText:relationship]];
}

-(id)initWithPerson:(HVPerson *)person andRelationship :(HVCodableValue *)relationship 
{
    self = [super init];
    HVCHECK_SELF;
    
    if (person)
    {
        self.person = person;
    }
    
    if (relationship)
    {
        self.relationship = relationship;
    }
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_relationship release];
    [m_person release];
    [m_dateOfBirth release];
    [m_dateOfDeath release];
    [m_regionOfOrigin release];
    
    [super dealloc];
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    if (m_person)
    {
        return [m_person toString];
    }
    
    return (m_relationship) ? [m_relationship toString] : c_emptyString;
}

+(HVVocabIdentifier *)vocabForRelationship
{
    return [[[HVVocabIdentifier alloc] initWithFamily:c_hvFamily andName:@"personal-relationship"] autorelease];
}

+(HVVocabIdentifier *)vocabForRegionOfOrigin
{
    return [[[HVVocabIdentifier alloc] initWithFamily:c_hvFamily andName:@"family-history-region-of-origin"] autorelease];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_relationship, HVClientError_InvalidRelative);
    HVVALIDATE_OPTIONAL(m_person);
    HVVALIDATE_OPTIONAL(m_dateOfBirth);
    HVVALIDATE_OPTIONAL(m_dateOfDeath);
    HVVALIDATE_OPTIONAL(m_regionOfOrigin);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_relationship, c_element_relationship);
    HVSERIALIZE(m_person, c_element_name);
    HVSERIALIZE(m_dateOfBirth, c_element_dateOfBirth);
    HVSERIALIZE(m_dateOfDeath, c_element_dateOfDeath);
    HVSERIALIZE(m_regionOfOrigin, c_element_region);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_relationship, c_element_relationship, HVCodableValue);
    HVDESERIALIZE(m_person, c_element_name, HVPerson);
    HVDESERIALIZE(m_dateOfBirth, c_element_dateOfBirth, HVApproxDate);
    HVDESERIALIZE(m_dateOfDeath, c_element_dateOfDeath, HVApproxDate);
    HVDESERIALIZE(m_regionOfOrigin, c_element_region, HVCodableValue);    
}

@end
