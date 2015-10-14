//
//  HVResponseStatus.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVServerError.h"

@interface HVResponseStatus : HVType
{
@private
    int m_code;
    HVServerError* m_error;
}

@property (readwrite, nonatomic) int code;
@property (readwrite, nonatomic, retain) HVServerError* error;
@property (readonly, nonatomic) BOOL hasError;


@end
