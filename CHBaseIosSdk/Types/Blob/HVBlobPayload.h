//
//  HVBlobPayload.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVBlobPayloadItem.h"

@interface HVBlobPayload : HVType
{
@private
    HVBlobPayloadItemCollection* m_blobItems;
}

@property (readonly, nonatomic) HVBlobPayloadItemCollection* items;
@property (readonly, nonatomic) BOOL hasItems;

-(HVBlobPayloadItem *) getDefaultBlob;
-(HVBlobPayloadItem *) getBlobNamed:(NSString *) name;
-(NSURL *) getUrlForBlobNamed:(NSString *) name;

-(BOOL) addOrUpdateBlob:(HVBlobPayloadItem *) blob;

@end
