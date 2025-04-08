//
//  HVItemCommitErrorHandler.h
//  HVLib
//
//
//
//

#import <Foundation/Foundation.h>
#import "HVItemChange.h"
#import "HVServerResponseStatus.h"

@interface HVItemCommitErrorHandler : NSObject
{
@private
    int m_maxAttemptsPerChange;
}

@property (readwrite, nonatomic, assign) int maxAttemptsPerChange;

-(BOOL) isHaltingException:(id) ex;
-(BOOL) shouldRetryChange:(HVItemChange *) change onException:(id) ex;
-(BOOL) shouldCreateNewItemForConflict:(HVItemChange *) change onException:(id) ex;

-(BOOL) isItemKeyNotFoundException:(id) ex;
-(BOOL) isSerializationException:(id) ex;
-(BOOL) isAccessDeniedException:(id) ex;
-(BOOL) isClientException:(id) ex;

-(BOOL) isHttpException:(id) ex;
-(BOOL) isNetworkError:(id) ex;
-(BOOL) isServerException:(id) ex;
-(BOOL) isServerTokenException:(id) ex;

@end
