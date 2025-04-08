//
//  HVDouble.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVDouble.h"

@implementation HVDouble

@synthesize value = m_value;

-(id) initWith:(double) value
{
    self = [super init];
    HVCHECK_SELF;
    
    m_value = value;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(NSString *) description
{
    return [self toString];
}

-(NSString *)toString
{
    return [self toStringWithFormat:@"%f"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, m_value];
}

-(void) serialize:(XWriter *)writer
{
    [writer writeDouble:m_value];
}

-(void) deserialize:(XReader *)reader
{
    m_value = [reader readDouble];
}

@end
