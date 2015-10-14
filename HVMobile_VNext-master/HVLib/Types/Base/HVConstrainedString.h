//
//  HVConstrainedString.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"

@interface HVString : HVType
{
@protected
    NSString* m_value;
}

@property (readwrite, nonatomic, retain) NSString* value;
@property (readonly, nonatomic) NSUInteger length;

-(id) initWith:(NSString*) value;

@end

@interface HVConstrainedString : HVString

@property (readonly, nonatomic) NSUInteger minLength;
@property (readonly, nonatomic) NSUInteger maxLength;

-(BOOL) validateValue:(NSString *) value;

@end
