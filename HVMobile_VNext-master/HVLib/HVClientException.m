//
//  HVException.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVClientException.h"
#import "HVCore.h"
#import "HVValidator.h"

static NSString* const c_clientExceptionName = @"HVClientException";

@implementation HVClientException

@synthesize details = m_details;

-(NSString *)description
{
    return m_details.description;
}

+(void) throwExceptionWithError:(HVClientResult *)error
{
    HVClientException* ex = [[[HVClientException alloc] initWithName:c_clientExceptionName reason:c_emptyString userInfo:nil] autorelease];
    ex.details = error;
    
    @throw ex;
}

@end


