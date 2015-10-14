//
//  HVItemDateAndKey.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVTypeViewItem : HVItemKey
{
    NSDate* m_date;
    BOOL m_isLoadPending;
}

@property (readonly, nonatomic, retain) NSDate* date;
@property (readwrite, nonatomic) BOOL isLoadPending;

-(id) initWithDate:(NSDate *) date andID:(NSString*) itemID;
-(id) initWithItem:(HVTypeViewItem *) item;
-(id) initWithHVItem:(HVItem *) item;
-(id) initWithPendingItem:(HVPendingItem *) pendingItem;

-(NSComparisonResult) compareToItem:(HVTypeViewItem *) other;  //sorts Descending
-(NSComparisonResult) compareItemID:(HVTypeViewItem *) other;

+(NSComparisonResult) compare:(id) x to:(id) y;
+(NSComparisonResult) compareItem:(HVTypeViewItem *) x to:(HVTypeViewItem *) y;
+(NSComparisonResult) compareID:(id) x to:(id) y;

@end
