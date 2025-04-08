//
//  XString.m
//  HVLib
//
//

#import "XString.h"
#import "HVStringExtensions.h"
#import "HVValidator.h"
#import "XException.h"
#import <math.h>

@implementation NSString (XExtensions)

+(NSString *) newFromXmlString:(xmlChar *)xmlString
{
    if (!xmlString)
    {
        return nil;
    }
    
    return [[NSString alloc] initWithCString:(char *) xmlString encoding:NSUTF8StringEncoding];
}

+(NSString *) newFromConstXmlString:(const xmlChar *)xmlString
{
    return [NSString newFromXmlString:(xmlChar *) xmlString];
}

+(NSString *) fromXmlString:(xmlChar *)xmlString
{
    if (!xmlString)
    {
        return nil;
    }
    
    return [NSString stringWithCString:(char *) xmlString encoding:NSUTF8StringEncoding];
}

+(NSString *) fromConstXmlString:(const xmlChar *)xmlString
{
    if (!xmlString)
    {
        return nil;
    }
    return [NSString fromXmlString:(xmlChar *) xmlString];
}

+(NSString *) fromXmlStringAndFreeXml:(xmlChar *)xmlString 
{
    NSString *string = nil;
    
    if (xmlString)
    {
        string = [NSString fromXmlString:xmlString];
        xmlFree(xmlString);
    }
    
    return string;
}

-(xmlChar *) toXmlString
{
    return (xmlChar *) [self UTF8String];
}

-(const xmlChar *) toXmlStringConst
{
    return (const xmlChar *) [self UTF8String];
}

@end

