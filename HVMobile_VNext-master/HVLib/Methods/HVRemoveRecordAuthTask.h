//
//  HVRemoveRecordAuthTask.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVMethodCallTask.h"
#import "HVRecordReference.h"

@interface HVRemoveRecordAuthTask : HVMethodCallTask

-(id) initWithRecord:(HVRecordReference *) record andCallback:(HVTaskCompletion) callback;

@end
