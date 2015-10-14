//
//  HVInt.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVInt.h"

@implementation HVInt

@synthesize value = m_value;

-(id) initWith:(int)value
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
    return [self toStringWithFormat:@"%d"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, m_value];
}

-(void) serialize:(XWriter *)writer
{
    [writer writeInt:m_value];
}

-(void) deserialize:(XReader *)reader
{
    m_value = [reader readInt];
}

+(HVInt *)fromInt:(int)value
{
    return [[[HVInt alloc] initWith:value] autorelease];
}

@end
