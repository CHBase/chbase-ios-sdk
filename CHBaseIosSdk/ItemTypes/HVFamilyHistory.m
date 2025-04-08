//
//  HVFamilyHistory.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVFamilyHistory.h"

static NSString* const c_typeid = @"4a04fcc8-19c1-4d59-a8c7-2031a03f21de";
static NSString* const c_typename = @"family-history";

static NSString* const c_element_condition = @"condition";
static NSString* const c_element_relative = @"relative";

@implementation HVFamilyHistory

@synthesize relative = m_relative;

-(HVConditionEntryCollection *)conditions
{
    HVENSURE(m_conditions, HVConditionEntryCollection);
    return m_conditions;
}

-(void)setConditions:(HVConditionEntryCollection *)conditions
{
    HVRETAIN(m_conditions, conditions);
}

-(BOOL)hasConditions
{
    return ![NSArray isNilOrEmpty:m_conditions];
}

-(HVConditionEntry *)firstCondition
{
    return (self.hasConditions) ? [m_conditions objectAtIndex:0] : nil;
}

-(NSString *)toString
{
    if (!self.hasConditions)
    {
        return c_emptyString;
    }
    
    if (m_conditions.count == 1)
    {
        return [[m_conditions objectAtIndex:0] toString];
    }
    
    NSMutableString* output = [[[NSMutableString alloc] init] autorelease];
    for (NSUInteger i = 0, count = m_conditions.count; i < count; ++i)
    {
        if (i > 0)
        {
            [output appendString:@","];
        }
        [output appendString:[[m_conditions objectAtIndex:i] toString]];
    }

    return output;
}

-(NSString *)description
{
    return [self toString];
}

-(void)dealloc
{
    [m_relative release];
    [m_conditions release];
    [super dealloc];
}

-(id)initWithRelative:(HVRelative *)relative andCondition:(HVConditionEntry *)condition
{
    HVCHECK_NOTNULL(relative);
    HVCHECK_NOTNULL(condition);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.relative = relative;

    [self.conditions addObject:condition];
    HVCHECK_NOTNULL(m_conditions);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_OPTIONAL(m_relative);
    HVVALIDATE_ARRAYOPTIONAL(m_conditions, HVClientError_InvalidFamilyHistory);

    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_ARRAY(m_conditions, c_element_condition);
    HVSERIALIZE(m_relative, c_element_relative);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_TYPEDARRAY(m_conditions, c_element_condition, HVConditionEntry, HVConditionEntryCollection);
    HVDESERIALIZE(m_relative, c_element_relative, HVRelative);
}

+(NSString *)typeID
{
    return c_typeid;
}

+(NSString *) XRootElement
{
    return c_typename;
}

+(HVItem *) newItem
{
    return [[HVItem alloc] initWithType:[HVFamilyHistory typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Family History", @"Family History Type Name");
}

@end
