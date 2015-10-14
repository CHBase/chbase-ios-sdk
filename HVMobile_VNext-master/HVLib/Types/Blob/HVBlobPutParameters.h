//
//  HVBlobPutParameters.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"

@interface HVBlobHashAlgorithmParameters : HVType
{
@private
    int m_blockSize;
}

@property (readwrite, nonatomic) int blockSize;

@end

@interface HVBlobPutParameters : HVType
{
@private
    NSString* m_url;
    int m_chunkSize;
    int m_maxSize;
    NSString* m_hashAlgorithm;
    HVBlobHashAlgorithmParameters* m_hashParams;
}

@property (readwrite, nonatomic, retain) NSString* url;
@property (readwrite, nonatomic) int chunkSize;
@property (readwrite, nonatomic) int maxSize;
@property (readwrite, nonatomic, retain) NSString* hashAlgorithm;
@property (readwrite, nonatomic, retain) HVBlobHashAlgorithmParameters* hashParams;


@end
