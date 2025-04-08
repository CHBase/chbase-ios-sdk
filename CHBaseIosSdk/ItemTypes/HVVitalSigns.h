//
//  HVVitalSigns.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVVitalSigns : HVItemDataTyped
{
@private
    HVDateTime* m_when;
    HVVitalSignResultCollection* m_results;
    NSString* m_site;
    NSString* m_position;
}

//-------------------------
//
// Data
//
//-------------------------
//
// (Required) When the vital sign was taken
//
@property (readwrite, nonatomic, retain) HVDateTime* when;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) HVVitalSignResultCollection* results;
//
// (Optional)
//
@property (readwrite, nonatomic, retain) NSString* site;
@property (readwrite, nonatomic, retain) NSString* position;

@property (readonly, nonatomic) BOOL hasResults;
@property (readonly, nonatomic) HVVitalSignResult* firstResult;

//-------------------------
//
// Initializers
//
//-------------------------

-(id) initWithDate:(NSDate *) date;
-(id) initWithResult:(HVVitalSignResult *) result onDate:(NSDate *) date;

+(HVItem *) newItem;

//-------------------------
//
// Type Info
//
//-------------------------

+(NSString *) typeID;
+(NSString *) XRootElement;

@end
