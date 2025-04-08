//
//  HVDirectory.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVObjectStore.h"
#import "XConverter.h"
#import "HVDirectoryNameEnumerator.h"

@interface NSFileManager (HVExtensions) 

-(NSURL *) pathForStandardDirectory:(NSSearchPathDirectory) name;
-(NSURL *) documentDirectoryPath;
-(NSURL *) cacheDirectoryPath;

-(long) sizeOfFileAtPath:(NSString *) path;

+(NSString *) mimeTypeForFile:(NSString *) filePath;
+(NSString *) mimeTypeForFileExtension:(NSString *) ext;
+(NSString *) fileExtForMimeType:(NSString *) mimeType;

@end

@interface NSFileHandle (HVExtensions)

+(NSFileHandle *) createOrOpenForWriteAtPath:(NSString *) path;

-(BOOL) writeText:(NSString *) text;
-(BOOL) appendText:(NSString *) text;

+(NSString *) stringFromFileAtPath:(NSString *) path;

@end

//
// HVDirectory implements all methods in HVObjectStore
// ALL serializable objects must inherit from XSerializableType
//
@interface HVDirectory : NSObject <HVObjectStore>
{
@private
    NSURL *m_path;
    NSString *m_stringPath;
    XConverter* m_converter;  // Cached, to speed up deserialization/serialization
}

@property (readonly, nonatomic) NSURL* url;
@property (readonly, nonatomic) NSString* stringPath;

-(id) initWithPath:(NSURL *) path;
-(id) initWithRelativePath:(NSString *) path;

-(NSURL *) makeChildUrl:(NSString *) name;
-(NSString *) makeChildPath:(NSString *) name;

-(HVDirectory *) newChildNamed:(NSString *) name;

-(NSEnumerator *) getFileNames;
-(NSEnumerator *) getDirectoryNames;

-(BOOL) fileExists:(NSString *) fileName;
-(NSString *) makeFilePathIfExists:(NSString *) fileName;
-(BOOL) createFile:(NSString *) fileName;
-(BOOL) deleteFile:(NSString *) fileName;

+(void) deleteUrl:(NSURL *) url;

-(NSDictionary *) getFileProperties:(NSString *) fileName;
-(BOOL) isFileNamed:(NSString *) name aged:(NSTimeInterval) maxAge;

-(NSFileHandle *) openFileForRead:(NSString *) fileName;
-(NSFileHandle *) openFileForWrite:(NSString *) fileName;

-(id) newObjectWithKey:(NSString *) key name:(NSString *) name andClass:(Class) cls;

@end
