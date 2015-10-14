//
//  XNodeType.h
//  HVLib
//
//

#import <Foundation/Foundation.h>

enum XNodeType 
{
    XUnknown = 0,
    XElement = 1,
    XAttribute = 2,
    XText = 3,
    XCDATA = 4,
    XEntityRef = 5,
    XEntityDeclaration = 6,
    XProcessingInstruction = 7,
    XComments = 8,
    XDocument = 9,
    XDocumentType = 10,
    XDocumentFragment = 11,
    XNotation = 12,
    XWhitespace = 13,
    XSignificantWhitespace = 14,
    XEndElement = 15,
    XEndEntity = 16,
    XmlDeclaration = 17
};

NSString* XNodeTypeToString(enum XNodeType type);
BOOL XIsTextualNodeType(enum XNodeType type);