//
//  HVMemoryStore.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVObjectStore.h"

//
// Used ONLY for testing and samples. Not supported for other uses
//
@interface HVMemoryStore : NSObject <HVObjectStore>
{
@private
    NSMutableDictionary* m_store;
    NSMutableDictionary* m_metadata;
}

-(void) touchObjectWithKey:(NSString *) key;

@end
