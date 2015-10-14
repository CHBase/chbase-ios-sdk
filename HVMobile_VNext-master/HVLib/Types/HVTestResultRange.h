//
//  HVTestResultRange.h
//  HVLib
//
//
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVCodableValue.h"
#import "HVTestResultRangeValue.h"
#import "HVCollection.h"

@interface HVTestResultRange : HVType
{
@private
    HVCodableValue* m_type;
    HVCodableValue* m_text;
    HVTestResultRangeValue* m_value;
}

@property (readwrite, nonatomic, retain) HVCodableValue* type;
@property (readwrite, nonatomic, retain) HVCodableValue* text;
@property (readwrite, nonatomic, retain) HVTestResultRangeValue* value;

@end

@interface HVTestResultRangeCollection : HVCollection

-(void) addItem:(HVTestResultRange *) item;
-(HVTestResultRange *) itemAtIndex:(NSUInteger) index;

@end