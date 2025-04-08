//
//  HVBlobPayload.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVBlobPayload.h"

static NSString* const c_element_blob = @"blob";

@implementation HVBlobPayload

-(HVBlobPayloadItemCollection *) items
{
    HVENSURE(m_blobItems, HVBlobPayloadItemCollection);
    return m_blobItems;
}

-(BOOL)hasItems
{
    return ![NSArray isNilOrEmpty:m_blobItems];
}

-(void)dealloc
{
    [m_blobItems release];
    [super dealloc];
}

-(HVBlobPayloadItem *)getDefaultBlob
{
    return [self getBlobNamed:c_emptyString];
}

-(HVBlobPayloadItem *)getBlobNamed:(NSString *)name
{
    if (!self.hasItems)
    {
        return nil;
    }
    
    return [m_blobItems getBlobNamed:name];
}

-(NSURL *)getUrlForBlobNamed:(NSString *)name
{
    HVBlobPayloadItem* blob = [self getBlobNamed:name];
    if (!blob)
    {
        return nil;
    }
    
    return [NSURL URLWithString:blob.blobUrl];
}

-(BOOL)addOrUpdateBlob:(HVBlobPayloadItem *)blob
{
    HVCHECK_NOTNULL(blob);
    
    if (m_blobItems)
    {
        NSUInteger existingIndex = [m_blobItems indexOfBlobNamed:blob.name];
        if (existingIndex != NSNotFound)
        {
            [m_blobItems removeObjectAtIndex:existingIndex];
        }
    }
    
    HVENSURE(m_blobItems, HVBlobPayloadItemCollection);
    HVCHECK_NOTNULL(m_blobItems);
    
    [m_blobItems addObject:blob];
    
    return TRUE;
    
LError:
    return FALSE;
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_ARRAY(m_blobItems, HVClientError_InvalidBlobInfo);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_ARRAY(m_blobItems, c_element_blob);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_TYPEDARRAY(m_blobItems, c_element_blob, HVBlobPayloadItem, HVBlobPayloadItemCollection);
}

@end
