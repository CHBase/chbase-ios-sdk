#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVAppSpecificInformation : HVItemDataTyped
{
@private
    NSString* m_formatAppid;
    NSString* m_formatTag;
    HVDateTime* m_when;
    NSString* m_summary;
    NSString* m_xml;
}

@property (readwrite, nonatomic, retain) NSString* formatAppid;
@property (readwrite, nonatomic, retain) NSString* formatTag;
@property (readwrite, nonatomic, retain) HVDateTime* when;
@property (readwrite, nonatomic, retain) NSString* summary;
@property (readwrite, nonatomic, retain) NSString* xml;

+(NSString *) typeID;
+(NSString *) XRootElement;
+(HVItem *) newItem;
@end