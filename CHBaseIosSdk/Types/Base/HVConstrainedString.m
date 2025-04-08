//
//  HVConstrainedString.m
//  HVLib
//


#import "HVCommon.h"
#import "HVConstrainedString.h"

@implementation HVString

@synthesize value = m_value;

-(NSUInteger) length
{
    return (m_value != nil) ? m_value.length : 0;
}

-(id) initWith:(NSString *)value
{
    self = [super init];
    HVCHECK_SELF;
    
    HVRETAIN(m_value, value);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void) dealloc
{
    [m_value release];
    [super dealloc];
}

-(NSString *) description
{
    return m_value;
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_TEXT(m_value);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_TEXT(m_value);
}

@end


@implementation HVConstrainedString

-(NSUInteger) minLength
{
    return 1;
}

-(NSUInteger) maxLength
{
    return INT32_MAX;
}

-(HVClientResult *) validate
{
    HVCHECK_SUCCESS([self validateValue:m_value]);
    
    HVVALIDATE_SUCCESS;
    
LError:
    return HVMAKE_ERROR(HVClientError_ValueOutOfRange);
}

-(BOOL) validateValue:(NSString *)value
{
    int length = (value != nil) ? value.length : 0;
    return (self.minLength <= length && length <= self.maxLength);
}

@end
