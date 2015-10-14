//
//  HVGetPersonalImageTask.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVAsyncTask.h"
#import "HVRecordReference.h"

@interface HVGetPersonalImageTask : HVTask
{
@private
    HVRecordReference* m_record;
}

@property (readonly, nonatomic) NSData* imageData;

-(id) initWithRecord:(HVRecordReference *) record andCallback:(HVTaskCompletion) callback;

@end
