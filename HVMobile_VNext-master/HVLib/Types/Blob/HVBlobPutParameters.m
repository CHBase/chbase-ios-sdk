//
//  HVBlobPutParameters.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVBlobPutParameters.h"

static NSString* const c_element_blockSize = @"block-size";

@implementation HVBlobHashAlgorithmParameters

@synthesize blockSize = m_blockSize;

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_INT(m_blockSize, c_element_blockSize);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_INT(m_blockSize, c_element_blockSize);
}

@end

static NSString* const c_element_url = @"blob-ref-url";
static NSString* const c_element_chunkSize = @"blob-chunk-size";
static NSString* const c_element_maxSize = @"max-blob-size";
static NSString* const c_element_hashAlg = @"blob-hash-algorithm";
static NSString* const c_element_hashParams = @"blob-hash-parameters";

@implementation HVBlobPutParameters

@synthesize url = m_url;
@synthesize chunkSize = m_chunkSize;
@synthesize maxSize = m_maxSize;
@synthesize hashAlgorithm = m_hashAlgorithm;
@synthesize hashParams = m_hashParams;

-(void)dealloc
{
    [m_url release];
    [m_hashAlgorithm release];
    [m_hashParams release];
    
    [super dealloc];
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING(m_url, c_element_url);
    HVSERIALIZE_INT(m_chunkSize, c_element_chunkSize);
    HVSERIALIZE_INT(m_maxSize, c_element_maxSize);
    HVSERIALIZE_STRING(m_hashAlgorithm, c_element_hashAlg);
    HVSERIALIZE(m_hashParams, c_element_hashParams);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING(m_url, c_element_url);
    HVDESERIALIZE_INT(m_chunkSize, c_element_chunkSize);
    HVDESERIALIZE_INT(m_maxSize, c_element_maxSize);
    HVDESERIALIZE_STRING(m_hashAlgorithm, c_element_hashAlg);
    HVDESERIALIZE(m_hashParams, c_element_hashParams, HVBlobHashAlgorithmParameters);    
}

@end
