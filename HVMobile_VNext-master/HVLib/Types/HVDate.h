//
//  HVDate.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVDay.h"
#import "HVMonth.h"
#import "HVYear.h"

@interface HVDate : HVType
{
@protected
    HVYear  *m_year;
    HVMonth *m_month;
    HVDay   *m_day;
}

//-------------------------
//
// Data
//
//-------------------------
@property (readwrite, nonatomic) int year;
@property (readwrite, nonatomic) int month;
@property (readwrite, nonatomic) int day;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithYear:(int) year month:(int) monthValue day:(int) dayValue;
-(id) initNow;
-(id) initWithDate:(NSDate *) date;
-(id) initWithComponents:(NSDateComponents *) components;

+(HVDate *) fromYear:(int) year month:(int) month day:(int) day;
+(HVDate *) fromDate:(NSDate *) date;
+(HVDate *) now;

//-------------------------
//
// Methods
//
//-------------------------
-(NSDateComponents *) toComponents;
-(NSDateComponents *) toComponentsForCalendar:(NSCalendar *) calendar;
-(BOOL) getComponents:(NSDateComponents *) components;
-(NSDate *) toDate;
-(NSDate *) toDateForCalendar:(NSCalendar *) calendar;

-(BOOL) setWithDate:(NSDate *) date;
-(BOOL) setWithComponents:(NSDateComponents *) components;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;

@end
