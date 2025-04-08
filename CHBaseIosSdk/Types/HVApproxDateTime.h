//
//  HVApproxDateTime.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVDateTime.h"

//-------------------------
//
// Approximate Date & Time
// It is sometimes difficult to put a precise date & time on a health event.
// Only a textual description of time may be available: 
//  "as a child", "last year", "in high school"
// 
// HealthVault approximate dates let you:
//  - Use a precise date time, if you have it
//  - If not, then you can use a "descriptive" representation
//
//-------------------------
@interface HVApproxDateTime : HVType
{
@private
    NSString* m_descriptive;
    HVDateTime* m_dateTime;
}

//-------------------------
//
// Data
//
//-------------------------
//
// CHOICE: you must specify either a descriptive OR a precise DateTime
// You CANNOT specify both.  
//
@property (readwrite, nonatomic, retain) NSString* descriptive;
@property (readwrite, nonatomic, retain) HVDateTime* dateTime;
//
// Convenience properties
//
@property (readonly, nonatomic) BOOL isStructured;

//-------------------------
//
// Initializers
//
//-------------------------
-(id) initWithDescription:(NSString *) descr;
-(id) initWithDate:(NSDate *) date;
-(id) initWithDateTime:(HVDateTime *) dateTime;
-(id) initNow;

+(HVApproxDateTime *) fromDate:(NSDate *) date;
+(HVApproxDateTime *) fromDescription:(NSString *) descr;
+(HVApproxDateTime *) now;

//-------------------------
//
// Methods
//
//-------------------------
-(NSDate *) toDate;
-(NSDate *) toDateForCalendar:(NSCalendar *) calendar;

//-------------------------
//
// Text
//
//-------------------------
-(NSString *) toString;
-(NSString *) toStringWithFormat:(NSString *) format;


@end
