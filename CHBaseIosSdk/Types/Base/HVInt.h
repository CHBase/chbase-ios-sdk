//
//  HVInt.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"


//
// A nullable integer
//
@interface HVInt : HVType
{
@protected
    int m_value;
}

@property (readwrite, nonatomic) int value;

-(id) initWith:(int) value;

-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;

+(HVInt *) fromInt:(int) value;

@end
