//
//  XNodeType.m
//  HVLib
//
//

#include "XNodeType.h"

NSString* XNodeTypeToString(enum XNodeType type)
{
    switch (type) 
    {
        case XElement:
            return @"Element";
            
        case XEndElement:
            return @"EndElement";
            
        case XAttribute:
            return @"Attribute";
            
        case XText:
            return @"Text";
            
        case XCDATA:
            return @"CDATA";
            
        case XSignificantWhitespace:
            return @"SWhitespace";
            
        case XWhitespace:
            return @"Whitespace";
            
        default:
            break;
    }
    
    return @"Unknown";
}

BOOL XIsTextualNodeType(enum XNodeType type)
{
    switch(type)
    {
        case XText:
        case XCDATA:
        case XAttribute:
            return TRUE;
            
        default:
            break;
    }
    
    return FALSE;
}
