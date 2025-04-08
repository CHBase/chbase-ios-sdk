//
//  HVCholesterol.m
//  HVLib
//


#import "HVCommon.h"
#import "HVCholesterol.h"

static NSString* const c_typeid = @"796c186f-b874-471c-8468-3eeff73bf66e";
static NSString* const c_typename = @"cholesterol-profile";

static NSString* const c_element_when = @"when";
static NSString* const c_element_ldl = @"ldl";
static NSString* const c_element_hdl = @"hdl";
static NSString* const c_element_total = @"total-cholesterol";
static NSString* const c_element_triglycerides = @"triglyceride";

double const c_cholesterolMolarMass = 386.6;  // g/mol
double const c_triglyceridesMolarMass = 885.7; // g/mol

@interface HVCholesterol (HVPrivate)

-(double) cholesterolInMmolPerLiter:(HVPositiveInt *) value;
-(int) cholesterolMgDLFromMmolPerLiter:(double) value;

@end

@implementation HVCholesterol

@synthesize when = m_date;
@synthesize ldl = m_ldl;
@synthesize hdl = m_hdl;
@synthesize total = m_total;
@synthesize triglycerides = m_triglycerides;

-(NSDate *)getDate
{
    return [m_date toDate];
}

-(NSDate *)getDateForCalendar:(NSCalendar *)calendar
{
    return [m_date toDateForCalendar:calendar];
}

-(int)ldlValue
{
    return (m_ldl) ? m_ldl.value : -1;
}

-(void)setLdlValue:(int)ldl
{
    HVENSURE(m_ldl, HVPositiveInt);
    m_ldl.value = ldl;
}

-(int) hdlValue
{
    return (m_hdl) ? m_hdl.value : -1;
}

-(void)setHdlValue:(int)hdl
{
    HVENSURE(m_hdl, HVPositiveInt);
    m_hdl.value = hdl;        
}

-(int) triglyceridesValue
{
    return (m_triglycerides) ? m_triglycerides.value : -1;
}

-(void)setTriglyceridesValue:(int)triglycerides
{
    HVENSURE(m_triglycerides, HVPositiveInt);
    m_triglycerides.value = triglycerides;       
}

-(int)totalValue
{
    return (m_total) ? m_total.value : -1;
}

-(void)setTotalValue:(int)total
{
    HVENSURE(m_total, HVPositiveInt);
    m_total.value = total;
}

-(double)ldlValueMmolPerLiter
{
    return [self cholesterolInMmolPerLiter:m_ldl];
}

-(void)setLdlValueMmolPerLiter:(double)ldlValueMmolPerLiter
{
    self.ldlValue = [self cholesterolMgDLFromMmolPerLiter:ldlValueMmolPerLiter];
}

-(double)hdlValueMmolPerLiter
{
    return [self cholesterolInMmolPerLiter:m_hdl];
}

-(void)setHdlValueMmolPerLiter:(double)hdlValueMmolPerLiter
{
    self.hdlValue = [self cholesterolMgDLFromMmolPerLiter:hdlValueMmolPerLiter];
}

-(double)totalValueMmolPerLiter
{
    return [self cholesterolInMmolPerLiter:m_total];
}

-(void)setTotalValueMmolPerLiter:(double)totalValueMmolPerLiter
{
    self.totalValue = [self cholesterolMgDLFromMmolPerLiter:totalValueMmolPerLiter];
}

-(double)triglyceridesValueMmolPerLiter
{
    return (m_triglycerides) ? (mgDLToMmolPerL(m_triglycerides.value, c_triglyceridesMolarMass)) : NAN;
}

-(void)setTriglyceridesValueMmolPerLiter:(double)triglyceridesValueMmolPerLiter
{
    self.triglyceridesValue = mmolPerLToMgDL(triglyceridesValueMmolPerLiter, c_triglyceridesMolarMass);
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    return [self toStringWithFormat:@"%d/%d"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.ldlValue, self.hdlValue];
}

-(void)dealloc
{
    [m_date release];
    [m_ldl release];
    [m_hdl release];
    [m_total release];
    [m_triglycerides release];
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_date, HVClientError_InvalidCholesterol);
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
    HVSERIALIZE(m_date, c_element_when);
    HVSERIALIZE(m_ldl, c_element_ldl);
    HVSERIALIZE(m_hdl, c_element_hdl);
    HVSERIALIZE(m_total, c_element_total);
    HVSERIALIZE(m_triglycerides, c_element_triglycerides);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_date, c_element_when, HVDate);
    HVDESERIALIZE(m_ldl, c_element_ldl, HVPositiveInt);
    HVDESERIALIZE(m_hdl, c_element_hdl, HVPositiveInt);
    HVDESERIALIZE(m_total, c_element_total, HVPositiveInt);
    HVDESERIALIZE(m_triglycerides, c_element_triglycerides, HVPositiveInt);    
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
    return [[HVItem alloc] initWithType:[HVCholesterol typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Cholesterol", @"Cholesterol Type Name");
}

@end

@implementation HVCholesterol (HVPrivate)

-(double)cholesterolInMmolPerLiter:(HVPositiveInt *)value
{
    if (!value)
    {
        return NAN;
    }
    
    return mgDLToMmolPerL(value.value, c_cholesterolMolarMass);
}

-(int)cholesterolMgDLFromMmolPerLiter:(double)value
{
    return round(mmolPerLToMgDL(value, c_cholesterolMolarMass));
}

@end