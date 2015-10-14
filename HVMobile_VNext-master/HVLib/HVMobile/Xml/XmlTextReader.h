//
//  XmlTextReader.h
//  CHBase Mobile Library for iOS
//
//

#import <Foundation/Foundation.h>
#import "XmlElement.h"

/// Reads xml data and creates xml tree.
@interface XmlTextReader : NSObject <NSXMLParserDelegate> {

	/// Xml tree root element.
	XmlElement *_rootElement;

	/// Stack used for creating xml tree.
	NSMutableArray *_elements;
}

/// Reads xml data, creates xml tree.
/// @param xml - xml text to parse.
/// @returns reference to tree root element.
- (XmlElement *)read: (NSString *)xml;

@end
