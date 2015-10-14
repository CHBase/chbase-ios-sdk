//
//  HVGetAuthorizedPeopleResults.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVBaseTypes.h"
#import "HVPersonInfo.h"

@interface HVGetAuthorizedPeopleResult : HVType
{
    NSMutableArray* m_persons;
    HVBool* m_moreResults;
}

@property (readwrite, nonatomic, retain) NSMutableArray* persons;
@property (readwrite, nonatomic, retain) HVBool* moreResults;

@end
