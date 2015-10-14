//
//  HVMessageHeaderItem.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"

@interface HVMessageHeaderItem : HVType
{
@private
    NSString* m_name;
    NSString* m_value;
}

@property (readwrite, nonatomic, retain) NSString* name;
@property (readwrite, nonatomic, retain) NSString* value;

-(id) initWithName:(NSString *) name value:(NSString *) value;

@end

@interface HVMessageHeaderItemCollection : HVCollection

-(HVMessageHeaderItem *) itemAtIndex:(NSUInteger) index;
-(NSUInteger) indexOfHeaderWithName:(NSString *) name;

-(HVMessageHeaderItem *) headerWithName:(NSString *) name;

@end

