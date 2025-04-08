//
//  HVStoredQuery.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "XLib.h"
#import "HVTypes.h"

@interface HVStoredQuery : XSerializableType
{
@private
    HVItemQuery* m_query;
    HVItemQueryResult* m_result;
    NSDate* m_timestamp;
}

@property (readwrite, nonatomic, retain) HVItemQuery* query;
@property (readwrite, nonatomic, retain) HVItemQueryResult* result;
@property (readwrite, nonatomic, retain) NSDate* timestamp;

-(id) initWithQuery:(HVItemQuery *) query;
-(id) initWithQuery:(HVItemQuery *) query andResult:(HVItemQueryResult *) result;

//
// maxAgeInSeconds
//
-(BOOL) isStale:(NSTimeInterval) maxAge;

-(HVTask *) synchronizeForRecord:(HVRecordReference *) record withCallback:(HVTaskCompletion) callback;

@end
