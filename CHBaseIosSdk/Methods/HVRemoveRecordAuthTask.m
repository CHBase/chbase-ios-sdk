//
//  HVRemoveRecordAuthTask.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVRemoveRecordAuthTask.h"

@implementation HVRemoveRecordAuthTask

-(NSString *)name
{
    return @"RemoveApplicationRecordAuthorization";
}

-(float)version
{
    return 1;
}

-(id)initWithRecord:(HVRecordReference *)record andCallback:(HVTaskCompletion)callback
{
    self = [super initWithCallback:callback];
    HVCHECK_SELF;
    
    self.record = record;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [super dealloc];
}

-(void)prepare
{
    [self ensureRecord];
}

-(void)serializeRequestBodyToWriter:(XWriter *)writer
{
}

-(id)deserializeResponseBodyFromReader:(XReader *)reader
{
    return [reader readInnerXml];
}

@end
