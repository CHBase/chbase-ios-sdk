//
//  HVNetworkReachability.m
//  HVLib
//
//
//

#import "HVCommon.h"
#import "HVNetworkReachability.h"

HVDEFINE_NOTIFICATION(HVHostReachabilityNotificationName);

BOOL HVIsHostNetworkReachable(NSString* hostName)
{
    HVCHECK_NOTNULL(hostName);
    
    const char* szHostName = [hostName cStringUsingEncoding:NSUTF8StringEncoding]; // buffer is owned by NSString
    HVCHECK_NOTNULL(szHostName);
    
    SCNetworkReachabilityRef hostRef = SCNetworkReachabilityCreateWithName(NULL, szHostName);
    
    SCNetworkReachabilityFlags networkFlags;
    
    BOOL result = SCNetworkReachabilityGetFlags(hostRef, &networkFlags);
    CFRelease(hostRef);
    
    HVCHECK_TRUE(result);
    
    return ((networkFlags & kSCNetworkFlagsReachable) != 0 &&
            (networkFlags & kSCNetworkFlagsConnectionRequired) == 0
            );
    
LError:
    return FALSE;
}

static void HostReachabilityStatusChanged(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
    @try
    {
        if (info)
        {
            HVHostReachability* host = (HVHostReachability *) info;
            [host broadcastStatusChange:flags];
        }
    }
    @catch (NSException *exception)
    {
        [exception log];
    }
}

@interface HVHostReachability (HVPrivate)

-(BOOL) enableNotifications:(BOOL) enable;
-(BOOL) enableCallback:(BOOL) enable;

@end

@implementation HVHostReachability

@synthesize hostName = m_hostName;
@synthesize status = m_status;
-(BOOL)isReachable
{
    return ((m_status & kSCNetworkFlagsReachable) != 0 &&
            (m_status & kSCNetworkFlagsConnectionRequired) == 0
            );
}
@synthesize isMonitoring = m_isMonitoring;

-(id)initWithUrl:(NSURL *)url
{
    return [self initWithHostName:url.host];
}

-(id)initWithHostName:(NSString *)hostName
{
    HVCHECK_STRING(hostName);
    
    self = [super init];
    HVCHECK_SELF;
    
    HVRETAIN(m_hostName, hostName);

    const char* szHostName = [hostName cStringUsingEncoding:NSUTF8StringEncoding]; // buffer is owned by NSString
    HVCHECK_NOTNULL(szHostName);
    
    m_hostRef = SCNetworkReachabilityCreateWithName(NULL, szHostName);
    HVCHECK_NOTNULL(m_hostRef);
    
    m_status = kSCNetworkFlagsReachable; // Assume the best
    m_isMonitoring = FALSE;
    
    return self;
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [self stopMonitoring];
    
    [m_hostName release];
    if (m_hostRef)
    {
        CFRelease(m_hostRef);
    }
    
    [super dealloc];
}

-(BOOL)refreshStatus
{
    SCNetworkReachabilityFlags status = 0;
    if (!SCNetworkReachabilityGetFlags(m_hostRef, &status))
    {
        return FALSE;
    }
    
    return TRUE;
}

-(BOOL)startMonitoring
{
    if (m_isMonitoring)
    {
        return TRUE;
    }
    
    [self refreshStatus];
    
    HVCHECK_SUCCESS([self enableCallback:TRUE]);
    HVCHECK_SUCCESS([self enableNotifications:TRUE]);
    
    m_isMonitoring = TRUE;
    
    return TRUE;
    
LError:
    return FALSE;
}

-(BOOL)stopMonitoring
{
    if (!m_isMonitoring)
    {
        return TRUE;
    }
    
    HVCHECK_SUCCESS([self enableNotifications:FALSE]);
    HVCHECK_SUCCESS([self enableCallback:FALSE]);
    
    m_isMonitoring = FALSE;
    
    return TRUE;
    
LError:
    return FALSE;
}

-(void)broadcastStatusChange:(SCNetworkConnectionFlags)flags
{
    BOOL shouldNotify = FALSE;
    @synchronized(self)
    {
        shouldNotify = (flags != 0 && m_status != flags);
        m_status = flags;
    }
    if (shouldNotify)
    {
        [[NSNotificationCenter defaultCenter]
         postNotificationName: HVHostReachabilityNotificationName
         object:self
         ];
    }
}

-(void)addObserver:(id)notificationObserver selector:(SEL)notificationSelector
{
    [[NSNotificationCenter defaultCenter]
     addObserver:notificationObserver
     selector:notificationSelector
     name:HVHostReachabilityNotificationName
     object:self];
}

-(void)removeObserver:(id)notificationObserver
{
    [[NSNotificationCenter defaultCenter]
     removeObserver:notificationObserver
     name:HVHostReachabilityNotificationName
     object:self];
}

@end

@implementation HVHostReachability (HVPrivate)

-(BOOL)enableCallback:(BOOL)enable
{
    SCNetworkReachabilityContext context = {0, (void *)(self), NULL, NULL, NULL};
    return (SCNetworkReachabilitySetCallback(m_hostRef, (enable) ? HostReachabilityStatusChanged : NULL, &context));
}

-(BOOL)enableNotifications:(BOOL)enable
{
    CFRunLoopRef runLoop = [[NSRunLoop currentRunLoop] getCFRunLoop];
    if (enable)
    {
        return SCNetworkReachabilityScheduleWithRunLoop(m_hostRef, runLoop, kCFRunLoopDefaultMode);
    }
    
    return SCNetworkReachabilityUnscheduleFromRunLoop(m_hostRef, runLoop, kCFRunLoopDefaultMode);

}

@end