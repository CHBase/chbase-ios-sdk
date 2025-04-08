//
//  HVDownloadItemsTask.m
//  HVLib
//
//
//

#import "HVCommon.h"
#import "HVDownloadItemsTask.h"

@implementation HVDownloadItemsTask

-(BOOL)didKeysDownload
{
    return ![NSArray isNilOrEmpty:m_downloadedKeys];
}

-(NSMutableArray *)downloadedKeys
{
    if (!m_downloadedKeys)
    {
        m_downloadedKeys = [[NSMutableArray alloc] init];
    }
    
    return m_downloadedKeys;
}

-(HVItemKey *)firstKey
{
    return (self.didKeysDownload) ? [m_downloadedKeys objectAtIndex:0] : nil;
}

-(void)dealloc
{
    [m_downloadedKeys release];
    [super dealloc];
}

-(id)initWithCallback:(HVTaskCompletion)callback
{
    self = [super initWithCallback:callback];
    HVCHECK_SELF;
    
    m_downloadedKeys = [[NSMutableArray alloc] init];
    HVCHECK_NOTNULL(m_downloadedKeys);
        
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)recordItemsAsDownloaded:(HVItemCollection *)items
{
    NSMutableArray* keys = self.downloadedKeys;
    self.result = keys;
    
    for (NSUInteger i = 0, count = items.count; i < count; ++i)
    {
        [keys addObject:[items itemAtIndex:i].key];
    }
}

@end
