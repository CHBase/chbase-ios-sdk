//
//  HVItemType.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"

@interface HVItemType : HVType
{
@private
    NSString* m_typeID;
    NSString* m_name;
}

@property (readwrite, nonatomic, retain) NSString* typeID;
@property (readwrite, nonatomic, retain) NSString* name;

-(id) initWithTypeID:(NSString *) typeID;

-(BOOL) isType:(NSString *) typeID;

@end
