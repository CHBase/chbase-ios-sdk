//
//  HVCCD.h
//  HVLib
//
//
//
#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVItemRaw.h"

@interface HVCCD : HVItemRaw

//-------------------------
//
// Initializers
//
//-------------------------
+(HVItem *) newItem;

//-------------------------
//
// Type info
//
//-------------------------

+(NSString *) typeID;
+(NSString *) XRootElement;

@end
