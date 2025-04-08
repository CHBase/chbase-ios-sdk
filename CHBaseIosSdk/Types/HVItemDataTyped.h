//
//  ItemDataTyped.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"

@class HVTypeSystem;

//-------------------------
//
// All Objective C equivalents of HealthVault types inherit
// from HVItemDataTyped
//
//-------------------------
@interface HVItemDataTyped : HVType

//-------------------------
//
// Data
//
//-------------------------
@property (readonly, nonatomic) NSString* rootElement;
@property (readonly, nonatomic) NSString* type;
//
// Some types may contain RAW xml that requires further parsing
// e.g. CCR & CCD
//
@property (readonly, nonatomic) BOOL hasRawData;
@property (readonly, nonatomic) BOOL isSingleton;

-(NSDate *) getDate;
-(NSDate *) getDateForCalendar:(NSCalendar *) calendar;

+(NSString *) typeID;
+(NSString *) XRootElement;
-(NSString *) typeName;

+(BOOL) isSingletonType;

@end

//-------------------------
//
// Object that maps HealthVault type information to Objective-C
//
//-------------------------
@interface HVTypeSystem : NSObject 
{
@private
    NSMutableDictionary* m_types;
    NSMutableDictionary* m_ids;
}

+(HVTypeSystem *) current;

-(HVItemDataTyped *) newFromTypeID:(NSString*) typeID;
-(Class) getClassForTypeID:(NSString *) typeID;
-(NSString *) getTypeIDForClassName:(NSString *) name;
-(BOOL) addClass:(Class) class forTypeID:(NSString *) typeID;

@end