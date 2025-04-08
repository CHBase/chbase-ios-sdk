//
//  HVVocabIdentifier.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVVocabIdentifier.h"

static NSString* const c_element_name = @"name";
static NSString* const c_element_family = @"family";
static NSString* const c_element_version = @"version";
static NSString* const c_element_lang = @"xml:lang";
static NSString* const c_element_code = @"code-value";



NSString* const c_rxNormFamily = @"RxNorm";
NSString* const c_snomedFamily = @"Snomed";
NSString* const c_hvFamily = @"wc";
NSString* const c_icdFamily = @"icd";
NSString* const c_hl7Family = @"HL7";
NSString* const c_isoFamily = @"iso";
NSString* const c_usdaFamily = @"usda";

@implementation HVVocabIdentifier

@synthesize name = m_name;
@synthesize family = m_family; 
@synthesize version = m_version;
@synthesize language = m_lang;
@synthesize codeValue = m_codeValue;

-(id)initWithFamily:(NSString *)family andName:(NSString *)name
{
    HVCHECK_STRING(family);
    HVCHECK_STRING(name);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.family = family;
    self.name = name;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_name release];
    [m_family release];
    [m_version release];
    [m_lang release];
    [m_codeValue release];
    
    [m_keyString release];
    
    [super dealloc];
}

-(HVCodedValue *)codedValueForItem:(HVVocabItem *)vocabItem
{
    HVCHECK_NOTNULL(vocabItem);
    
    return [[[HVCodedValue alloc] initWithCode:vocabItem.code vocab:m_name vocabFamily:m_family vocabVersion:m_version] autorelease];
    
LError:
    return nil;
}

-(HVCodedValue *)codedValueForCode:(NSString *)code
{
    HVCHECK_STRING(code);
    
    return [[[HVCodedValue alloc] initWithCode:code vocab:m_name vocabFamily:m_family vocabVersion:m_version] autorelease];
LError:
    return nil;
}

-(HVCodableValue *)codableValueForText:(NSString *)text andCode:(NSString *)code
{
    HVCodableValue* codable = [HVCodableValue fromText:text];
    HVCHECK_NOTNULL(codable);
    
    HVCodedValue* codedValue = [self codedValueForCode:code];
    HVCHECK_NOTNULL(codedValue);
    
    [codable addCode:codedValue];
    
    return codable;
    
LError:
    return nil;
}

-(NSString *)toKeyString
{
    if (m_keyString)
    {
        return m_keyString;
    }
    
    NSString* keyString;
    if (m_version)
    {
        keyString = [NSString stringWithFormat:@"%@_%@_%@", m_name, m_family, m_version];
    }
    else 
    {
        keyString = [NSString stringWithFormat:@"%@_%@", m_name, m_family];
    }
    
    HVRETAIN(m_keyString, keyString);
    return m_keyString;
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE_STRING(m_name, HVClientError_InvalidVocabIdentifier);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void)serializeAttributes:(XWriter *)writer
{
    HVSERIALIZE_ATTRIBUTE(m_lang, c_element_lang);
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING(m_name, c_element_name);
    HVSERIALIZE_STRING(m_family, c_element_family);
    HVSERIALIZE_STRING(m_version, c_element_version);
    HVSERIALIZE_STRING(m_codeValue, c_element_code);
}

-(void)deserializeAttributes:(XReader *)reader
{
    HVDESERIALIZE_ATTRIBUTE(m_lang, c_element_lang);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING(m_name, c_element_name);
    HVDESERIALIZE_STRING(m_family, c_element_family);
    HVDESERIALIZE_STRING(m_version, c_element_version);
    HVDESERIALIZE_STRING(m_codeValue, c_element_code);
}

@end

@implementation HVVocabIdentifierCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVVocabIdentifier class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

@end

