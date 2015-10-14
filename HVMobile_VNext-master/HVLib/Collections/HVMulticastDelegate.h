//
//  HVMulticastDelegate.h
//  HVLib
//
//

#import <Foundation/Foundation.h>

@interface HVMulticastDelegate : NSObject
{
    NSMutableArray* m_delegates;
}

-(void) subscribe:(id) delegate;
-(void) unsubscribe:(id) delegate;

-(void) invoke:(SEL) sel withParam:(id) param;
-(void) invoke:(SEL) sel withParam:(id) param withParam:(id) param2;

@end
