//
//  HVHttpDownload.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVHttp.h"

@interface HVHttpDownload : HVHttp
{
@protected
    NSURLResponse* m_response;
    NSFileHandle* m_file;
    int m_totalBytesWritten;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) - download to this file
//
@property (readwrite, nonatomic, retain) NSFileHandle* file;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithUrl:(NSURL *) url filePath:(NSString *) path andCallback:(HVTaskCompletion) callback;
-(id) initWithUrl:(NSURL *) url fileHandle:(NSFileHandle *) file andCallback:(HVTaskCompletion) callback;

@end
