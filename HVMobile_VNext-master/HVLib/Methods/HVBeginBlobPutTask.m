//
//  HVBeginBlobPut.m
//  HVLib
//
//
//

#import "HVCommon.h"
#import "HVBeginBlobPutTask.h"
#import "HVBlobPutParameters.h"

@implementation HVBeginBlobPutTask

-(NSString *)name
{
    return @"BeginPutBlob";
}

-(float)version
{
    return 1;
}

-(void)prepare
{
    [self ensureRecord];
}

-(HVBlobPutParameters *)putParams
{
    return (HVBlobPutParameters *) self.result;
}

-(void)serializeRequestBodyToWriter:(XWriter *)writer
{
    // Empty request body
}

-(id)deserializeResponseBodyFromReader:(XReader *)reader
{
    return [self deserializeResponseBodyFromReader:reader asClass:[HVBlobPutParameters class]];
}
@end
