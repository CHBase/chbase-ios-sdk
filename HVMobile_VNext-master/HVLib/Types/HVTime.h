//
//  HVTime.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVHour.h"
#import "HVMinute.h"
#import "HVSecond.h"
#import "HVMillisecond.h"

@interface HVTime : HVType
{
@private
    HVHour *m_hours;
    HVMinute *m_minutes;
    HVSecond *m_seconds;
    HVMillisecond *m_milliseconds;
}

//-------------------------
//
// Data
//
//-------------------------
//
// Required
//
@property (readwrite, nonatomic) int hour;              
@property (readwrite, nonatomic) int minute; 
//
// Optional
//
@property (readwrite, nonatomic) int second; 
@property (readwrite, nonatomic) int millisecond;
@property (readonly, nonatomic) BOOL hasSecond;
@property (readonly, nonatomic) BOOL hasMillisecond;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithHour:(int) hour minute:(int) minute;
-(id) initWithHour:(int) hour minute:(int) minute second:(int) second;
-(id) initWithDate:(NSDate *) date;
-(id) initwithComponents:(NSDateComponents *) components;

+(HVTime *) fromHour:(int) hour andMinute:(int)minute;

//-------------------------
//
// Methods
//
//-------------------------
-(NSDateComponents *) toComponents;
-(BOOL) getComponents:(NSDateComponents *) components;

-(BOOL) setWithComponents:(NSDateComponents *) components;
-(BOOL) setWithDate:(NSDate *) date;

-(NSDate *) toDate;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;

@end

@interface HVTimeCollection : HVCollection

-(HVTime *) itemAtIndex:(NSUInteger) index;

@end
