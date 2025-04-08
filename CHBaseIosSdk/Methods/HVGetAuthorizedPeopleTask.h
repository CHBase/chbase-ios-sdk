//
//  HVGetAuthorizedPeople.h
//  HVLib
//
//

#import "HVMethodCallTask.h"
#import "HVPersonInfo.h"

@interface HVGetAuthorizedPeopleTask : HVMethodCallTask

@property (readonly, nonatomic) NSArray* persons;

@end
