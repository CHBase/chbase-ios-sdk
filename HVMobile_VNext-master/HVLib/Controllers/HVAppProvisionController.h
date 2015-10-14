//
//  HVAppProvisionController.h
//  HVLib
//
//

#import "HVBrowserController.h"
#import "HVClient.h"
#import "HVBlock.h"

@class HVAppProvisionController;

@interface HVAppProvisionController : HVBrowserController
{
@private
    enum HVAppProvisionStatus m_status;
    NSError *m_error;
    HVNotify m_callback;
    NSString* m_hvInstanceID;
}

-(id) initWithAppCreateUrl:(NSURL *) url andCallback:(HVNotify) callback;

@property (readonly, nonatomic) NSError* error;
@property (readonly, nonatomic) enum HVAppProvisionStatus status;
@property (readonly, nonatomic) NSString* hvInstanceID;

@property (readonly, nonatomic) BOOL isSuccess;
@property (readonly, nonatomic) BOOL hasInstanceID;

@end
