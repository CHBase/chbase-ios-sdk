//
//  HVGetServiceDefinitionTask.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVGetServiceDefinitionTask.h"

@implementation HVGetServiceDefinitionTask

@synthesize params = m_params;

-(NSString *)name
{
    return @"GetServiceDefinition";
}

-(float)version
{
    return 2;
}

-(HVServiceDefinition *)serviceDef
{
    return (HVServiceDefinition *) self.result;
}

-(void)dealloc
{
    [m_params release];
    [super dealloc];
}

-(void)prepare
{
    self.useMasterAppID = TRUE;
}

-(void)serializeRequestBodyToWriter:(XWriter *)writer
{
    if (m_params)
    {
        [m_params serialize:writer];
    }
}

-(id)deserializeResponseBodyFromReader:(XReader *)reader
{
    return [super deserializeResponseBodyFromReader:reader asClass:[HVServiceDefinition class]];
}

+(HVGetServiceDefinitionTask *)getTopology:(HVTaskCompletion)callback
{
    HVGetServiceDefinitionTask* task = [[[HVGetServiceDefinitionTask alloc] initWithCallback:callback] autorelease];
    HVCHECK_NOTNULL(task);
    
    HVServiceDefinitionParams* params = [[HVServiceDefinitionParams alloc] init];
    HVCHECK_NOTNULL(params);
    
    [params.sections addObject:@"topology"];
    task.params = params;
    [params release];
    
    [task start];
    
    return task;

LError:
    return nil;
}

@end
