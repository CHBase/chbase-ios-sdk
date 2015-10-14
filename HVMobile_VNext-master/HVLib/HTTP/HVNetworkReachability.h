//
//  HVNetworkReachability.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "HVCore.h"

BOOL HVIsHostNetworkReachable(NSString* hostName);

HVDECLARE_NOTIFICATION(HVHostReachabilityNotificationName);

@interface HVHostReachability : NSObject
{
@private
    NSString* m_hostName;
    SCNetworkReachabilityRef m_hostRef;
    SCNetworkReachabilityFlags m_status;
    BOOL m_isMonitoring;
}

-(id) initWithHostName:(NSString *) hostName;
-(id) initWithUrl:(NSURL *) url;

@property(readonly, nonatomic) NSString* hostName;
@property(readonly, nonatomic) SCNetworkReachabilityFlags status;
@property(readonly, nonatomic) BOOL isReachable;
@property(readwrite, nonatomic) BOOL isMonitoring;
//
// Returns 0 if no status detectable
//
-(BOOL) refreshStatus;

-(BOOL) startMonitoring;
-(BOOL) stopMonitoring;
//
// Uses [NSNotificationCenter] to broadcast changes. You are passed a reference to the HVHostReachability that changed
//
-(void) broadcastStatusChange:(SCNetworkConnectionFlags) flags;
//
// Subscribe to network status changes (via) NSNotificationCenter
//
-(void)addObserver:(id)notificationObserver selector:(SEL)notificationSelector;
-(void)removeObserver:(id)notificationObserver;

@end
