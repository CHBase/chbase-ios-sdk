//
//  HVBlobHashInfo.h
//  HVLib
//
//
//
#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVBaseTypes.h"

@interface HVBlobHashAlgorithmParams : HVType
{
@private
    HVPositiveInt* m_blockSize;
}

//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVPositiveInt* blockSize;

@end

@interface HVBlobHashInfo : HVType
{
@private
    HVStringZ255* m_algorithm;
    HVBlobHashAlgorithmParams* m_params;
    HVStringNZ512* m_hash;
}

@property (readwrite, nonatomic, retain) NSString* algorithm;
@property (readwrite, nonatomic, retain) HVBlobHashAlgorithmParams* params;
@property (readwrite, nonatomic, retain) NSString* hash;

@end
