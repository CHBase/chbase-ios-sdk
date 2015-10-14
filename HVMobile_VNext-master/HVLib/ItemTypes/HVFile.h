//
//  HVFile.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVItemBlobUploadTask.h"

@interface HVFile : HVItemDataTyped
{
@private
    HVString255* m_name;
    int m_size;
    HVCodableValue* m_contentType;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required)
//
@property (readwrite, nonatomic, retain) NSString* name;
//
// (Required)
//
@property (readwrite, nonatomic) int size;
// 
// (Optional)
//
@property (readwrite, nonatomic, retain) HVCodableValue* contentType;

//-------------------------
//
// Initializers
//
//-------------------------

+(HVItem *) newItem;
+(HVItem *) newItemWithName:(NSString *) name andContentType:(NSString *) contentType;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;
//
// size units
// Automatically convers to the right uint - bytes, KB or MB
//
-(NSString *) sizeAsString;
+(NSString *) sizeAsString:(long) size;

//-------------------------
//
// Type Info
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;

@end
