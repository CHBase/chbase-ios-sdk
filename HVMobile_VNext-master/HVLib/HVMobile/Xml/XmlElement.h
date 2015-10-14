//
//  XmlElement.h
//  CHBase Mobile Library for iOS
//
//

#import <Foundation/Foundation.h>

/// Represents xml tree node.
@interface XmlElement : NSObject {

	/// Element name.
	NSString *_name;	
	
	/// Element inner text.
	NSMutableString *_text;

	/// Element attributes.
	NSMutableDictionary *_attributes;

	/// Element children.
	NSMutableDictionary *_children;
}

/// Gets or sets element name.
@property (retain) NSString *name;

/// Gets or sets element inner text.
@property (retain) NSMutableString *text;

/// Gets or sets element attributes.
@property (retain) NSMutableDictionary *attributes;

/// Gets or sets elements children.
@property (retain) NSMutableDictionary *children;

/// Returns an array of children matching the given element name.
/// @param name - children name.
/// @returns an array of children matching the given element name.
- (NSArray *)selectNodes: (NSString *)name;

/// Returns the child node with the given name 
/// @param name - child name.
/// @returns the first occurrence if there is more than one.
- (XmlElement *)selectSingleNode: (NSString *)name;

/// Returns the nth child with the given name.
/// @param name - child name.
/// @param at - position index (starting from zero).
/// @returns the nth child with the given name.
- (XmlElement *)selectSingleNode: (NSString *)name at: (NSInteger)position;

/// Returns attribute value.
/// @param name - attribute name.
/// @returns attribute value.
- (NSString *)attrValue: (NSString *)name;

@end
