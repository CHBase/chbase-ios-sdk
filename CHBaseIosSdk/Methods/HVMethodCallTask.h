//
//  HVMethodCall.h
//  HVLib
//


#import <Foundation/Foundation.h>
#import "HVAsyncTask.h"
#import "XLib.h"
#import "HVServerResponseStatus.h"
#import "HealthVaultRequest.h"
#import "HealthVaultResponse.h"
#import "HVType.h"

@class HVRecordReference;

@interface HVMethodCallTask : HVTask
{
    HVServerResponseStatus* m_status;
    HVRecordReference* m_record;
    
    NSInteger m_attempt;
    BOOL m_useMasterAppID;
}

@property (readonly, nonatomic) NSString* name;
@property (readonly, nonatomic) float version;
@property (readwrite, nonatomic, retain) HVServerResponseStatus* status;
@property (readwrite, nonatomic, retain) HVRecordReference* record;
@property (readwrite, nonatomic) BOOL useMasterAppID;

-(id) initWithCallback:(HVTaskCompletion) callback;

-(void) validateObject:(id) obj;

-(void) prepare;
-(void) serializeRequestBodyToWriter:(XWriter *) writer;
-(id) deserializeResponseBodyFromReader:(XReader *) reader;
-(id) deserializeResponseBodyFromReader:(XReader *)reader asClass:(Class) cls;

-(void) ensureRecord;

@end
