#import "HVCommon.h"
#import "HVClient.h"
#import "HVMedicationFill.h"

static NSString* const c_typeid = @"167ecf6b-bb54-43f9-a473-507b334907e0";
static NSString* const c_typename = @"medication-fill";

static NSString* const c_element_name = @"name";
static NSString* const c_element_dateFilled = @"date-filled";
static NSString* const c_element_daysSupply = @"days-supply";
static NSString* const c_element_nextRefillDate = @"next-refill-date";
static NSString* const c_element_refillsLeft = @"refills-left";
static NSString* const c_element_pharmacy = @"pharmacy";
static NSString* const c_element_prescriptionNumber = @"prescription-number";
static NSString* const c_element_lotNumber = @"lot-number";

@implementation HVMedicationFill
@synthesize name = m_name;
@synthesize dateFilled = m_dateFilled;
@synthesize daysSupply = m_daysSupply;
@synthesize nextRefillDate = m_nextRefillDate;
@synthesize refillsLeft = m_refillsLeft;
@synthesize pharmacy = m_pharmacy;
@synthesize prescriptionNumber = m_prescriptionNumber;
@synthesize lotNumber = m_lotNumber;

-(void)dealloc
{
    [m_name release];
    [m_dateFilled release];
    [m_daysSupply release];
    [m_nextRefillDate release];
    [m_refillsLeft release];
    [m_pharmacy release];
    [m_prescriptionNumber release];
    [m_lotNumber release];
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    HVVALIDATE_SUCCESS
LError:
    HVVALIDATE_FAIL
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE(m_name, c_element_name);
    HVSERIALIZE(m_dateFilled, c_element_dateFilled);
    HVSERIALIZE(m_daysSupply, c_element_daysSupply);
    HVSERIALIZE(m_nextRefillDate, c_element_nextRefillDate);
    HVSERIALIZE(m_refillsLeft, c_element_refillsLeft);
    HVSERIALIZE(m_pharmacy, c_element_pharmacy);
    HVSERIALIZE_STRING(m_prescriptionNumber, c_element_prescriptionNumber);
    HVSERIALIZE_STRING(m_lotNumber, c_element_lotNumber);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_name, c_element_name, HVCodableValue);
    HVDESERIALIZE(m_dateFilled, c_element_dateFilled, HVApproxDateTime);
    HVDESERIALIZE(m_daysSupply, c_element_daysSupply, HVPositiveInt);
    HVDESERIALIZE(m_nextRefillDate, c_element_nextRefillDate, HVDate);
    HVDESERIALIZE(m_refillsLeft, c_element_refillsLeft, HVNonNegativeInt);
    HVDESERIALIZE(m_pharmacy, c_element_pharmacy, HVOrganization);
    HVDESERIALIZE_STRING(m_prescriptionNumber, c_element_prescriptionNumber);
    HVDESERIALIZE_STRING(m_lotNumber, c_element_lotNumber);
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
    return [[HVItem alloc] initWithType:[HVMedicationFill typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"MedicationFill", @"MedicationFill");
}

@end