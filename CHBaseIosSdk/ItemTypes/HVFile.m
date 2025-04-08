//
//  HVFile.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVFile.h"
#import "HVBlob.h"
#import "HVCodableValue.h"

static NSString* const c_typeid = @"bd0403c5-4ae2-4b0e-a8db-1888678e4528";
static NSString* const c_typename = @"file";

static NSString* const c_element_name = @"name";
static NSString* const c_element_size = @"size";
static NSString* const c_element_contentType = @"content-type";

@implementation HVFile

@synthesize size = m_size;
@synthesize contentType = m_contentType;

-(NSString *)name
{
    return (m_name) ? m_name.value : nil;
}

-(void)setName:(NSString *)name
{
    HVENSURE(m_name, HVString255);
    m_name.value = name;
}

-(void)dealloc
{
    [m_name release];
    [m_contentType release];
    
    [super dealloc];
}

-(NSString *)toString
{
    return self.name;
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *)sizeAsString
{
    return [HVFile sizeAsString:m_size];
}

+(NSString *)sizeAsString:(long)size
{
    if (size < 1024)
    {
        return [NSString localizedStringWithFormat:@"%d %@", (int)size, NSLocalizedString(@"bytes", @"Size in bytes")];
    }
    
    if (size < (1024 * 1024))
    {
        return [NSString localizedStringWithFormat:@"%.1f %@", ((double) size)/ 1024, NSLocalizedString(@"KB", @"Size in KB")];
    }
    
    return [NSString localizedStringWithFormat:@"%.1f %@", ((double) size)/ (1024 * 1024), NSLocalizedString(@"MB", @"Size in MB")];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_name, HVClientError_InvalidFile);
    HVVALIDATE(m_contentType, HVClientError_InvalidFile);
    
    HVVALIDATE_SUCCESS
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_name, c_element_name);
    HVSERIALIZE_INT(m_size, c_element_size);
    HVSERIALIZE(m_contentType, c_element_contentType);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_name, c_element_name, HVString255);
    HVDESERIALIZE_INT(m_size, c_element_size);
    HVDESERIALIZE(m_contentType, c_element_contentType, HVCodableValue);   
}

+(NSString *)typeID
{
    return c_typeid;
}

+(NSString *) XRootElement
{
    return c_typename;
}

+(HVItem *) newItem
{
    return [[HVItem alloc] initWithType:[HVFile typeID]];
}

+(HVItem *)newItemWithName:(NSString *)name andContentType:(NSString *)contentType
{
    HVItem* item = [self newItem];
    HVCHECK_NOTNULL(item);
    
    HVFile* file = (HVFile *) item.data.typed;
    file.name = name;
    file.contentType = [HVCodableValue fromText:contentType];
        
    return item;
    
LError:
    return item;
}

@end
