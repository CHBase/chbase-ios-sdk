//
//  HVBool.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVBool.h"

@implementation HVBool

@synthesize value = m_value;

-(id) initWith:(BOOL)value
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
    return (m_value) ? @"Yes" : @"No";
}

-(void) serialize:(XWriter *)writer
{
    [writer writeBool:m_value];
}

-(void) deserialize:(XReader *)reader
{
    m_value = [reader readBool];
}

@end
