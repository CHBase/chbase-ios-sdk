//
//  HVBlobPayloadItem.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVBlobInfo.h"
#import "HVHttpRequestResponse.h"
#import "HVHttpDownload.h"
#import "HVBlobPutParameters.h"

@interface HVBlobPayloadItem : HVType
{
@private
    HVBlobInfo* m_blobInfo;
    int m_length;
    NSString* m_blobUrl;
    NSString* m_legacyEncoding;
    NSString* m_encoding;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required)
//
@property (readwrite, nonatomic, retain) HVBlobInfo* blobInfo;
//
// (Required)
//
@property (readwrite, nonatomic) int length;
//
// You use THIS URL TO DOWNLOAD THE BLOB
// The download is just plain vanilla HTTP (you can use the wrappers below)
// The Url is valid for a SHORT period of time. See HealthVault service documentation for duration
//
@property (readwrite, nonatomic, retain) NSString* blobUrl;

//
// Convenience properties
//
@property (readonly, nonatomic) NSString* name;
@property (readonly, nonatomic) NSString* contentType;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithBlobName:(NSString *) name contentType:(NSString *) contentType length:(NSInteger) length andUrl:(NSString *) blobUrl;

//-------------------------
//
// Methods
//
//-------------------------
-(HVHttpResponse *) createDownloadTaskWithCallback:(HVTaskCompletion) callback;
-(HVHttpResponse *) downloadWithCallback:(HVTaskCompletion) callback;
-(HVHttpDownload *) downloadToFilePath:(NSString *) path andCallback:(HVTaskCompletion) callback;
-(HVHttpDownload *) downloadToFile:(NSFileHandle *) file andCallback:(HVTaskCompletion) callback;

@end

@interface HVBlobPayloadItemCollection : HVCollection

-(NSUInteger) indexofDefaultBlob;
-(NSUInteger) indexOfBlobNamed:(NSString *) name;

-(HVBlobPayloadItem *) itemAtIndex:(NSUInteger) index;

-(HVBlobPayloadItem *) getDefaultBlob;
-(HVBlobPayloadItem *) getBlobNamed:(NSString *) name;

@end
