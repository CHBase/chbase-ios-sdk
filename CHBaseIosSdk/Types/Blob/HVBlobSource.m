//
//  HVBlobSource.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVBlobSource.h"
#import "HVDirectory.h"

//------------------------------
//
// HVBlobMemorySource
//
//------------------------------
@implementation HVBlobMemorySource

-(NSUInteger)length
{
    return m_source.length;
}

-(void)dealloc
{
    [m_source release];
    [super dealloc];
}

-(id)init
{
    return [self initWithData:nil];
}

-(id)initWithData:(NSData *)data
{
    HVCHECK_NOTNULL(data);
    
    self = [super init];
    HVCHECK_SELF;
    
    HVRETAIN(m_source, data);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(NSData *)readStartAt:(int)offset chunkSize:(int)chunkSize
{
    NSRange range = NSMakeRange(offset, chunkSize);
    return [m_source subdataWithRange:range];
}

@end

//------------------------------
//
// HVBlobFileHandleSource
//
//------------------------------
@implementation HVBlobFileHandleSource

-(NSUInteger)length
{
    return m_size;
}

-(id)init
{
    return [self initWithFilePath:nil];
}

-(id)initWithFilePath:(NSString *)filePath
{
    HVCHECK_NOTNULL(filePath);
    
    self = [super init];
    HVCHECK_SELF;
    
    HVRETAIN(m_file, [NSFileHandle fileHandleForReadingAtPath:filePath]);
    HVCHECK_NOTNULL(m_file);
    
    m_size = [[NSFileManager defaultManager] sizeOfFileAtPath:filePath];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_file release];
    [super dealloc];
}

-(NSData *)readStartAt:(int)offset chunkSize:(int)chunkSize
{
    [m_file seekToFileOffset:offset];
    return [m_file readDataOfLength:chunkSize];
}

@end
