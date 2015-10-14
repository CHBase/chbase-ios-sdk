//
//  HVMulticastDelegate.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVMulticastDelegate.h"

@implementation HVMulticastDelegate

-(id) init
{
    self = [super init];
    HVCHECK_SELF;
    
    m_delegates = [[NSMutableArray alloc] init];
    HVCHECK_NOTNULL(m_delegates);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void) dealloc
{
    [m_delegates release];
    [super dealloc];
}

-(void) subscribe:(id)delegate
{
    if (!delegate)
    {
        return;
    }
    @synchronized(m_delegates)
    {
        [m_delegates addObject:[NSValue valueWithNonretainedObject:delegate]];
    }
}

-(void) unsubscribe:(id)delegate
{
    @synchronized(m_delegates)
    {
        for (int i = 0, count = m_delegates.count; i < count; ++i)
        {
            id d = ((NSValue *)[m_delegates objectAtIndex:i]).nonretainedObjectValue;
            if (delegate == d)
            {
                [m_delegates removeObjectAtIndex:i];
                return;
            }
        }
    }
}

-(void) invoke:(SEL)sel withParam:(id)param
{
    @synchronized(m_delegates)
    {
        for (int i = 0, count = m_delegates.count; i < count; ++i)
        {
            id delegate = ((NSValue *)[m_delegates objectAtIndex:i]).nonretainedObjectValue;
            if ([delegate respondsToSelector:sel])
            {
                [delegate performSelector:sel withObject:param];
            }
        }
    }
}

-(void)invoke:(SEL)sel withParam:(id)param withParam:(id)param2
{
    @synchronized(m_delegates)
    {
        for (int i = 0, count = m_delegates.count; i < count; ++i)
        {
            id delegate = ((NSValue *)[m_delegates objectAtIndex:i]).nonretainedObjectValue;
            if ([delegate respondsToSelector:sel])
            {
                [delegate performSelector:sel withObject:param withObject:param];
            }
        }
    }
}

@end
