//
//  HVCollection.h
//  HVLib
//
//
//

#import <Foundation/Foundation.h>

//
// Collections allow objects of a particular type only
// They enforce the type 
//
@interface HVCollection : NSMutableArray
{
    NSMutableArray *m_inner;
}

@property (readwrite, nonatomic, retain) Class type;

-(void) validateNewObject:(id) obj;

//-----------------
//
// Text
//
//-----------------
-(NSString *) toString;

@end

@interface HVStringCollection : HVCollection 

-(BOOL) containsString:(NSString*) value;
-(NSUInteger) indexOfString:(NSString *) value;
-(NSUInteger) indexOfString:(NSString *)value startingAt:(NSUInteger) index;
-(BOOL) removeString:(NSString *) value;

//
// NOTE: these do a linear N^2 scan
//
-(HVStringCollection *) selectStringsFoundInSet:(NSArray *) testSet;
-(HVStringCollection *) selectStringsNotFoundInSet:(NSArray *)testSet;

@end

