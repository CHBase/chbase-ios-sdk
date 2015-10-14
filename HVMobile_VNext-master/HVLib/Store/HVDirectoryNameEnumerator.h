//
//  HVDirectoryNameEnumerator.h
//  HVLib
//
//
//
//

#import <Foundation/Foundation.h>

//
// Use this to Shallow Enumerate names in a directory - either file OR directory, but
// never both
//
@interface HVDirectoryNameEnumerator : NSEnumerator
{
@private
    NSDirectoryEnumerator* m_inner;
    BOOL m_listFilesMode;
}

// Passs false if you want to list directories only
-(id)initWithPath:(NSURL *) path inFileMode:(BOOL) filesOnly;

@end
