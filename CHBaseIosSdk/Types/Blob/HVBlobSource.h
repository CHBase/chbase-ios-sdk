//
//  HVBlobSource.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>

//------------------------------
//
// Blob upload sources
//
//------------------------------

@protocol HVBlobSource <NSObject>

@property (readonly, nonatomic) NSUInteger length;
-(NSData *) readStartAt:(int) offset chunkSize:(int) chunkSize;

@end

@interface HVBlobMemorySource : NSObject <HVBlobSource>
{
    NSData* m_source;
}

-(id) initWithData:(NSData *) data;

@end

@interface HVBlobFileHandleSource : NSObject<HVBlobSource>
{
    NSFileHandle* m_file;
    long m_size;
}

-(id) initWithFilePath:(NSString *) filePath;

@end
