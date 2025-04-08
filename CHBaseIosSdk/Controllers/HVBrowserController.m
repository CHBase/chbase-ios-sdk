//
//  HVBrowserController.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVBrowserController.h"
#import <QuartzCore/QuartzCore.h>


#define RGBColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define HVBLUE RGBColor(0, 176, 240)

@interface HVBrowserController (HVPrivate)

-(BOOL) createBrowser;
-(void) releaseBrowser;
-(BOOL) addBackButton;
-(void) backButtonClicked:(id) sender;
-(void) showActivitySpinner;
-(void) hideActivitySpinner;

@end

@implementation HVBrowserController

@synthesize target = m_target;
@synthesize webView = m_webView;

-(void)dealloc
{
    [m_target release];
    [self releaseBrowser];
    [m_activityView release];
    
    [super dealloc];
}

-(BOOL)start
{
    if (m_target)
    {
        return [self navigateTo:m_target];
    }
    
    [self abort];
    
    return FALSE;
}

-(BOOL)stop
{
    if (m_webView)
    {
        [m_webView setDelegate:nil];
        [m_webView stopLoading];
    }
    return TRUE;
}

-(BOOL)navigateTo:(NSURL *)url
{
    HVCHECK_NOTNULL(url);
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    HVCHECK_NOTNULL(request);
    
    [m_webView loadRequest:request];
    [request release];
    
    return TRUE;
    
LError:
    return false;
}

-(void)abort
{
    [self stop];
    
    if(![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:TRUE];
        });
    } else {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}

//-----------------------
//
// WebView Delegate
//
//-----------------------
-(BOOL)webView: (UIWebView *)webView shouldStartLoadWithRequest: (NSURLRequest *)request
navigationType: (UIWebViewNavigationType)navigationType
{
    [self showActivitySpinner];
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideActivitySpinner];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideActivitySpinner];
}

//-----------------------
//
// Controller Stuff
//
//-----------------------

#pragma mark - View lifecycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createBrowser];
    [self addBackButton];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self start];
}

- (void)viewWillDisappear: (BOOL)animated
{
    [self stop];
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self releaseBrowser];
}

-(void)didReceiveMemoryWarning
{
    [self releaseBrowser];
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    switch (interfaceOrientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            return FALSE;
            
        default:
            break;
    }
    
    return TRUE;
}

@end

@implementation HVBrowserController (HVPrivate)

-(BOOL)createBrowser
{
    [self releaseBrowser];
    
    UIView* superView = super.view;
    CGRect frame = superView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    
    m_webView = [[UIWebView alloc] initWithFrame:frame];
    HVCHECK_NOTNULL(m_webView);
    
    m_webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    m_webView.delegate = self;
    
    [superView addSubview:m_webView];
    
    return TRUE;
    
LError:
    return FALSE;
}

-(void)releaseBrowser
{
    if (m_webView)
    {
        [self stop];
        if (m_activityView)
        {
            [m_activityView removeFromSuperview];
        }
        m_webView.delegate = nil;
        [m_webView removeFromSuperview];
    }
    HVCLEAR(m_webView);
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

-(BOOL)addBackButton
{
    self.navigationItem.hidesBackButton = TRUE;
    
    NSString* buttonTitle = NSLocalizedString(@"Back", @"Back button text");
    
    UIBarButtonItem* button = [[[UIBarButtonItem alloc] initWithTitle:buttonTitle style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClicked:)] autorelease];
    HVCHECK_NOTNULL(button);
    
    self.navigationItem.leftBarButtonItem = button;
    
    return TRUE;
    
LError:
    return FALSE;
}

-(void)showActivitySpinner
{
   
}

-(void)backButtonClicked:(id)sender
{
    if (m_webView.canGoBack)
    {
        [m_webView goBack];
    }
    else
    {
        if(![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:TRUE];
            });
        } else {
            [self.navigationController popViewControllerAnimated:TRUE];
        }
    }
}

-(void)hideActivitySpinner
{
}

@end

