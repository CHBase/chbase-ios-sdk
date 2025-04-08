//
//  HVItemData.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVItemData.h"
#import "HVItemType.h"
#import "HVItemRaw.h"

static NSString* const c_element_common = @"common";

@interface HVItemData (HVPrivate)

-(HVItemDataTyped *) deserializeTyped:(XReader *) reader;
-(HVItemRaw *) deserializeRaw:(XReader *) reader;

@end

@implementation HVItemData

@synthesize common = m_common;
@synthesize typed = m_typed;

-(BOOL) hasTyped
{
    return (m_typed != nil);
}

-(HVItemDataTyped *) typed
{
    HVENSURE(m_typed, HVItemDataTyped);
    return m_typed;
}

-(void) setTyped:(HVItemDataTyped *)typed
{
    HVRETAIN(m_typed, typed);
}

-(BOOL) hasCommon
{
    return (m_common != nil);
}

-(HVItemDataCommon *) common
{
    HVENSURE(m_common, HVItemDataCommon);
    return m_common;
}

-(void) setCommon:(HVItemDataCommon *)common
{
    HVRETAIN(m_common, common);
}

-(void) dealloc
{
    [m_common release];
    [m_typed release];
    [super dealloc];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE_OPTIONAL(m_common);
    HVVALIDATE_OPTIONAL(m_typed);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

-(void) serialize:(XWriter *)writer
{
    if (m_typed)
    {
        HVSERIALIZE(m_typed, m_typed.rootElement);
    }
    
    HVSERIALIZE(m_common, c_element_common);
}

-(void) deserialize:(XReader *)reader
{
    if (![reader isStartElementWithName:c_element_common])
    {
        //
        // Typed Item Data!
        //
        m_typed = [self deserializeTyped:reader];
        if (!m_typed)
        {
            m_typed = [self deserializeRaw:reader];
        }
        HVCHECK_OOM(m_typed);
    }
    
    if ([reader isStartElementWithName:c_element_common])
    {
        HVDESERIALIZE(m_common, c_element_common, HVItemDataCommon);
    }
}

@end

@implementation HVItemData (HVPrivate)

-(HVItemDataTyped *) deserializeTyped:(XReader *)reader
{
    HVItemType* itemType = (HVItemType *) reader.context;
    NSString* typeID = (itemType != nil) ? itemType.typeID : nil;
    
    HVItemDataTyped* typedItem = [[HVTypeSystem current] newFromTypeID:typeID];
    if (typedItem)
    {
        if (typedItem.hasRawData)
        {
            [typedItem deserialize:reader];
        }
        else 
        {
            [reader readElementRequired:reader.localName intoObject:typedItem];          
        }
    }
    
    return typedItem;
}

-(HVItemRaw *)deserializeRaw:(XReader *)reader
{
    HVItemRaw* raw = [[HVItemRaw alloc] init];
    if (raw)
    {
        [raw deserialize:reader];
    }
    
    return raw;
}

@end