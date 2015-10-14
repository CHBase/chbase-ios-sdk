//
//  HVBlobHashInfo.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVBlobHashInfo.h"

static NSString* const c_element_blockSize = @"block-size";
@implementation HVBlobHashAlgorithmParams

@synthesize blockSize = m_blockSize;

-(void)dealloc
{
    [m_blockSize release];
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_OPTIONAL(m_blockSize);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_blockSize, c_element_blockSize);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_blockSize, c_element_blockSize, HVPositiveInt);
}

@end

static NSString* const c_element_algorithm = @"algorithm";
static NSString* const c_element_params = @"params";
static NSString* const c_element_hash = @"hash";

@implementation HVBlobHashInfo

@synthesize params = m_params;

-(NSString *)algorithm
{
    return (m_algorithm) ? m_algorithm.value : nil;
}

-(void)setAlgorithm:(NSString *)algorithm
{
    HVENSURE(m_algorithm, HVStringZ255);
    m_algorithm.value = algorithm;
}

-(NSString *)hash
{
    return (m_hash) ? m_hash.value : nil;
}

-(void)setHash:(NSString *)hash
{
    HVENSURE(m_hash, HVStringNZ512);
    m_hash.value = hash;
}

-(void)dealloc  
{
    [m_algorithm release];
    [m_params release];
    [m_hash release];

    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_algorithm, HVClientError_InvalidBlobInfo);
    HVVALIDATE_OPTIONAL(m_params);
    HVVALIDATE(m_hash, HVClientError_InvalidBlobInfo);
    
    HVVALIDATE_SUCCESS

LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_algorithm, c_element_algorithm);
    HVSERIALIZE(m_params, c_element_params);
    HVSERIALIZE(m_hash, c_element_hash);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_algorithm, c_element_algorithm, HVStringZ255);
    HVDESERIALIZE(m_params, c_element_params, HVBlobHashAlgorithmParams);
    HVDESERIALIZE(m_hash, c_element_hash, HVStringNZ512);
}

@end
