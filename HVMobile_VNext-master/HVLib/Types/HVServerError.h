//
//  HVServerError.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"

@interface HVServerError : HVType
{
@private
    NSString* m_message;
    NSString* m_context;
    NSString* m_errorInfo;
}

@property (readwrite, nonatomic, retain) NSString* message;
@property (readwrite, nonatomic, retain) NSString* context;
@property (readwrite, nonatomic, retain) NSString* errorInfo;

@end
