//
//  HVBool.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"

@interface HVBool : HVType
{
@private
    BOOL m_value;
}

@property (readwrite, nonatomic) BOOL value;

-(id) initWith:(BOOL) value; 

@end
