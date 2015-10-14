//
//  HVConstrainedXmlDate.m
//  HVLib
//
//
//

#import "HVCommon.h"
#import "HVConstrainedXmlDate.h"

static NSString* const c_maxDate = @"9999-12-31T00:00:00";
static NSString* const c_maxDatePrefix = @"9999";

@implementation HVConstrainedXmlDate

@synthesize value = m_value;

-(BOOL)isNull
{
    return (!m_value);
}

-(id)init
{
    return [self initWith:nil];
}

-(id) initWith:(NSDate *)value
{
    self = [super init];
    HVCHECK_SELF;
    
    if (value)
    {
        HVRETAIN(m_value, value);
    }
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_value release];
    [super dealloc];
}

-(NSString *) description
{
    return [self toString];
}

-(NSString *)toString
{
    return [self toStringWithFormat:@"%d"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    if (!m_value)
    {
        return nil;
    }
    
    return [m_value toStringWithFormat:format];
}

-(void) serialize:(XWriter *)writer
{
    if (m_value)
    {
        [writer writeDate:m_value];
    }
    else
    {
        // Special magic value HV uses to Remove this entry
        [writer writeText:c_maxDate];
    }
}

-(void) deserialize:(XReader *)reader
{
    NSString* text = [reader readString];
    
    if ([NSString isNilOrEmpty:text] || [text hasPrefix:c_maxDatePrefix])
    {
        HVCLEAR(m_value);
        return;
    }

    NSDate* date = nil;
    if ([reader.converter tryString:text toDate:&date] && date)
    {
        HVRETAIN(m_value, date);
    }
}

+(HVConstrainedXmlDate *)fromDate:(NSDate *)date
{
    return [[[HVConstrainedXmlDate alloc] initWith:date] autorelease];
}

+(HVConstrainedXmlDate *)nullDate
{
    return [[[HVConstrainedXmlDate alloc] init] autorelease];
}
@end
