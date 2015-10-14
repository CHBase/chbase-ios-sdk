//
//  HVDirectoryNameEnumerator.m
//  HVLib
//
//
//
//
#import "HVCommon.h"
#import "HVDirectoryNameEnumerator.h"

@implementation HVDirectoryNameEnumerator

-(id)init
{
    return [self initWithPath:nil inFileMode:TRUE];
}

-(id)initWithPath:(NSURL *) path inFileMode :(BOOL)filesOnly
{
    self = [super init];
    HVCHECK_SELF;

    NSFileManager* fm = [NSFileManager defaultManager];
    
    NSArray* fileProperties = [NSArray arrayWithObjects:NSURLNameKey, NSURLIsDirectoryKey,nil];
    NSDirectoryEnumerator *inner = [fm enumeratorAtURL:path
                                    includingPropertiesForKeys:fileProperties
                                    options:NSDirectoryEnumerationSkipsSubdirectoryDescendants
                                    errorHandler:nil];

    HVCHECK_NOTNULL(inner);
    HVRETAIN(m_inner, inner);
    
    m_listFilesMode = filesOnly;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_inner release];
    [super dealloc];
}

-(id)nextObject
{
    while (TRUE)
    {
        NSURL* pathUrl = [m_inner nextObject];
        if (pathUrl == nil)
        {
            break;
        }
        
        NSString *name;
        [pathUrl getResourceValue:&name forKey:NSURLNameKey error:nil];
        
        NSNumber *isDirectory;
        [pathUrl getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
        
        BOOL isFile = ![isDirectory boolValue];
        if (m_listFilesMode == isFile)
        {
            return name;
        }
    }
    
    return nil;
}

@end
