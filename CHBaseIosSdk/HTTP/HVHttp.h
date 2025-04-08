//
//  HVHttp.h
//  HVLib
//
//
//
#import <Foundation/Foundation.h>
#import "HVAsyncTask.h"

@interface HVHttpException : NSException
{
    NSError* m_error;
    int m_statusCode;
}

-(id) initWithError:(NSError *) error;
-(id) initWithStatusCode:(int) statusCode;

@property (readonly, nonatomic) NSError* error;
@property (readonly, nonatomic) int statusCode;


@end

@interface NSMutableURLRequest (HVURLRequestExtensions)

-(void) setContentLength:(NSUInteger) length;
-(void) setContentRangeStart:(NSUInteger) start end:(NSUInteger) end;
-(void) setContentType:(NSString *) type;
-(void) setGzipCompression;

@end

//-------------------------
//
// Async Http Task
//
//-------------------------
@class HVHttp;

@protocol HVHttpDelegate <NSObject>

-(void) totalBytesWritten:(NSInteger) byteCount;

@end

@interface HVHttp : HVTask <NSURLConnectionDataDelegate>
{
@protected
    NSMutableURLRequest* m_request;
    NSURLConnection* m_connection;
    NSInteger m_maxAttempts;
    NSInteger m_currentAttempt;
    
    id<HVHttpDelegate> m_delegate; // Loose reference
}

@property (readonly, nonatomic) NSMutableURLRequest* request;
@property (readonly, nonatomic) NSURLConnection* connection;

@property (readwrite, nonatomic) NSInteger maxAttempts;
@property (readonly, nonatomic) NSInteger currentAttempt;

@property (readwrite, nonatomic, assign) id<HVHttpDelegate> delegate;

-(id) initWithUrl:(NSURL *) url andCallback:(HVTaskCompletion) callback;
-(id) initWithVerb:(NSString *) verb url:(NSURL *) url andCallback:(HVTaskCompletion) callback;

@end

