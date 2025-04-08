//
//  HVMessageAttachment.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"

@interface HVMessageAttachment : HVType
{
@private
    NSString* m_name;
    NSString* m_blobName;
    BOOL m_isInline;
    NSString* m_contentID;
}

@property (readwrite, nonatomic, retain) NSString* name;
@property (readwrite, nonatomic, retain) NSString* blobName;
@property (readwrite, nonatomic) BOOL isInline;
@property (readwrite, nonatomic, retain) NSString* contentID;

-(id) initWithName:(NSString *) name andBlobName:(NSString *) blobName;

@end

@interface HVMessageAttachmentCollection : HVCollection

-(HVMessageAttachment *) itemAtIndex:(NSUInteger) index;

@end
