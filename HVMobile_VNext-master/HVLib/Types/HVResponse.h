//
//  HVResponse.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVResponseStatus.h"

@interface HVResponse : HVType
{
@private
    HVResponseStatus* m_status;
    NSString* m_body;
}

@property (readwrite, nonatomic, retain) HVResponseStatus* status;
@property (readwrite, nonatomic, retain) NSString* body;

@property (readonly, nonatomic) BOOL hasError;

@end
