//
//  XWriter.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVStringExtensions.h"
#import "XWriter.h"

#define WRITER_ERROR -1


xmlBufferPtr XAllocBuffer(size_t size)
{
    xmlBufferPtr buffer;
    if (size == 0)
    {
        buffer = xmlBufferCreate();
    }
    else
    {
        buffer = xmlBufferCreateSize(size);
    }
    return buffer;
}

xmlTextWriterPtr XAllocTextWriter(xmlBufferPtr buffer)
{
    return xmlNewTextWriterMemory(buffer, 0);
}

xmlTextWriterPtr XAllocFileWriter(NSString* filePath)
{
    return xmlNewTextWriterFilename([filePath UTF8String], FALSE);
}

//---------------------
//
// XWriter
//
//---------------------
@interface XWriter (XPrivate)
-(BOOL) isSuccess:(int) result;
@end

@implementation XWriter

@synthesize context;

-(xmlTextWriterPtr) writer
{
    return m_writer;
}

-(XConverter *) converter
{
    return m_converter;
}

-(id)initWithWriter:(xmlTextWriterPtr)writer buffer:(xmlBufferPtr)buffer andConverter:(XConverter *)converter
{
    HVCHECK_NOTNULL(writer);
    
    self = [super init];
    HVCHECK_SELF;
    
    if (converter)
    {
        HVRETAIN(m_converter, converter);
    }
    else
    {
        m_converter = [[XConverter alloc] init];
        HVCHECK_NOTNULL(m_converter);
    }
    
    m_writer = writer;
    m_buffer = buffer;
    
    return self;
    
LError:
    HVALLOC_FAIL;
    
}

-(id) initWithWriter:(xmlTextWriterPtr)writer buffer:(xmlBufferPtr)buffer
{
    return [self initWithWriter:writer buffer:buffer andConverter:nil];
}

-(id)initWithBufferSize:(size_t)size andConverter:(XConverter *)converter
{
    xmlBufferPtr buffer = NULL;
    xmlTextWriterPtr writer = NULL;
    
    buffer = XAllocBuffer(size);
    HVCHECK_NOTNULL(buffer);
    
    writer = XAllocTextWriter(buffer);
    HVCHECK_NOTNULL(writer);
    
    self = [self initWithWriter:writer buffer:buffer andConverter:converter];
    HVCHECK_SELF;
    
    return self;
    
LError:
    if (writer)
    {
        xmlFreeTextWriter(writer);
    }
    if (buffer)
    {
        xmlBufferFree(buffer);
    }
    
    HVALLOC_FAIL;    
}

-(id) initWithBufferSize:(size_t)size
{
    return [self initWithBufferSize:size andConverter:nil];
}

-(id)initFromFile:(NSString *)filePath andConverter:(XConverter *)converter
{
    xmlTextWriterPtr writer = XAllocFileWriter(filePath);
    HVCHECK_NOTNULL(writer);
    
    self = [self initWithWriter:writer buffer:NULL andConverter:converter];
    HVCHECK_SELF;
    
    return self;
    
LError:
    if (writer)
    {
        xmlFreeTextWriter(writer);
    }
    HVALLOC_FAIL;
    
}

-(id)initFromFile:(NSString *)filePath
{
    return [self initFromFile:filePath andConverter:nil];
}

-(id) init
{
    return [self initWithBufferSize:0];
}

-(void) dealloc
{
    [m_converter release];
    if (m_writer)
    {
        xmlFreeTextWriter(m_writer);
    }
    if (m_buffer)
    {
        xmlBufferFree(m_buffer);
    }
    [super dealloc];
}

-(BOOL) flush
{
    return [self isSuccess:xmlTextWriterFlush(m_writer)];
}

-(BOOL) writeStartDocument
{
    return [self isSuccess:xmlTextWriterStartDocument(m_writer, nil, nil, nil)];
}

-(BOOL) writeEndDocument
{
    return [self isSuccess:xmlTextWriterEndDocument(m_writer)];
}

-(BOOL) writeAttribute:(NSString *)name value:(NSString *)value
{
    HVCHECK_STRING(name);
    HVCHECK_STRING(value);
    
    xmlChar* xmlName = [name toXmlString]; // autoreleased...
    xmlChar* xmlValue = [value toXmlString];
    
    HVCHECK_NOTNULL(xmlName);
    HVCHECK_NOTNULL(xmlValue);
    
    return [self isSuccess:xmlTextWriterWriteAttribute(m_writer, xmlName, xmlValue)];

LError:
    return FALSE;
}

