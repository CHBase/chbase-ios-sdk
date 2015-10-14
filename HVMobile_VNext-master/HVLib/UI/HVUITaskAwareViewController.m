//
//  HVUITaskAwareViewController.m
//  HVLib
//
//
//
//
#import "HVCommon.h"
#import "HVUITaskAwareViewController.h"

@implementation HVUITaskAwareViewController

-(HVTask *)activeTask
{
    return m_activeTask;
}

-(void)setActiveTask:(HVTask *)activeTask
{
    [self cancelActiveTask];
    HVRETAIN(m_activeTask, activeTask);
}

-(BOOL)hasActiveTask
{
    return (m_activeTask && !m_activeTask.isDone);
}

-(void)dealloc
{
    [m_activeTask release];
    [super dealloc];
}

-(void)cancelActiveTask
{
    if (m_activeTask)
    {
        [m_activeTask cancel];
        HVCLEAR(m_activeTask);
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    if ([self isBeingDismissed] || [self isMovingFromParentViewController])
    {
        [self cancelActiveTask];
        [self viewWillClose];
    }
    
    [super viewWillDisappear:animated];
}

-(void)viewWillClose
{
    
}

@end
