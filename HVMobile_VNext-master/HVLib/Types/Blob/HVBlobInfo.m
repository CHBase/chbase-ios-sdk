//
//  HVBlobInfo.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVBlobInfo.h"

static NSString* const c_element_name = @"name";
static NSString* const c_element_contentType = @"content-type";

@implementation HVBlobInfo

-(NSString *)name
{
    NSString* blobName = (m_name) ? m_name.value : nil;
    return (blobName) ? blobName : c_emptyString;
}

-(void)setName:(NSString *)name
{
    HVENSURE(m_name, HVStringZ255);    
    m_name.value = name;
}

-(NSString *)contentType
{
    return (m_contentType) ? m_contentType.value : nil;
}

-(void)setContentType:(NSString *)contentType
{
    HVENSURE(m_contentType, HVStringZ1024);
    m_contentType.value = contentType;
}

-(id)initWithName:(NSString *)name andContentType:(NSString *)contentType
{
    self = [super init];
    HVCHECK_SELF;
    
    self.name = name;
    self.contentType = contentType;
    
    HVCHECK_NOTNULL(m_name);
    HVCHECK_NOTNULL(m_contentType);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_name release];
    [m_contentType release];
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_OPTIONAL(m_name);
    HVVALIDATE_OPTIONAL(m_contentType);
    
    HVVALIDATE_FAIL
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_name, c_element_name);
    HVSERIALIZE(m_contentType, c_element_contentType);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_name, c_element_name, HVStringZ255);
    HVDESERIALIZE(m_contentType, c_element_contentType, HVStringZ1024);
}


@end
