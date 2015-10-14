//
//  HVItemQueryResults.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVItemQueryResults.h"

static NSString* const c_element_result = @"group";

@implementation HVItemQueryResults

@synthesize results = m_results;

-(BOOL) hasResults
{
    return !([NSArray isNilOrEmpty:m_results]);
}

-(HVItemQueryResult *)firstResult
{
    return (self.hasResults) ? [m_results objectAtIndex:0] : nil;
}

-(void) dealloc
{
    [m_results release];
    [super dealloc];
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_ARRAY(m_results, c_element_result);
}

-(void) deserialize:(XReader *)reader
{
     HVDESERIALIZE_TYPEDARRAY(m_results, c_element_result, HVItemQueryResult, HVItemQueryResultCollection);
}

@end
