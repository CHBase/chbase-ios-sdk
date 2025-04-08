//
//  HVGetServiceDefinitionTask.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVMethodCallTask.h"
#import "HVServiceDef.h"

//
// Gets the HealthVault Service definition
// When the task completes successfully, it returns a HVServiceDefinition object
//
@interface HVGetServiceDefinitionTask : HVMethodCallTask
{
@private
    HVServiceDefinitionParams* m_params;
}
//
// Request - optional parameters
//
@property (readwrite, nonatomic, retain) HVServiceDefinitionParams* params;

//
// Response - service definition
//
@property (readonly, nonatomic) HVServiceDefinition* serviceDef;

+(HVGetServiceDefinitionTask *) getTopology:(HVTaskCompletion) callback;

@end
