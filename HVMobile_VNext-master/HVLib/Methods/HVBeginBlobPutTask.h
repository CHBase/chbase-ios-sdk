//
//  HVBeginBlobPut.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVMethodCallTask.h"
#import "HVBlobPutParameters.h"

//------------------------------
//
// To push a blob into HealthVault, you must first retrieve a storage URL
// The URL is valid only for a system configured length of time
// 
//------------------------------
@interface HVBeginBlobPutTask : HVMethodCallTask

@property (readonly, nonatomic) HVBlobPutParameters* putParams;

@end
