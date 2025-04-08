//
//  HVAudit.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"

@interface HVAudit : HVType
{
@private
    NSDate* m_when;
    NSString* m_appID;
    NSString* m_action;    
}

@property (readwrite, nonatomic, retain) NSDate* when;
@property (readwrite, nonatomic, retain) NSString* appID;
@property (readwrite, nonatomic, retain) NSString* action;

@end
