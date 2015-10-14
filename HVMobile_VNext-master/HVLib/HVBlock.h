//
//  HVBlock.h
//  HVLib
//
//

#import <Foundation/Foundation.h>

//--------------------------------------
//
// Standard Lambda definitions
//
//--------------------------------------
typedef void (^HVAction) (void);
typedef BOOL (^HVPredicate) (void);
typedef void (^HVNotify) (id sender);
typedef BOOL (^HVHandler) (id value);
typedef BOOL (^HVFilter) (id value);
typedef id (^HVFunc) (id value);
typedef id (^HVFactory) (id key);


void safeInvokeAction(HVAction action);
void safeInvokeActionInMainThread(HVAction action);
void safeInvokeActionEx(HVAction action, BOOL useMainThread);
BOOL safeInvokePredicate(HVPredicate predicate);
void safeInvokeNotify(HVNotify notify, id sender);
BOOL safeInvokeHandler(HVHandler handler, id value);