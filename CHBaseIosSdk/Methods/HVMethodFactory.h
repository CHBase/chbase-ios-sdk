//
//  HVMethodFactory.h
//  HVLib
//
//
//
//

#import <Foundation/Foundation.h>
#import "HVMethods.h"

//
// You can override the methods here to change, intercept or mock the behavior
// You can then assign your custom object to [HVClient current].methodFactory
// 
@interface HVMethodFactory : NSObject

-(HVGetItemsTask *) newGetItemsForRecord:(HVRecordReference *) record queries:(HVItemQueryCollection *)queries andCallback:(HVTaskCompletion)callback;

-(HVPutItemsTask *) newPutItemsForRecord:(HVRecordReference *) record items:(HVItemCollection *)items andCallback:(HVTaskCompletion)callback;
-(HVRemoveItemsTask *)newRemoveItemsForRecord:(HVRecordReference *) record keys:(HVItemKeyCollection *)keys andCallback:(HVTaskCompletion)callback;

@end

@interface HVMethodFactory (HVMethodFactoryExtensions)

-(HVGetItemsTask *) newGetItemsForRecord:(HVRecordReference *) record query:(HVItemQuery *)query andCallback:(HVTaskCompletion)callback;
-(HVPutItemsTask *) newPutItemForRecord:(HVRecordReference *) record item:(HVItem *) item andCallback:(HVTaskCompletion) callback;

@end
