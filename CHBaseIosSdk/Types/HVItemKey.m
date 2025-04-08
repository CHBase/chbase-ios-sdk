//
//  HVItemKey.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVItemKey.h"
#import "HVValidator.h"
#import "HVGuid.h"

static const xmlChar* x_attribute_version = XMLSTRINGCONST("version-stamp");
static NSString* const c_localIDPrefix = @"L";

@implementation HVItemKey

@synthesize itemID = m_id;
@synthesize version = m_version;

-(BOOL)hasVersion
{
    return (![NSString isNilOrEmpty:m_version]);
}

-(id)initWithID:(NSString *)itemID
{
    return [self initWithID:itemID andVersion:nil];
}

-(id) initWithID:(NSString *)itemID andVersion:(NSString *)version
{
    HVCHECK_NOTNULL(itemID);
     
    self = [super init];
    HVCHECK_SELF;
    
    self.itemID = itemID;
    if (version)
    {
        self.version = version;
    }
    
    return self;
    
LError:
    HVALLOC_FAIL;    
}

-(id)initWithKey:(HVItemKey *)key
{
    HVCHECK_NOTNULL(key);
    
    return [self initWithID:key.itemID andVersion:key.version];

LError:
    HVALLOC_FAIL;
}

-(id) initNew
{
    return [self initWithID:guidString()];
}

-(void) dealloc
{
    [m_id release];
    [m_version release];
    
    [super dealloc];
}

+(HVItemKey *)newLocal
{
    NSString* itemID =  [c_localIDPrefix stringByAppendingString:guidString()];
    NSString* version = guidString();
    
    return [[HVItemKey alloc] initWithID:itemID andVersion:version];
}

+(HVItemKey *)local
{
    return [[HVItemKey newLocal] autorelease];
}

-(BOOL)isVersion:(NSString *)version
{
    return [self.version isEqualToString:version];
}

-(BOOL)isLocal
{
    return [m_id hasPrefix:c_localIDPrefix];
}

-(BOOL)isEqualToKey:(HVItemKey *)key
{
    if (!key)
    {
        return FALSE;
    }
    
    
    return ([m_id isEqualToString:key.itemID] &&
            (m_version && key.version) &&
            [m_version isEqualToString:key.version]
            );
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_STRING(m_id, HVClientError_InvalidItemKey);
    HVVALIDATE_STRING(m_version, HVClientError_InvalidItemKey);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(NSString *)description
{
    return m_id;
}

-(void) serializeAttributes:(XWriter *)writer
{
    HVSERIALIZE_ATTRIBUTE_X(m_version, x_attribute_version);
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_TEXT(m_id);
}

-(void) deserializeAttributes:(XReader *)reader
{
    HVDESERIALIZE_ATTRIBUTE_X(m_version, x_attribute_version);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_TEXT(m_id);
}

@end

static NSString* const c_element_key = @"thing-id";

@implementation HVItemKeyCollection

-(id) init
{
    return [self initWithKey:nil];
}

-(id)initWithKey:(HVItemKey *)key
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVItemKey class];
    if (key)
    {
        [self addObject:key];
    }
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void)addItem:(HVItemKey *)key
{
    [super addObject:key];
}

-(HVItemKey *)firstKey
{
    return [self itemAtIndex:0];
}

-(HVItemKey *)itemAtIndex:(NSUInteger)index
{
    return (HVItemKey *) [self objectAtIndex:index];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_ARRAY(m_inner, HVClientError_InvalidItemList);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void)serializeAttributes:(XWriter *)writer
{
    
}
-(void)deserializeAttributes:(XReader *)reader
{
    
}

-(void)serialize:(XWriter *)writer
{
    HVSERIALIZE_ARRAY(m_inner, c_element_key);
}

-(void)deserialize:(XReader *)reader
{
    HVDESERIALIZE_ARRAY(m_inner, c_element_key, HVItemKey);
}

@end
