//
//  HVShellInfo.h
//  HVLib
//
//
//
//

#import "HVType.h"

@interface HVShellInfo : HVType
{
@private
    NSString* m_url;
    NSString* m_redirectUrl;
}

@property (readwrite, nonatomic, retain) NSString* url;
@property (readwrite, nonatomic, retain) NSString* redirectUrl;

@end
