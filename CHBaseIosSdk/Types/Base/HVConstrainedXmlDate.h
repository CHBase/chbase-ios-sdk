//
//  HVConstrainedXmlDate.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"

@interface HVConstrainedXmlDate : HVType
{
@protected
    NSDate* m_value;
}

@property (readwrite, nonatomic, retain) NSDate* value;

@property (readonly, nonatomic) BOOL isNull;

-(id) initWith:(NSDate *) date;

-(NSString *)toString;
-(NSString *)toStringWithFormat:(NSString *)format;

+(HVConstrainedXmlDate *) fromDate:(NSDate *) date;
+(HVConstrainedXmlDate *) nullDate;

@end
