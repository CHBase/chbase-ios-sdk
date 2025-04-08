//
//  HVUIAlert.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HVBlock.h"

enum HVUIAlertResult 
{
    HVUIAlertCancel = 0,
    HVUIAlertOK = 1
};

@interface HVUIAlert : NSObject <UIAlertViewDelegate>
{
    enum HVUIAlertResult m_result;
    UIAlertView *m_view;
    HVNotify m_callback;
    NSString* m_text;
}

//-------------------------
//
// Properties
//
//-------------------------
@property (readonly, nonatomic) UIAlertView* view;
@property (readonly, nonatomic) enum HVUIAlertResult result;
@property (readonly, nonatomic) NSString* inputText;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithMessage:(NSString *) message callback:(HVNotify) callback;
-(id) initWithTitle:(NSString *) title message:(NSString *) message callback:(HVNotify) callback;
-(id) initWithTitle:(NSString *) title message:(NSString *) message cancelButtonText:(NSString *) cancelText okButtonText:(NSString *) okText callback:(HVNotify) callback;
-(id) initWithInformationalMessage:(NSString *) message;
-(id) initWithTitle:(NSString *) title forInformationalMessage:(NSString *) message;
-(id) initWithTitle:(NSString *) title forInformationalMessage:(NSString *) message withCallback:(HVNotify) callback;

//-------------------------
//
// Methods
//
//-------------------------
-(void) show;

+(HVUIAlert *) showWithMessage:(NSString *) message callback:(HVNotify) callback;
+(HVUIAlert *) showYesNoWithMessage:(NSString *) message callback:(HVNotify) callback;
+(HVUIAlert *) showWithTitle:(NSString *) title message:(NSString *) message callback:(HVNotify) callback;
+(HVUIAlert *) showInformationalMessage:(NSString *) message;
+(HVUIAlert *) showInformationalMessage:(NSString *)message withCallback:(HVNotify) callback;
+(HVUIAlert *) showPromptWithMessage:(NSString *) message callback:(HVNotify) callback;
+(HVUIAlert *) showPromptWithMessage:(NSString *) message defaultText:(NSString *) defaultText andCallback:(HVNotify) callback;

@end
