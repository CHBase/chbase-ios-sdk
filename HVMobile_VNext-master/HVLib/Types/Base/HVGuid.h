//
//  HVGuid.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import "HVType.h"

@interface HVGuid : HVType
{
@private
    CFUUIDRef m_guid;
}

@property (readwrite, nonatomic) CFUUIDRef value;
@property (readonly, nonatomic) BOOL hasValue;

-(id) initWithNewGuid;
-(id) initWithGuid:(CFUUIDRef) guid;
-(id) initFromString:(NSString *) string;

@end

CFUUIDRef newGuidCreate(void);
NSString* guidString(void);
CFUUIDRef parseGuid(NSString *string);
NSString* guidToString(CFUUIDRef guid);