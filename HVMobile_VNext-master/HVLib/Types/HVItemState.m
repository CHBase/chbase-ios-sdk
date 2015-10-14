//
//  HVItemState.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVItemState.h"

NSString* const c_itemstate_active = @"Active";
NSString* const c_itemstate_deleted = @"Deleted";

NSString* HVItemStateToString(enum HVItemState state)
{
    NSString* value = nil;
    
    if (state & HVItemStateActive)
    {
        return c_itemstate_active;
    }
    
    if (state & HVItemStateDeleted)
    {
        return c_itemstate_deleted;
    }
    
    return value;
}

enum HVItemState HVItemStateFromString(NSString* value)
{
    if ([NSString isNilOrEmpty:value])
    {
        return HVItemStateNone;
    }
    
    if ([value isEqualToString:c_itemstate_active])
    {
        return HVItemStateActive;
    }
    
    if ([value isEqualToString:c_itemstate_deleted])
    {
        return HVItemStateDeleted;
    }
    
    return HVItemStateNone;
}