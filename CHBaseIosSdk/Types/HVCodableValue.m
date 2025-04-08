//
//  HVCodableValue.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVCodableValue.h"

static const xmlChar* x_element_text = XMLSTRINGCONST("text");
static NSString* const c_element_code = @"code";
static const xmlChar* x_element_code = XMLSTRINGCONST("code");

@implementation HVCodableValue

@synthesize text = m_text;

-(BOOL) hasCodes
{
    return ![NSArray isNilOrEmpty:m_codes];
}

-(NSMutableArray *) codes
{
    HVENSURE(m_codes, HVCodedValueCollection);
    return m_codes;
}

-(void)setCodes:(HVCodedValueCollection *)codes
{
    HVRETAIN(m_codes, codes);
}

-(HVCodedValue *)firstCode
{
    return (self.hasCodes) ? [m_codes itemAtIndex:0] : nil;
}

-(id) initWithText:(NSString *)textValue
{
    return [self initWithText:textValue andCode:nil];
}

-(id) initWithText:(NSString *)textValue andCode:(HVCodedValue *)code
{
    HVCHECK_STRING(textValue);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.text = textValue;
    if (code)
    {
        NSMutableArray *codes = self.codes;
        HVCHECK_NOTNULL(codes);
        [codes addObject:code];
    }
    
    return self;
    
LError:
    HVALLOC_FAIL;    
}

-(id) initWithText:(NSString *)textValue code:(NSString *)code andVocab:(NSString *)vocab
{
    HVCodedValue* codedValue = [[HVCodedValue alloc] initWithCode:code andVocab:vocab];
    HVCHECK_NOTNULL(codedValue);
    
    self = [self initWithText:textValue andCode:codedValue];
    [codedValue release];
    
    return self;

LError:
    HVALLOC_FAIL; 
}

+(HVCodableValue *)fromText:(NSString *)textValue
{
    return [[[HVCodableValue alloc] initWithText:textValue] autorelease];
}

+(HVCodableValue *)fromText:(NSString *)textValue andCode:(HVCodedValue *)code
{
    return [[[HVCodableValue alloc] initWithText:textValue andCode:code] autorelease];
}

+(HVCodableValue *)fromText:(NSString *)textValue code:(NSString *)code andVocab:(NSString *)vocab
{
    return [[[HVCodableValue alloc] initWithText:textValue code:code andVocab:vocab] autorelease];
}

-(void) dealloc
{
    [m_text release];
    [m_codes release];
    [super dealloc];
}

-(BOOL)matchesDisplayText:(NSString *)text
{
    return ([m_text caseInsensitiveCompare:[text trim]] == NSOrderedSame);
}

-(BOOL)containsCode:(HVCodedValue *)code
{
    if (!m_codes)
    {
        return FALSE;
    }
    
    return [m_codes containsCode:code];
}

-(BOOL)addCode:(HVCodedValue *)code
{
    HVCodedValueCollection* codes = self.codes;
    HVCHECK_NOTNULL(codes);
    
    [codes addObject:code];
    
    return TRUE;
    
LError:
    return FALSE;
}

-(void)clearCodes
{
    if (m_codes)
    {
        [m_codes removeAllObjects];
    }
}

-(HVCodableValue *)clone
{
    HVCodableValue* cloned = [[[HVCodableValue alloc] initWithText:m_text] autorelease];
    HVCHECK_NOTNULL(cloned);
    
    if (self.hasCodes)
    {
        HVCodedValueCollection* codes = self.codes;
        for (NSUInteger i = 0, count = codes.count; i < count; ++i)
        {
            HVCodedValue* clonedCode = [[codes itemAtIndex:i] clone];
            HVCHECK_NOTNULL(clonedCode);
            
            [cloned addCode:clonedCode];
        }
    }
    
    return cloned;

LError:
    return nil;
}

-(NSString *) description
{
    return [self toString];
}

-(NSString *)toString
{
    return m_text;
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    return [NSString stringWithFormat:format, m_text];
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE_STRING(self.text, HVClientError_InvalidCodableValue);
    if (self.hasCodes)
    {
        for (HVCodedValue* code in self.codes)
        {
            HVVALIDATE(code, HVClientError_InvalidCodableValue);
        }
    }
    
    HVVALIDATE_SUCCESS;

LError:
    HVVALIDATE_FAIL;
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING_X(m_text, x_element_text);
    HVSERIALIZE_ARRAY(m_codes, c_element_code);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING_X(m_text, x_element_text);
    HVDESERIALIZE_TYPEDARRAY_X(m_codes, x_element_code, HVCodedValue, HVCodedValueCollection);
}

@end

@implementation HVCodableValueCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVCodableValue class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void) addItem:(HVCodableValue *)value
{
    [super addObject:value];
}

-(HVCodableValue *)itemAtIndex:(NSUInteger)index
{
    return [self objectAtIndex:index];
}

@end
