//
//  HVDouble.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"

// A nullable double
@interface HVDouble : HVType
{
@protected
    double m_value;
}

@property (readwrite, nonatomic) double value;

-(id) initWith:(double) value;

-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;

@end
