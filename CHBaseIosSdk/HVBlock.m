//
//  HVBlock.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVBlock.h"

void safeInvokeAction(HVAction action)
{
    if (action)
    {
        @try
        {
            action();
        }
        @catch(id ex)
        {
            [ex log];
        }
    }
}

void safeInvokeActionInMainThread(HVAction action)
{
    NSBlockOperation* op = [NSBlockOperation blockOperationWithBlock:^(void){ 
        @try 
        {
            if (action)
            {
                action();
            }
        }
        @catch (id ex) 
        {
            [ex log];
        }
    }];
    
    @try
    {
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    @catch (id exception)
    {
        [exception log];
    }
}

void safeInvokeActionEx(HVAction action, BOOL useMainThread)
{
    if (useMainThread)
    {
        safeInvokeActionInMainThread(action);
    }
    else
    {
        safeInvokeAction(action);
    }
}

BOOL safeInvokePredicate(HVPredicate predicate)
{
    if (predicate)
    {
        @try
        {
            return predicate();
        }
        @catch(id ex)
        {
            [ex log];
        }
    }
    
    return FALSE;
}

void safeInvokeNotify(HVNotify notify, id sender)
{
    if (notify)
    {
        @try
        {
            notify(sender);
        }
        @catch(id ex)
        {
            [ex log];
        }
    }
}

BOOL safeInvokeHandler(HVHandler handler, id value)
{
    if (handler)
    {
        @try
        {
            return handler(value);
        }
        @catch(id ex)
        {
            [ex log];
        }
    }
    
    return false;
}