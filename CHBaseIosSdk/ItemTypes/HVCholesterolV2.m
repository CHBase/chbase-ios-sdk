//
//  HVCholesterolV2.m
//  HVLib
//

#import "HVCommon.h"
#import "HVCholesterolV2.h"

static NSString* const c_typeid = @"98f76958-e34f-459b-a760-83c1699add38";
static NSString* const c_typename = @"cholesterol-profile";

static const xmlChar* x_element_when = XMLSTRINGCONST("when");
static const xmlChar* x_element_ldl = XMLSTRINGCONST("ldl");
static const xmlChar* x_element_hdl = XMLSTRINGCONST("hdl");
static const xmlChar* x_element_total = XMLSTRINGCONST("total-cholesterol");
static const xmlChar* x_element_triglycerides = XMLSTRINGCONST("triglyceride");

@implementation HVCholesterolV2

@synthesize when = m_when;
@synthesize ldl = m_ldl;
@synthesize hdl = m_hdl;
@synthesize triglycerides = m_triglycerides;
@synthesize total = m_total;

-(NSDate *)getDate
{
    return [m_when toDate];
}

-(NSDate *)getDateForCalendar:(NSCalendar *)calendar
{
    return [m_when toDateForCalendar:calendar];
}

-(double)ldlValue
{
    return (m_ldl) ? m_ldl.mmolPerLiter : NAN;
}

-(void)setLdlValue:(double)ldl
{
    HVENSURE(m_ldl, HVConcentrationValue);
    m_ldl.mmolPerLiter = ldl;
}

-(double) hdlValue
{
    return (m_hdl) ? m_hdl.mmolPerLiter : NAN;
}

-(void)setHdlValue:(double)hdl
{
    HVENSURE(m_hdl, HVConcentrationValue);
    m_hdl.mmolPerLiter = hdl;
}

-(double) triglyceridesValue
{
    return (m_triglycerides) ? m_triglycerides.mmolPerLiter : NAN;
}

-(void)setTriglyceridesValue:(double)triglycerides
{
    HVENSURE(m_triglycerides, HVConcentrationValue);
    m_triglycerides.mmolPerLiter = triglycerides;
}

-(double)totalValue
{
    return (m_total) ? m_total.mmolPerLiter : NAN;
}

-(void)setTotalValue:(double)totalValue
{
    HVENSURE(m_total, HVConcentrationValue);
    m_total.mmolPerLiter = totalValue;
}

-(double)ldlValueMgDL
{
    return (m_ldl) ? [m_ldl mgPerDL:c_cholesterolMolarMass] : NAN;
}

-(void)setLdlValueMgDL:(double)ldlValueMgDL
{
    HVENSURE(m_ldl, HVConcentrationValue);
    [m_ldl setMgPerDL:ldlValueMgDL gramsPerMole:c_cholesterolMolarMass];
}

-(double)hdlValueMgDL
{
    return (m_hdl) ? [m_hdl mgPerDL:c_cholesterolMolarMass] : NAN;
}

-(void)setHdlValueMgDL:(double)hdlValueMgDL
{
    HVENSURE(m_hdl, HVConcentrationValue);
    [m_hdl setMgPerDL:hdlValueMgDL gramsPerMole:c_cholesterolMolarMass];
}

-(double)triglyceridesValueMgDl
{
    return (m_triglycerides) ? [m_triglycerides mgPerDL:c_triglyceridesMolarMass] : NAN;
}

-(void)setTriglyceridesValueMgDl:(double)triglyceridesMgDl
{
    HVENSURE(m_triglycerides, HVConcentrationValue);
    [m_triglycerides setMgPerDL:triglyceridesMgDl gramsPerMole:c_triglyceridesMolarMass];
}

-(double)totalValueMgDL
{
    return (m_total) ? [m_total mgPerDL:c_cholesterolMolarMass] : NAN;
}

-(void)setTotalValueMgDL:(double)totalValueMgDL
{
    HVENSURE(m_total, HVConcentrationValue);
    [m_total setMgPerDL:totalValueMgDL gramsPerMole:c_cholesterolMolarMass];
}

-(void)dealloc
{
    [m_when release];
    [m_ldl release];
    [m_hdl release];
    [m_triglycerides release];
    [m_total release];
    
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_when, HVClientError_InvalidCholesterol);
    HVVALIDATE_OPTIONAL(m_ldl);
    HVVALIDATE_OPTIONAL(m_hdl);
    HVVALIDATE_OPTIONAL(m_total);
    HVVALIDATE_OPTIONAL(m_triglycerides);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_X(m_when, x_element_when);
    HVSERIALIZE_X(m_ldl, x_element_ldl);
    HVSERIALIZE_X(m_hdl, x_element_hdl);
    HVSERIALIZE_X(m_total, x_element_total);
    HVSERIALIZE_X(m_triglycerides, x_element_triglycerides);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_X(m_when, x_element_when, HVDateTime);
    HVDESERIALIZE_X(m_ldl, x_element_ldl, HVConcentrationValue);
    HVDESERIALIZE_X(m_hdl, x_element_hdl, HVConcentrationValue);
    HVDESERIALIZE_X(m_total, x_element_total, HVConcentrationValue);
    HVDESERIALIZE_X(m_triglycerides, x_element_triglycerides, HVConcentrationValue);
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
    return [[HVItem alloc] initWithType:[HVCholesterolV2 typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Cholesterol", @"Cholesterol Type Name");
}

@end
