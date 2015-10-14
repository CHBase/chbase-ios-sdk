//
//  DateTime.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVDate.h"
#import "HVTime.h"
#import "HVCodableValue.h"

@interface HVDateTime : HVType
{
@private
    HVDate* m_date;
    HVTime* m_time;
    HVCodableValue* m_timeZone;
}

//-------------------------
//
// Data
//
//-------------------------
//
// Reqired
//
@property (readwrite, nonatomic, retain) HVDate* date;
//
// Optional
//
@property (readwrite, nonatomic, retain) HVTime* time;
@property (readwrite, nonatomic, retain) HVCodableValue *timeZone;

//
// Convenience
//
@property (readonly, nonatomic) BOOL hasTime;
@property (readonly, nonatomic) BOOL hasTimeZone;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithDate:(NSDate *) dateValue;
-(id) initwithComponents:(NSDateComponents *) components;
-(id) initNow;

+(HVDateTime *) now;
+(HVDateTime *) fromDate:(NSDate *) date;

//-------------------------
//
// Methods
//
//-------------------------
-(NSDateComponents *) toComponents;
-(BOOL) getComponents:(NSDateComponents *) components;
-(NSDate *) toDate;
-(NSDate *) toDateForCalendar:(NSCalendar *) calendar;

-(BOOL) setWithDate:(NSDate *) dateValue;
-(BOOL) setWithComponents:(NSDateComponents *) components;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;

@end
