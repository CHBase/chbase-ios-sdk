//
//  HVTypeViewRefresher.h
//  HVLib
//
//
//
//

#import <Foundation/Foundation.h>
#import "HVTypeView.h"

//
// Efficiently refreshes multiple HVTypeViews with minimal round trips.
// Only views that are:
//  - Stale
//  - Don't have pending changes
//
@interface HVMultipleTypeViewRefresher : NSObject
{
@private
    HVRecordReference* m_record;
    NSMutableDictionary* m_views;
    NSTimeInterval m_maxAge;
}

@property (readwrite, nonatomic) NSTimeInterval maxAge;

//
// Supply an array of objects that adopt the id<HVTypeView> protocol
// Those views that are now stale will be refreshed
//
-(id) initWithRecord:(HVRecordReference *) record views:(NSArray *) views andMaxAge:(NSTimeInterval) age;
-(id) initWithRecordStore:(HVLocalRecordStore *) store synchronizedTypeIDs:(NSArray *) typeIDs andMaxAge:(NSTimeInterval) age;
//
// Returns nil if no refresh was triggered. Else returns a task object
//
-(HVTask *) refreshWithCallback:(HVTaskCompletion) callback;

@end
