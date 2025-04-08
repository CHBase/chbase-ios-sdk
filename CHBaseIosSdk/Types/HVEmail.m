//
//  HVEmail.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVEmail.h"

static NSString* const c_element_description = @"description";
static NSString* const c_element_isPrimary = @"is-primary";
static NSString* const c_element_address = @"address";

@implementation HVEmail

@synthesize address = m_address;
@synthesize type = m_type;
@synthesize isPrimary = m_isprimary;

-(id)initWithEmailAddress:(NSString *)email
{
    self = [super init];
    HVCHECK_SELF;
    
    m_address = [[HVEmailAddress alloc] initWith:email];
    HVCHECK_NOTNULL(m_address);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_address release];
    [m_type release];
    [m_isprimary release];
    
    [super dealloc];
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    return (m_address) ? m_address.value : c_emptyString;
}

+(HVVocabIdentifier *)vocabForType
{
    return [[[HVVocabIdentifier alloc] initWithFamily:c_hvFamily andName:@"email-types"] autorelease];        
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_address, HVClientError_InvalidEmail);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING(m_type, c_element_description);
    HVSERIALIZE(m_isprimary, c_element_isPrimary);
    HVSERIALIZE(m_address, c_element_address);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING(m_type, c_element_description);
    HVDESERIALIZE(m_isprimary, c_element_isPrimary, HVBool);
    HVDESERIALIZE(m_address, c_element_address, HVEmailAddress);
}

@end

@implementation HVEmailCollection

-(id) init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVEmail class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVEmail *)itemAtIndex:(NSUInteger)index
{
    return (HVEmail *) [self objectAtIndex:index];
}

@end

