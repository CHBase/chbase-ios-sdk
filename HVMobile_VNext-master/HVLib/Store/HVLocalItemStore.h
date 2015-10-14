//
//  HVLocalItemStore.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVObjectStore.h"
#import "HVItemStore.h"

@interface HVLocalItemStore : NSObject <HVItemStore>
{
@private
    id<HVObjectStore> m_objectStore;
}

@property (readonly, nonatomic) id<HVObjectStore> objectStore;

-(id) initWithObjectStore:(id<HVObjectStore>) store;

@end
