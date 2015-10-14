//
//  HVPersonalImage.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVPersonalImage : HVItemDataTyped

//-------------------------
//
// Initializers
//
//-------------------------

+(HVItem *) newItem;

//-------------------------
//
// Type Info
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;

//
// Upload new personal image
//
+(HVTask *) updateImage:(NSData *) imageData contentType:(NSString *) contentType forRecord:(HVRecordReference *) record andCallback:(HVTaskCompletion) callback;

@end
