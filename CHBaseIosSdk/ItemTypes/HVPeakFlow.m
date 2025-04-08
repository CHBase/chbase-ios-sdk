//
//  HVPeakFlow.m
//  HVLib
//
//
//
//

#import "HVCommon.h"
#import "HVPeakFlow.h"

static NSString* const c_typeID = @"5d8419af-90f0-4875-a370-0f881c18f6b3";
static NSString* const c_typeName = @"peak-flow";

static const xmlChar* x_element_when = XMLSTRINGCONST("when");
static const xmlChar* x_element_pef = XMLSTRINGCONST("pef");
static const xmlChar* x_element_fev1 = XMLSTRINGCONST("fev1");
static const xmlChar* x_element_fev6 = XMLSTRINGCONST("fev6");
static const xmlChar* x_element_flags = XMLSTRINGCONST("measurement-flags");

@implementation HVPeakFlow

@synthesize when = m_when;
@synthesize peakExpiratoryFlow = m_pef;
@synthesize forcedExpiratoryVolume1 = m_fev1;
@synthesize forcedExpiratoryVolume6 = m_fev6;
@synthesize flags = m_flags;

-(double)pefValue
{
    return (m_pef) ? m_pef.litersPerSecondValue : NAN;
}

-(void)setPefValue:(double)pefValue
{
    if (isnan(pefValue))
    {
        HVCLEAR(m_pef);
    }
    else
    {
        HVENSURE(m_pef, HVFlowValue);
        m_pef.litersPerSecondValue = pefValue;
    }
}

-(id)initWithDate:(NSDate *)when
{
    self = [super init];
    HVCHECK_SELF;
    
    m_when = [[HVApproxDateTime alloc] initWithDate:when];
    HVCHECK_NOTNULL(m_when);
    
    return self;
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_when release];
    [m_pef release];
    [m_fev1 release];
    [m_fev6 release];
    [m_flags release];
    
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

-(NSString *) toString
{
    return [NSString localizedStringWithFormat:@"pef: %@, fev1: %@",
            m_pef ? [m_pef toString] : c_emptyString,
            m_fev1 ? [m_fev1 toString] : c_emptyString
            ];
}

-(NSString *)description
{
    return [self toString];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_when, HVClientError_InvalidPeakFlow);
    HVVALIDATE_OPTIONAL(m_pef);
    HVVALIDATE_OPTIONAL(m_fev1);
    HVVALIDATE_OPTIONAL(m_fev6);
    HVVALIDATE_OPTIONAL(m_flags);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_when, x_element_when);
    HVSERIALIZE_X(m_pef, x_element_pef);
    HVSERIALIZE_X(m_fev1, x_element_fev1);
    HVSERIALIZE_X(m_fev6, x_element_fev6);
    HVSERIALIZE_X(m_flags, x_element_flags);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_when, x_element_when, HVApproxDateTime);
    HVDESERIALIZE_X(m_pef, x_element_pef, HVFlowValue);
    HVDESERIALIZE_X(m_fev1, x_element_fev1, HVVolumeValue);
    HVDESERIALIZE_X(m_fev6, x_element_fev6, HVVolumeValue);
    HVDESERIALIZE_X(m_flags, x_element_flags, HVCodableValue);
}

+(NSString *) typeID
{
    return c_typeID;
}

+(NSString *) XRootElement
{
    return c_typeName;
}

+(HVItem *) newItem
{
    return [[HVItem alloc] initWithType:[HVPeakFlow typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Peak Flow", @"Peak Flow Type Name");
}
@end
