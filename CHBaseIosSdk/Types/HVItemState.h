//
//  HVItemState.h
//  HVLib
//
//

#import <Foundation/Foundation.h>

enum HVItemState
{
    HVItemStateNone = 0,
    HVItemStateActive = 1,
    HVItemStateDeleted = 2
};

NSString* HVItemStateToString(enum HVItemState state);
enum HVItemState HVItemStateFromString(NSString* value);