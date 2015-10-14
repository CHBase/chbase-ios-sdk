//
//  HVBrowserController.h
//  HVLib
//
//

#import <UIKit/UIKit.h>

@interface HVBrowserController : UIViewController <UIWebViewDelegate>
{
@private
    NSURL* m_target;
    UIWebView* m_webView;
    UIActivityIndicatorView* m_activityView;
}

@property (readwrite, nonatomic, retain) NSURL* target;

@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *webView;

-(BOOL) navigateTo:(NSURL *) url;
-(BOOL) start;
-(BOOL) stop;

-(void) abort;

@end
