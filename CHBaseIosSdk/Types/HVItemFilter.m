//
//  HVItemFilter.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVItemFilter.h"
#import "HVItemDataTyped.h"

static NSString* const c_element_typeID = @"type-id";
static NSString* const c_element_state = @"thing-state";
static NSString* const c_element_edateMin = @"eff-date-min";
static NSString* const c_element_edateMax = @"eff-date-max";
static NSString* const c_element_cappID = @"created-app-id";
static NSString* const c_element_cpersonID = @"created-person-id";
static NSString* const c_element_uappID = @"updated-app-id";
static NSString* const c_element_upersonID = @"updated-person-id";
static NSString* const c_element_cdateMin = @"created-date-min";
static NSString* const c_element_cdateMax = @"created-date-max";
static NSString* const c_element_udateMin = @"updated-date-min";
static NSString* const c_element_udateMax = @"updated-date-max";
static NSString* const c_element_xpath = @"xpath";

@implementation HVTypeFilter

@synthesize state = m_state;
@synthesize effectiveDateMin = m_eDateMin;
@synthesize effectiveDateMax = m_eDateMax;
@synthesize createdByAppID = m_cAppID;
@synthesize createdByPersonID = m_cPersonID;
@synthesize updatedByAppID = m_uAppID;
@synthesize updatedByPersonID = m_uPersonID;
@synthesize createDateMin = m_cDateMin;
@synthesize createDateMax = m_cDateMax;
@synthesize updateDateMin = m_uDateMin;
@synthesize updateDateMax = m_udateMax;
@synthesize xpath = m_xpath;

-(void) dealloc
{
    [m_eDateMin release];
    [m_eDateMax release];
    [m_cAppID release];
    [m_cPersonID release];
    [m_uAppID release];
    [m_uPersonID release];
    [m_cDateMin release];
    [m_cDateMax release];
    [m_uDateMin release];
    [m_udateMax release];
    [m_xpath release];
    
    [super dealloc];
    
}
-(void) serialize:(XWriter *)writer
{
    if (m_state != HVItemStateNone)
    {
        HVSERIALIZE_ENUM(m_state, c_element_state, HVItemStateToString);
    }
    
    HVSERIALIZE_DATE(m_eDateMin, c_element_edateMin);
    HVSERIALIZE_DATE(m_eDateMax, c_element_edateMax);
    HVSERIALIZE_STRING(m_cAppID, c_element_cappID);
    HVSERIALIZE_STRING(m_cPersonID, c_element_cpersonID);
    HVSERIALIZE_STRING(m_uAppID, c_element_uappID);
    HVSERIALIZE_STRING(m_uPersonID, c_element_upersonID);
    HVSERIALIZE_DATE(m_cDateMin, c_element_cdateMin);
    HVSERIALIZE_DATE(m_cDateMax, c_element_cdateMax);
    HVSERIALIZE_DATE(m_uDateMin, c_element_udateMin);
    HVSERIALIZE_DATE(m_udateMax, c_element_udateMax);
    HVSERIALIZE_STRING(m_xpath, c_element_xpath);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_ENUM(m_state, c_element_state, HVItemStateFromString);
    
    HVDESERIALIZE_DATE(m_eDateMin, c_element_edateMin);
    HVDESERIALIZE_DATE(m_eDateMax, c_element_edateMax);
    HVDESERIALIZE_STRING(m_cAppID, c_element_cappID);
    HVDESERIALIZE_STRING(m_cPersonID, c_element_cpersonID);
    HVDESERIALIZE_STRING(m_uAppID, c_element_uappID);
    HVDESERIALIZE_STRING(m_uPersonID, c_element_upersonID);
    HVDESERIALIZE_DATE(m_cDateMin, c_element_cdateMin);
    HVDESERIALIZE_DATE(m_cDateMax, c_element_cdateMax);
    HVDESERIALIZE_DATE(m_uDateMin, c_element_udateMin);
    HVDESERIALIZE_DATE(m_udateMax, c_element_udateMax);
    HVDESERIALIZE_STRING(m_xpath, c_element_xpath);
}

@end

@implementation HVItemFilter

-(HVStringCollection *)typeIDs
{
    HVENSURE(m_typeIDs, HVStringCollection);
    return m_typeIDs;
}

-(void)setTypeIDs:(HVStringCollection *)typeIDs
{
    HVRETAIN(m_typeIDs, typeIDs);
}

-(id) init
{
    return [self initWithTypeID:nil];
}

-(id) initWithTypeID:(NSString *)typeID
{
    self = [super init];
    HVCHECK_SELF;
    
    if (typeID)
    {
        [self.typeIDs addObject:typeID];
        HVCHECK_NOTNULL(m_typeIDs);
    }
    
    m_state = HVItemStateActive;
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(id)initWithTypeClass:(Class)typeClass
{
    NSString* typeID = [[HVTypeSystem current] getTypeIDForClassName:NSStringFromClass(typeClass)];
    HVCHECK_NOTNULL(typeID);
    
    return [self initWithTypeID:typeID];
    
LError:
    HVALLOC_FAIL;
}

-(void) dealloc
{
    [m_typeIDs release];    
    [super dealloc];
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_ARRAY(m_typeIDs, c_element_typeID);
    [super serialize:writer];
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRINGCOLLECTION(m_typeIDs, c_element_typeID);
    [super deserialize:reader];
}

@end

@implementation HVItemFilterCollection

-(id) init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVItemFilter class];
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)addItem:(HVItemFilter *)filter
{
    [super addObject:filter];
}

-(HVItemFilter *)itemAtIndex:(NSUInteger)index
{
    return [self objectAtIndex:index];
}

@end
