//
//  XString.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import <libxml/XmlReader.h>

//
// Extensions to NSString for xmlChar* support
//
@interface NSString (XExtensions)
{
}
+(NSString *) newFromXmlString:(xmlChar *) xmlString;
+(NSString *) newFromConstXmlString:(const xmlChar *) xmlString;
+(NSString *) fromXmlString:(xmlChar *) xmlString;
+(NSString *) fromConstXmlString:(const xmlChar *) xmlString;
+(NSString *) fromXmlStringAndFreeXml:(xmlChar *) xmlString;
-(xmlChar *) toXmlString;
-(const xmlChar *) toXmlStringConst;


@end

#define XMLSTRINGCONST(sz) (const xmlChar *) sz