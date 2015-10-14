//
//  HVItemRaw.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVItemRaw : HVItemDataTyped
{
@protected
    NSString* m_root;
    NSString* m_xml;
}

@property (readwrite, nonatomic, retain) NSString* xml;

@end
