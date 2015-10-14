//
//  HVCodedValue.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVCodedValue.h"


static const xmlChar* x_element_value = XMLSTRINGCONST("value");
static const xmlChar* x_element_family = XMLSTRINGCONST("family");
static const xmlChar* x_element_type = XMLSTRINGCONST("type");
static const xmlChar* x_element_version = XMLSTRINGCONST("version");

@implementation HVCodedValue

@synthesize code;
@synthesize  vocabularyName;
@synthesize vocabularyFamily;
@synthesize vocabularyVersion;

-(id) initWithCode:(NSString *)strcode andVocab:(NSString *)vocab
{
    return [self initWithCode:code vocab:vocab vocabFamily:nil vocabVersion:nil];
}

-(id)initWithCode:(NSString *)strcode vocab:(NSString *)vocab vocabFamily:(NSString *)family vocabVersion:(NSString *)version
{    
    HVCHECK_STRING(strcode);
    HVCHECK_STRING(vocab);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.code = code;
    self.vocabularyName = vocab;
    if (family)
    {
        self.vocabularyFamily = family;
    }
    if (version)
    {
        self.vocabularyVersion = version;
    }
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void) dealloc
{
    [code release];
    [vocabularyName release];
    [vocabularyFamily release];
    [vocabularyVersion release];
    [super dealloc];
 }

+(HVCodedValue *)fromCode:(NSString *)code andVocab:(NSString *)vocab
{
    return [[[HVCodedValue alloc] initWithCode:code andVocab:vocab] autorelease];
}

+(HVCodedValue *)fromCode:(NSString *)code vocab:(NSString *)vocab vocabFamily:(NSString *)family vocabVersion:(NSString *)version
{
    return [[[HVCodedValue alloc] initWithCode:code vocab:vocab vocabFamily:family vocabVersion:version] autorelease];
}

-(BOOL)isEqualToCodedValue:(HVCodedValue *)value
{
    if (value == nil)
    {
        return FALSE;
    }
    
    return (
                ((vocabularyName == nil && value.vocabularyName == nil) || [vocabularyName isEqualToString:value.vocabularyName])
            &&  ((code == nil && value.code == nil) || [code isEqualToString:value.code])
            &&  ((vocabularyFamily == nil && value.vocabularyFamily == nil) || [vocabularyFamily isEqualToString:value.vocabularyFamily])
            &&  ((vocabularyVersion == nil && value.vocabularyVersion == nil) || [vocabularyVersion isEqualToString:value.vocabularyVersion])
            );
}

-(BOOL)isEqualToCode:(NSString *)icode fromVocab:(NSString *)vocabName
{
    return ([code isEqualToString:icode] && [vocabularyName isEqualToString:vocabName]);
}

-(BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[HVCodedValue class]])
    {
        return FALSE;
    }
    
    return [self isEqualToCodedValue:(HVCodedValue *) object];
}

-(HVCodedValue *)clone
{
    HVCodedValue* cloned = [[[HVCodedValue alloc] init] autorelease];
    HVCHECK_NOTNULL(cloned);
    
    cloned.code = code;
    cloned.vocabularyName = vocabularyName;
    cloned.vocabularyFamily = vocabularyFamily;
    cloned.vocabularyVersion = vocabularyVersion;
    
    return cloned;
    
LError:
    return nil;
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN; 
    
    HVVALIDATE_STRING(code, HVClientError_InvalidCodedValue);
    HVVALIDATE_STRING(vocabularyName, HVClientError_InvalidCodedValue);
    HVVALIDATE_STRINGOPTIONAL(vocabularyFamily, HVClientError_InvalidCodedValue);
    HVVALIDATE_STRINGOPTIONAL(vocabularyVersion, HVClientError_InvalidCodedValue);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL; 
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING_X(code, x_element_value);
    HVSERIALIZE_STRING_X(vocabularyFamily, x_element_family);
    HVSERIALIZE_STRING_X(vocabularyName, x_element_type);
    HVSERIALIZE_STRING_X(vocabularyVersion, x_element_version);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING_X(code, x_element_value);
    HVDESERIALIZE_STRING_X(vocabularyFamily, x_element_family);
    HVDESERIALIZE_STRING_X(vocabularyName, x_element_type);
    HVDESERIALIZE_STRING_X(vocabularyVersion, x_element_version);
}

@end

@implementation HVCodedValueCollection

-(id) init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVCodedValue class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVCodedValue *)firstCode
{
    return [self itemAtIndex:0];
}

-(HVCodedValue *)itemAtIndex:(NSUInteger)index
{
    return (HVCodedValue *) [self objectAtIndex:index];
}

-(NSUInteger)indexOfCode:(HVCodedValue *)code
{
    for (NSUInteger i = 0, count = self.count; i < count; ++i)
    {
        if ([[self itemAtIndex:i] isEqualToCodedValue:code])
        {
            return i;
        }
    }
    
    return NSNotFound;
}

-(BOOL)containsCode:(HVCodedValue *)code
{
    return ([self indexOfCode:code] != NSNotFound);
}

@end