-(BOOL) writeAttribute:(NSString *)name prefix:(NSString *)prefix NS:(NSString *)ns value:(NSString *)value
{
    HVCHECK_STRING(name);
    HVCHECK_STRING(prefix);
    HVCHECK_STRING(ns);
    HVCHECK_STRING(value);
    
    xmlChar* xmlName =[name toXmlString];
    xmlChar* xmlPrefix = [prefix toXmlString];
    xmlChar* xmlNs = [ns toXmlString];
    xmlChar* xmlValue = [value toXmlString];
    
    HVCHECK_NOTNULL(xmlName);
    HVCHECK_NOTNULL(xmlPrefix);
    HVCHECK_NOTNULL(xmlNs);
    HVCHECK_NOTNULL(xmlValue);
    
    return [self isSuccess:xmlTextWriterWriteAttributeNS(m_writer, xmlPrefix, xmlName, xmlNs, xmlValue)];
    
LError:
    return FALSE;
}

-(BOOL)writeAttributeXmlName:(const xmlChar *)xmlName value:(NSString *)value
{
    xmlChar* xmlValue = [value toXmlString];
    return [self isSuccess:xmlTextWriterWriteAttribute(m_writer, xmlName, xmlValue)];
}

-(BOOL)writeAttributeXmlName:(const xmlChar *)xmlName prefix:(const xmlChar *)xmlPrefix NS:(const xmlChar *)xmlNs value:(NSString *)value
{
    xmlChar* xmlValue = [value toXmlString];
    return [self isSuccess:xmlTextWriterWriteAttributeNS(m_writer, xmlPrefix, xmlName, xmlNs, xmlValue)];
}

-(BOOL) writeStartElement:(NSString *)name
{
    HVASSERT_STRING(name);
    
    xmlChar* xmlName = [name toXmlString];
    HVCHECK_NOTNULL(xmlName);
    
    return [self isSuccess:xmlTextWriterStartElement(m_writer, xmlName)];

LError:
    return FALSE;
}

-(BOOL) writeStartElement:(NSString *)name prefix:(NSString *) prefix NS:(NSString *)ns
{
    HVCHECK_STRING(name);
    HVCHECK_STRING(prefix);
    HVCHECK_STRING(ns);

    xmlChar* xmlName =[name toXmlString];
    xmlChar* xmlPrefix = [prefix toXmlString];
    xmlChar* xmlNs = [ns toXmlString];
    
    HVCHECK_NOTNULL(xmlName);
    HVCHECK_NOTNULL(xmlPrefix);
    HVCHECK_NOTNULL(xmlNs);

    return [self isSuccess:xmlTextWriterStartElementNS(m_writer, xmlPrefix, xmlName, xmlNs)];

LError:
    return FALSE;
}

-(BOOL)writeStartElementXmlName:(const xmlChar *)xmlName
{
    return [self isSuccess:xmlTextWriterStartElement(m_writer, xmlName)];
}

-(BOOL)writeStartElementXmlName:(const xmlChar *)xmlName prefix:(const xmlChar *)xmlPrefix NS:(const xmlChar *)xmlNs
{
    return [self isSuccess:xmlTextWriterStartElementNS(m_writer, xmlPrefix, xmlName, xmlNs)];
}

-(BOOL) writeEndElement
{
    return [self isSuccess:xmlTextWriterEndElement(m_writer)];
}

-(BOOL) writeString:(NSString *)value
{
    HVCHECK_STRING(value);
    
    xmlChar* xmlValue = [value toXmlString];
    HVCHECK_NOTNULL(xmlValue);
    
    return [self isSuccess:xmlTextWriterWriteString(m_writer, xmlValue)];

LError:
    return FALSE;
}

-(BOOL) writeRaw:(NSString *)xml
{
    HVCHECK_NOTNULL(xml);
    
    xmlChar* xmlValue = [xml toXmlString];
    HVCHECK_NOTNULL(xmlValue);
    
    return [self isSuccess:xmlTextWriterWriteRaw(m_writer, xmlValue)];
            
LError:
    return FALSE;
}

-(xmlChar *) getXml
{
    [self flush];
    if (m_buffer == nil)
    {
        return nil;
    }
    
    return m_buffer->content;
}

-(size_t) getLength
{
    [self flush];
    if (m_buffer == nil)
    {
        return 0;
    }
    
    return m_buffer->use;
}

-(NSString *) newXmlString
{
    [self flush];
 
    return [[NSString alloc] initWithBytes:m_buffer->content length:m_buffer->use encoding:NSUTF8StringEncoding];
}

@end

//
// Private Methods
//
@implementation XWriter (XPrivate)

-(BOOL) isSuccess:(int) result
{
    if (result == WRITER_ERROR)
    {
        [XException throwException:XExceptionWriterError];
    }
    
    return TRUE;
}

@end

