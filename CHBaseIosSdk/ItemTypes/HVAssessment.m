//
//  HVAssessment.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVAssessment.h"

static NSString* const c_typeid = @"58fd8ac4-6c47-41a3-94b2-478401f0e26c";
static NSString* const c_typename = @"health-assessment";

static NSString* const c_element_when = @"when";
static NSString* const c_element_name = @"name";
static NSString* const c_element_category = @"category";
static NSString* const c_element_result = @"result";

@implementation HVAssessment

@synthesize when = m_when;
@synthesize name = m_name;
@synthesize category = m_category;

-(HVAssessmentFieldCollection *)results
{
    HVENSURE(m_results, HVAssessmentFieldCollection);
    return m_results;
}

-(void)setResults:(HVAssessmentFieldCollection *)results
{
    HVRETAIN(m_results, results);
}

-(void)dealloc
{
    [m_when release];
    [m_name release];
    [m_category release];
    [m_results release];
    
    [super dealloc];
}

-(NSDate *)getDate
{
    return [m_when toDate];
}

-(NSDate *)getDateForCalendar:(NSCalendar *)calendar
{
    return [m_when toDateForCalendar:calendar];
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    return m_name ? m_name : c_emptyString;
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_when, HVClientError_InvalidAssessment);
    HVVALIDATE_STRING(m_name, HVClientError_InvalidAssessment);
    HVVALIDATE(m_category, HVClientError_InvalidAssessment);
    HVVALIDATE_ARRAY(m_results, HVClientError_InvalidAssessment);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_when, c_element_when);
    HVSERIALIZE_STRING(m_name, c_element_name);
    HVSERIALIZE(m_category, c_element_category);
    HVSERIALIZE_ARRAY(m_results, c_element_result);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_when, c_element_when, HVDateTime);
    HVDESERIALIZE_STRING(m_name, c_element_name);
    HVDESERIALIZE(m_category, c_element_category, HVCodableValue);
    HVDESERIALIZE_TYPEDARRAY(m_results, c_element_result, HVAssessmentField, HVAssessmentFieldCollection);
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
    return [[HVItem alloc] initWithType:[HVAssessment typeID]];
}

@end
