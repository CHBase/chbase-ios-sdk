//
//  HVSynchronizedTypeDataSource.h
//  HVLib
//
//
//
//

#import <UIKit/UIKit.h>
#import "HVSynchronizedType.h"
#import "HVTypeViewDataSource.h"

@interface HVSynchronizedTypeDataSource : HVItemTableViewDataSource<HVSynchronizedTypeDelegate>
{
@private
    HVSynchronizedType* m_type;
}

@property (readonly, nonatomic) HVSynchronizedType* type;

-(id) initForTable:(UITableView *) table withType:(HVSynchronizedType *) type;

@end
