//
//  HVItemChange.m
//  HVLib
//
//
//
//
#import "HVCommon.h"
#import "HVItemChange.h"

static const xmlChar* x_element_changeID = XMLSTRINGCONST("changeID");
static const xmlChar* x_element_timestamp = XMLSTRINGCONST("timestamp");
static const xmlChar* x_element_type = XMLSTRINGCONST("type");
static const xmlChar* x_element_typeID = XMLSTRINGCONST("typeID");
static const xmlChar* x_element_key = XMLSTRINGCONST("key");
static const xmlChar* x_element_attempt = XMLSTRINGCONST("attempt");

@interface HVItemChange (HVPrivate)

-(void) updateWithKey:(HVItemKey *) key andChangeType:(enum HVItemChangeType) type;

@end

@implementation HVItemChange

@synthesize changeType = m_changeType;
@synthesize changeID = m_changeID;
@synthesize timestamp = m_timestamp;
@synthesize typeID = m_typeID;
-(NSString *)itemID
{
    return m_key.itemID;
}

@synthesize itemKey = m_key;
@synthesize updatedKey = m_updatedKey;
@synthesize localItem = m_localItem;
@synthesize updatedItem = m_updatedItem;
@synthesize attemptCount = m_attempt;

// We need a default vanilla constructor for Xml serialization
-(id)init
{
    return [super init];
}

-(id)initWithTypeID:(NSString *)typeID key:(HVItemKey *)key changeType:(enum HVItemChangeType)changeType
{
    HVCHECK_STRING(typeID);
    HVCHECK_NOTNULL(key);
    
    self = [super init];
    HVCHECK_SELF;
    
    HVRETAIN(m_typeID, typeID);
    [self updateWithKey:key andChangeType:changeType];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)dealloc
{
    [m_changeID release];
    [m_typeID release];
    [m_key release];
    [m_updatedKey release];
    [m_localItem release];
    [m_updatedItem release];
    
    [super dealloc];
}

-(void)assignNewChangeID
{
    NSString* uniqueId = [@"iOS_" stringByAppendingString:guidString()];
    HVRETAIN(m_changeID, uniqueId);
}

-(void)assignNewTimestamp
{
    // Doesn't need to be more than 1 second accuracy. Timestamp is used to give us an approximate sort order for the upload queue
    m_timestamp = [[NSDate date] timeIntervalSinceReferenceDate];
}

-(BOOL)isChangeForType:(NSString *)typeID
{
    return [m_typeID isEqualToString:typeID];
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING_X(m_changeID, x_element_changeID);
    HVSERIALIZE_DOUBLE_X(m_timestamp, x_element_timestamp);
    HVSERIALIZE_INT_X(m_changeType, x_element_type);
    HVSERIALIZE_STRING_X(m_typeID, x_element_typeID);
    HVSERIALIZE_X(m_key, x_element_key);
    HVSERIALIZE_INT_X(m_attempt, x_element_attempt);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING_X(m_changeID, x_element_changeID);
    HVDESERIALIZE_DOUBLE_X(m_timestamp, x_element_timestamp);
    
    int changeType;
    HVDESERIALIZE_INT_X(changeType, x_element_type);
    m_changeType = (enum HVItemChangeType) changeType;
    
    HVDESERIALIZE_STRING_X(m_typeID, x_element_typeID);
    HVDESERIALIZE_X(m_key, x_element_key, HVItemKey);
    HVDESERIALIZE_INT_X(m_attempt, x_element_attempt);
}

+(BOOL)updateChange:(HVItemChange *)change withTypeID:(NSString *)typeID key:(HVItemKey *)key changeType:(enum HVItemChangeType)changeType
{
    HVCHECK_NOTNULL(change);
    
    HVCHECK_FALSE((change.changeType == HVItemChangeTypeRemove && changeType == HVItemChangeTypePut));
    HVCHECK_TRUE([change isChangeForType:typeID]);
    
    [change updateWithKey:key andChangeType:changeType];
    return TRUE;
 
LError:
    return FALSE;
}

+(NSComparisonResult)compareChange:(HVItemChange *)x to:(HVItemChange *)y
{
    NSComparisonResult result = [x.typeID compare:y.typeID];
    if (result == NSOrderedSame)
    {
        if (x.timestamp == y.timestamp)
        {
            result = [x.itemID compare:y.itemID];
        }
        else if (x.timestamp < y.timestamp)
        {
            result = NSOrderedAscending;
        }
        else
        {
            result = NSOrderedDescending;
        }
    }
    return result;
}

@end

@implementation HVItemChange (HVPrivate)

-(void)updateWithKey:(HVItemKey *)key andChangeType:(enum HVItemChangeType)type
{
    HVRETAIN(m_key, key);
    m_changeType = type;
    [self assignNewChangeID];
    [self assignNewTimestamp];
}

@end