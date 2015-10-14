//
//  HVException.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVClientResult.h"

@interface HVClientException : NSException
{
    HVClientResult* m_details;
}

@property (readwrite, nonatomic, retain) HVClientResult* details;

+(void) throwExceptionWithError:(HVClientResult *) error;

@end

