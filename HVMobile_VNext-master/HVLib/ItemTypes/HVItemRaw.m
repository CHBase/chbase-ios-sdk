//
//  HVItemRaw.m
//  HVLib
//
//

#import "HVCommon.h"
#import "HVItemRaw.h"

@implementation HVItemRaw

@synthesize xml = m_xml;

-(BOOL)hasRawData
{
    return TRUE;
}

-(void) dealloc
{
    [m_root release];
    [m_xml release];
    
    [super dealloc];
}

-(NSString *)rootElement
{
    return m_root;
}

-(void) serialize:(XWriter *)writer
{
    if (m_xml)
    {
        [writer writeRaw:m_xml];
    }
}

-(void) deserialize:(XReader *)reader
{
    HVRETAIN(m_root, reader.localName);
    HVDESERIALIZE_RAW(m_xml, m_root);
}

@end
