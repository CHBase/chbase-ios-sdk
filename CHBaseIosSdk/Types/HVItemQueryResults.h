//
//  HVItemQueryResults.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVItemQueryResult.h"

@interface HVItemQueryResults : HVType
{
    HVItemQueryResultCollection* m_results;
}

//
// You can send multiple queries in a single HVGetItemsTask
// 
@property (readwrite, nonatomic, retain) HVItemQueryResultCollection* results;
@property (readonly, nonatomic) BOOL hasResults;
@property (readonly, nonatomic) HVItemQueryResult* firstResult;

@end
