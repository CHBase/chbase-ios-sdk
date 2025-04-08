//
//  HVItemView.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVItemView.h"

static NSString* const c_element_section = @"section";
static NSString* const c_element_xml = @"xml";
static NSString* const c_element_versions = @"type-version-format";

@interface HVItemView (HVPrivate) 

-(HVStringCollection *) createStringsFromSections;
-(enum HVItemSection) stringsToSections:(HVStringCollection *) strings;

@end

@implementation HVItemView

@synthesize sections = m_sections;
@synthesize transforms = m_transforms;
@synthesize typeVersions = m_typeVersions;

-(HVStringCollection *)transforms
{
    if (!m_transforms)
    {
        m_transforms = [[HVStringCollection alloc] init];
    }
    return m_transforms;
}

-(id) init
{
    self = [super init];
    HVCHECK_SELF;
    
    m_sections = HVItemSection_Standard;
    
    m_typeVersions = [[HVStringCollection alloc] init];
    
    HVCHECK_NOTNULL(m_typeVersions);
   
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void) dealloc
{
    [m_transforms release];
    [m_typeVersions release];

    [super dealloc];
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE_ARRAYOPTIONAL(m_typeVersions, HVClientError_InvalidItemView);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void) serialize:(XWriter *)writer
{
    HVStringCollection *sections = nil;
    @try
    {
        sections = [self createStringsFromSections];
        HVSERIALIZE_STRINGCOLLECTION(sections, c_element_section);
        if (m_sections & HVItemSection_Data)
        {
            [writer writeEmptyElement:c_element_xml];
        }
        HVSERIALIZE_STRINGCOLLECTION(m_transforms, c_element_xml);
        HVSERIALIZE_STRINGCOLLECTION(m_typeVersions, c_element_versions);
    }
    @finally {
        [sections release];
    }    
}

-(void) deserialize:(XReader *)reader
{
    HVStringCollection* sections = nil;
    @try {
        
        HVDESERIALIZE_STRINGCOLLECTION(sections, c_element_section);
        HVDESERIALIZE_STRINGCOLLECTION(m_transforms, c_element_xml);
        HVDESERIALIZE_STRINGCOLLECTION(m_typeVersions, c_element_versions);
        
        m_sections = [self stringsToSections:sections];
        if ([m_transforms containsString:c_emptyString])
        {
            m_sections |= HVItemSection_Data;
            [m_transforms removeString:c_emptyString];
        }
     }

    @finally {
        [sections release];
    }
}

@end

@implementation HVItemView (HVPrivate)

-(HVStringCollection *) createStringsFromSections
{
    HVStringCollection* array = [[HVStringCollection alloc] init];
    if (m_sections & HVItemSection_Core)
    {
        [array addObject:HVItemSectionToString(HVItemSection_Core)];
    }
    if (m_sections & HVItemSection_Audits)
    {
        [array addObject:HVItemSectionToString(HVItemSection_Audits)];
    }
    if (m_sections & HVItemSection_Blobs)
    {
        [array addObject:HVItemSectionToString(HVItemSection_Blobs)];
    }
    if (m_sections & HVItemSection_Tags)
    {
        [array addObject:HVItemSectionToString(HVItemSection_Tags)];
    }
    if (m_sections & HVItemSection_Permissions)
    {
        [array addObject:HVItemSectionToString(HVItemSection_Permissions)];
    }
    if (m_sections & HVItemSection_Signatures)
    {
        [array addObject:HVItemSectionToString(HVItemSection_Signatures)];
    }
    
    return array;
}

-(enum HVItemSection) stringsToSections:(HVStringCollection *) strings
{
    enum HVItemSection section = HVItemSection_None;
    
    if (![HVStringCollection isNilOrEmpty:strings])
    {
        for (NSString* string in strings) {
            section |= HVItemSectionFromString(string); 
        }
    }
    
    return section;
}

@end
