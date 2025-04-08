//
//  HVPersonalImage.m
//  HVLib
//
//
//
#import "HVCommon.h"
#import "HVPersonalImage.h"
#import "HVBlob.h"

static NSString* const c_typeid = @"a5294488-f865-4ce3-92fa-187cd3b58930";
static NSString* const c_typename = @"personal-image";

@implementation HVPersonalImage

+(NSString *)typeID
{
    return c_typeid;
}

+(NSString *) XRootElement
{
    return c_typename;
}

+(HVItem *) newItem
{
    return [[HVItem alloc] initWithType:[HVPersonalImage typeID]];
}

+(HVTask *)updateImage:(NSData *)imageData contentType:(NSString *)contentType forRecord:(HVRecordReference *)record andCallback:(HVTaskCompletion)callback
{
    HVTask* uploadImageTask = nil;
    
    HVCHECK_NOTNULL(imageData);
    HVCHECK_STRING(contentType);
    HVCHECK_NOTNULL(record);
    
    uploadImageTask = [[[HVTask alloc] initWithCallback:callback] autorelease];
    HVCHECK_NOTNULL(uploadImageTask);

    HVGetItemsTask* getExistingTask = [record getItemsForType:[HVPersonalImage typeID] callback:^(HVTask *task) {
       
        HVItem* item = nil;
        @try 
        {
            item = ((HVGetItemsTask *) task).firstItemRetrieved;
        }
        @catch (id exception) 
        {
        }
        
        if (!item)
        {
            item = [[HVPersonalImage newItem] autorelease];
            HVCHECK_OOM(item);
        }
        
        id<HVBlobSource> blobSource = [[HVBlobMemorySource alloc] initWithData:imageData];
        HVCHECK_OOM(blobSource);
        
        HVTask* blobUploadTask = (HVTask *) [item newUploadBlobTask:blobSource forBlobName:c_emptyString contentType:contentType record:record andCallback:^(HVTask *task) {
            
            [task checkSuccess];
        }];
        [blobSource release];
        HVCHECK_OOM(blobUploadTask);
        
        [task.parent setNextTask:blobUploadTask];
        [blobUploadTask release];
        
    } ];
    
    HVCHECK_NOTNULL(getExistingTask);
    
    [uploadImageTask setNextTask:getExistingTask];
    [getExistingTask release];
            
    [uploadImageTask start];
    
    return uploadImageTask;
    
LError:
    [uploadImageTask release];
    return nil;
}

@end
