//
//  HVCCR.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"
#import "HVItemRaw.h"

@interface HVCCR : HVItemRaw

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
