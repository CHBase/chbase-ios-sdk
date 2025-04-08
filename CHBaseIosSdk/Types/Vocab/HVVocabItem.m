//
//  HVVocabItem.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVVocabItem.h"

static const xmlChar* x_element_code = XMLSTRINGCONST("code-value");
static const xmlChar* x_element_displaytext = XMLSTRINGCONST("display-text");
static const xmlChar* x_element_abbrv = XMLSTRINGCONST("abbreviation-text");
static NSString* const c_element_data = @"info-xml";

@implementation HVVocabItem

@synthesize code = m_code;
@synthesize displayText = m_displayText;
@synthesize abbreviation = m_abbrv;
@synthesize dataXml = m_data;

-(void)dealloc
{
    [m_code release];
    [m_displayText release];
    [m_abbrv release];
    [m_data release];
    [super dealloc];
}

-(NSString *)toString
{
    return m_displayText;
}

-(NSString *)description
{
    return [self toString];
}

-(BOOL) matchesDisplayText:(NSString *)text
{
    return ([m_displayText caseInsensitiveCompare:[text trim]] == NSOrderedSame);
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE_STRING(m_code, HVClientError_InvalidVocabIdentifier);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;    
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING_X(m_code, x_element_code);
    HVSERIALIZE_STRING_X(m_displayText, x_element_displaytext);
    HVSERIALIZE_STRING_X(m_abbrv, x_element_abbrv);
    HVSERIALIZE_RAW(m_data);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING_X(m_code, x_element_code);
    HVDESERIALIZE_STRING_X(m_displayText, x_element_displaytext);
    HVDESERIALIZE_STRING_X(m_abbrv, x_element_abbrv);
    HVDESERIALIZE_RAW(m_data, c_element_data);    
}

@end

@implementation HVVocabItemCollection

-(id) init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVVocabItem class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVVocabItem *)itemAtIndex:(NSUInteger)index
{
    return (HVVocabItem *) [self objectAtIndex:index];
}

-(void)sortByDisplayText
{
    [self sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        HVVocabItem* x = (HVVocabItem *) obj1;
        HVVocabItem* y = (HVVocabItem *) obj2;
        
        return [x.displayText compare:y.displayText];
        
    } ];
}

-(void)sortByCode
{
    [self sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        HVVocabItem* x = (HVVocabItem *) obj1;
        HVVocabItem* y = (HVVocabItem *) obj2;
        
        return [x.code compare:y.code];
    }];
}

-(NSUInteger)indexOfVocabCode:(NSString *)code
{
    for (NSUInteger i = 0, count = self.count; i < count; ++i)
    {
        HVVocabItem* item = [self itemAtIndex:i];
        if ([item.code isEqualToString:code])
        {
            return i;
        }
    }
    
    return NSNotFound;
}

-(HVVocabItem *)getItemWithCode:(NSString *)code
{
    NSUInteger index = [self indexOfVocabCode:code];
    if (index == NSNotFound)
    {
        return nil;
    }
    
    return [self itemAtIndex:index];
}

-(NSString *)displayTextForCode:(NSString *)code
{
    HVVocabItem* vocabItem = [self getItemWithCode:code];
    if (!vocabItem)
    {
        return nil;
    }
    
    return vocabItem.displayText;
}

-(NSArray *)displayStrings
{
    NSMutableArray* strings = [[[NSMutableArray alloc]initWithCapacity:self.count] autorelease];
    [self addDisplayStringsTo:strings];
    return strings;
}

-(void)addDisplayStringsTo:(NSMutableArray *)strings
{
    for (NSUInteger i = 0, count = self.count; i < count; ++i)
    {
        [strings addObject:[self itemAtIndex:i].displayText];
    }    
}

@end
