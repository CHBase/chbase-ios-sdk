//
//  HVWorkerStatus.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVWorkerStatus.h"

@implementation HVWorkerStatus

@synthesize isEnabled = m_isEnabled;
@synthesize isBusy = m_isBusy;

-(id)init
{
    [super init];
    HVCHECK_SELF;
    
    m_isBusy = FALSE;
    m_hasPendingWork = FALSE;
    m_isEnabled = TRUE;
    
    return self;
LError:
    HVALLOC_FAIL;
}

-(BOOL)beginWork
{
    @synchronized(self)
    {
        if (m_isBusy || !m_isEnabled)
        {
            m_hasPendingWork = TRUE;
            return FALSE;
        }
        
        m_isBusy = TRUE;
        return TRUE;
    }
}

-(BOOL)completeWork
{
    @synchronized(self)
    {
        m_isBusy = FALSE;
        BOOL isPending = m_hasPendingWork;
        m_hasPendingWork = FALSE;
        return isPending;
    }
}

-(BOOL)shouldScheduleWork
{
    @synchronized(self)
    {
        if (m_isBusy || !m_isEnabled)
        {
            m_hasPendingWork = TRUE;
            return FALSE;
        }
        
        return TRUE;
    }
}

@end
