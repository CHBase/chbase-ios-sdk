//
//  HVMessage.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVMessage.h"

static NSString* const c_typeid = @"72dc49e1-1486-4634-b651-ef560ed051e5";
static NSString* const c_typename = @"message";

static const xmlChar* x_element_when = XMLSTRINGCONST("when");
static NSString* const c_element_headers = @"headers";
static const xmlChar* x_element_size = XMLSTRINGCONST("size");
static const xmlChar* x_element_summary = XMLSTRINGCONST("summary");
static const xmlChar* x_element_htmlBlob = XMLSTRINGCONST("html-blob-name");
static const xmlChar* x_element_textBlob = XMLSTRINGCONST("text-blob-name");
static NSString* const c_element_attachments = @"attachments";

@implementation HVMessage

@synthesize when = m_when;
@synthesize headers = m_headers;
@synthesize size = m_size;
@synthesize summary = m_summary;
@synthesize htmlBlobName = m_htmlBlobName;
@synthesize textBlobName = m_textBlobName;
@synthesize attachments = m_attachments;

-(BOOL)hasHeaders
{
    return (![NSArray isNilOrEmpty:m_headers]);
}

-(BOOL)hasAttachments
{
    return (![NSArray isNilOrEmpty:m_attachments]);
}

-(BOOL)hasHtmlBody
{
    return !([NSString isNilOrEmpty:m_htmlBlobName]);
}

-(BOOL)hasTextBody
{
    return !([NSString isNilOrEmpty:m_textBlobName]);
}

-(void)dealloc
{
    [m_when release];
    [m_headers release];
    [m_size release];
    [m_summary release];
    [m_htmlBlobName release];
    [m_textBlobName release];
    [m_attachments release];
    
    [super dealloc];
}

-(NSString *)getFrom
{
    return [self getValueForHeader:@"From"];
}

-(NSString *)getTo
{
    return [self getValueForHeader:@"To"];
}

-(NSString *)getSubject
{
    return [self getValueForHeader:@"Subject"];
}

-(NSString *)getCC
{
    return [self getValueForHeader:@"CC"];    
}

-(NSString *)getMessageDate
{
    return [self getValueForHeader:@"Date"];
}

-(NSString *)getValueForHeader:(NSString *)name
{
    if (!self.hasHeaders)
    {
        return nil;
    }
    
    HVMessageHeaderItem* header = [m_headers headerWithName:name];
    if (!header)
    {
        return c_emptyString;
    }
    return header.value;
}

-(NSDate *)getDate
{
    return [m_when toDate];
}

-(NSDate *)getDateForCalendar:(NSCalendar *)calendar
{
    return [m_when toDateForCalendar:calendar];    
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_when, HVClientError_InvalidMessage);
    HVVALIDATE_ARRAYOPTIONAL(m_headers, HVClientError_InvalidMessage);
    HVVALIDATE(m_size, HVClientError_InvalidMessage);
    HVVALIDATE_ARRAYOPTIONAL(m_attachments, HVClientError_InvalidMessage);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_when, x_element_when);
    HVSERIALIZE_ARRAY(m_headers, c_element_headers);
    HVSERIALIZE_X(m_size, x_element_size);
    HVSERIALIZE_STRING_X(m_summary, x_element_summary);
    HVSERIALIZE_STRING_X(m_htmlBlobName, x_element_htmlBlob);
    HVSERIALIZE_STRING_X(m_textBlobName, x_element_textBlob);
    HVSERIALIZE_ARRAY(m_attachments, c_element_attachments);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_when, x_element_when, HVDateTime);
    HVDESERIALIZE_TYPEDARRAY(m_headers, c_element_headers, HVMessageHeaderItem, HVMessageHeaderItemCollection);
    HVDESERIALIZE_X(m_size, x_element_size, HVPositiveInt);
    HVDESERIALIZE_STRING_X(m_summary, x_element_summary);
    HVDESERIALIZE_STRING_X(m_htmlBlobName, x_element_htmlBlob);
    HVDESERIALIZE_STRING_X(m_textBlobName, x_element_textBlob);
    HVDESERIALIZE_TYPEDARRAY(m_attachments, c_element_attachments, HVMessageAttachment, HVMessageAttachmentCollection);
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
    return [[HVItem alloc] initWithType:[HVMessage typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Message", @"Message Type Name");
}

@end
