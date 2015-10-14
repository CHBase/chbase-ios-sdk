//
//  XmlElement.h
//  CHBase Mobile Library for iOS
//
//

#import "XmlElement.h"

@implementation XmlElement

@synthesize name = _name;

@synthesize attributes = _attributes;

@synthesize text = _text;

@synthesize children = _children;

- (void)dealloc {

	self.name = nil;
	self.text = nil;	
	self.children = nil;	
	self.attributes = nil;

	[super dealloc];
}

- (NSArray *)selectNodes: (NSString *)elementname {

	return [self.children valueForKey: elementname];
}

- (XmlElement *)selectSingleNode: (NSString *)elementname at: (NSInteger)position {

	NSArray *children = [self selectNodes: elementname];

	if (children && [children count] > position) {
		
		return [children objectAtIndex: position];
	}

	return nil;
}

- (XmlElement *)selectSingleNode: (NSString *)elementname {
	
	NSArray *parts = [elementname componentsSeparatedByString: @"/"];
	XmlElement *current = self;
	
	for (NSString *part in parts) {
		
		current = [current selectSingleNode: part at: 0];
		
		if (!current) return nil;		
	}
	
	return current;
}

- (NSString *)attrValue: (NSString *)attributename {

	return [self.attributes valueForKey: attributename];
}

@end
