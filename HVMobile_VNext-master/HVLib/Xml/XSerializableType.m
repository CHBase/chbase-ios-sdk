//
//  XSerializableType.m
//  HVLib
//
//

#import "HVCommon.h"
#import "XSerializableType.h"

@implementation XSerializableType

-(void) serializeAttributes:(XWriter *)writer
{
    
}

-(void) serialize:(XWriter *)writer
{
}

-(void) deserializeAttributes:(XReader *)reader
{
    
}

-(void) deserialize:(XReader *)reader
{
}

-(id)deepCopy
{
    return [self newDeepClone];
}

-(id) newDeepClone
{
    NSString* xml = [self toXmlStringWithRoot:@"clone"];
    HVCHECK_NOTNULL(xml);
    
    return [NSObject newFromString:xml withRoot:@"clone" asClass:[self class]];
    
LError:
    return nil;
}

@end
