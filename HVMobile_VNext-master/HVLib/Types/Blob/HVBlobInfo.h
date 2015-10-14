//
//  HVBlobInfo.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVBaseTypes.h"

@interface HVBlobInfo : HVType
{
@private
    HVStringZ255* m_name;
    HVStringZ1024* m_contentType;    
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Optional). Most blobs are named (like named streams). 
// However, you can have a 'default' blob with no name (empty string)
//
@property (readwrite, nonatomic, retain) NSString* name;
//
// (Optional) MIME type for this blob
//
@property (readwrite, nonatomic, retain) NSString* contentType;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithName:(NSString *) name andContentType:(NSString *) contentType;

@end
