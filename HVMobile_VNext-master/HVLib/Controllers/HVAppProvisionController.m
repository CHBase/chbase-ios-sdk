//
//  HVAppProvisionController.m
//  HVLib
//

#import "HVCommon.h"
#import "HVAppProvisionController.h"
#import "HVClient.h"
#import "HVUIAlert.h"

@interface HVAppProvisionController (HVPrivate)

-(BOOL) queryStringHasAppAuthSuccess:(NSString *) qs;
-(NSString *) instanceIDFromQs:(NSString *) qs;

@end

@implementation HVAppProvisionController

@synthesize status = m_status;
@synthesize error = m_error;
@synthesize hvInstanceID = m_hvInstanceID;

-(BOOL)isSuccess
{
    return (m_status == HVAppProvisionSuccess);
}

-(BOOL)hasInstanceID
{
    return ![NSString isNilOrEmpty:m_hvInstanceID];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    HVCHECK_SELF;
    
    self.title = [HVClient current].settings.signInControllerTitle;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(id)initWithAppCreateUrl:(NSURL *)url andCallback:(HVNotify)callback
{
    HVCHECK_NOTNULL(url);
    HVCHECK_NOTNULL(callback);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.target = url;
    
    m_callback = [callback copy];
    HVCHECK_NOTNULL(m_callback);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_error release];
    [m_callback release];
    [m_hvInstanceID release];
    
    [super dealloc];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    safeInvokeNotify(m_callback, self);
}

-(BOOL)webView: (UIWebView *)webView shouldStartLoadWithRequest: (NSURLRequest *)request navigationType: (UIWebViewNavigationType)navigationType 
{
    //Fix for using BankID with the correct CFBundleURLScheme to enable redirection from the
    //BankID application back to the current application. Requires correct configuration in the Info.plist file
    NSString *bankIDPrefix = @"bankid://";
    NSString *bankIDSuffix = @"mg-local%2Fauth%2Fccp10%2Fgrp%2Fthis";
    NSString *nullSuffix = @"redirect=null";
    
    NSString *url = [[request URL] absoluteString];
    
    BOOL bankidIsPresent = [url hasPrefix:bankIDPrefix];
    BOOL nullIsPresent = [url hasSuffix:nullSuffix];
    BOOL unspecifiedIsPresent = [url hasSuffix:bankIDSuffix];
    
    if (bankidIsPresent && (nullIsPresent || unspecifiedIsPresent)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSURL *url = [request URL];
                
                NSArray *bundleURLTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
                
                NSString *defaultURLScheme = @"null";
                
                if(bundleURLTypes && bundleURLTypes.count > 0) {
                    NSDictionary *bundleURL = bundleURLTypes[0];
                    
                    NSArray *URLScheme = [bundleURL objectForKey:@"CFBundleURLSchemes"];
                    NSString *URLSchemeDefinition = [URLScheme objectAtIndex:0];
                    NSLog(@"%@", URLSchemeDefinition);
                    
                    if(URLSchemeDefinition != nil) {
                        defaultURLScheme = URLSchemeDefinition;
                    }
                }
                
                NSString *redirectString = [NSString stringWithFormat:@"redirect=%@://", defaultURLScheme];
                
                NSString *subString = [[[url absoluteString] componentsSeparatedByString:@"redirect="] objectAtIndex:0];
                subString = [subString stringByAppendingString:redirectString];
                url = [NSURL URLWithString:subString];
                
                NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
                NSLog(@"%@", [url absoluteString]);
                
                // reload the request
                [self.webView loadRequest:request];
            });
        });
        return NO;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    
        NSLog(@"App Provisioning Current Url %@", [[request URL] absoluteString]);
        NSString* queryString = [[request URL] query];
        if ([self queryStringHasAppAuthSuccess:queryString])
        {
            m_status = HVAppProvisionSuccess;
            HVRETAIN(m_hvInstanceID, [self instanceIDFromQs:queryString]);
            [self abort];
        }
    });
    
    return TRUE;
}

- (void)webView: (UIWebView *)webView didFailLoadWithError: (NSError *)error
{
    [super webView:webView didFailLoadWithError:error];
    
    if([error code] == -999 ) // || [error code] == 102)
    {
		return;   
    }
    //
    // Check if the user wants to retry...
    //
    NSString* retryMessage = [HVClient current].settings.signinRetryMessage;
    NSString *message = [NSString stringWithFormat:@"%@\r\n%@", [error localizedDescription], retryMessage];
    
    [HVUIAlert showWithMessage:message callback:^(id sender) {
        
        HVUIAlert *alert = (HVUIAlert *) sender;
        if (alert.result == HVUIAlertOK)
        {
            [self start];
        }
        else
        {
            m_status = HVAppProvisionFailed;

            HVRETAIN(m_error, error);
            
            [self abort];
        }
    }];
    
 }

@end

@implementation HVAppProvisionController (HVPrivate)

-(BOOL)queryStringHasAppAuthSuccess:(NSString *)qs
{
    NSRange authSuccess = [qs rangeOfString:@"target=AppAuthSuccess" options:NSCaseInsensitiveSearch];
    return (authSuccess.length > 0);
}

-(NSString *)instanceIDFromQs:(NSString *)qs
{
    NSDictionary* args = [NSDictionary fromArgumentString:qs];
    if ([NSDictionary isNilOrEmpty:args])
    {
        return nil;
    }
    
    return [args objectForKey:@"instanceid"];
}

@end
