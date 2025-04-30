#import <Foundation/Foundation.h>
#import "HVTypes.h"

@interface HVAdvanceDirectiveContactType : HVItemDataTyped
{
@private
    HVName* m_name;
    NSString* m_id;
    HVContact* m_contactInfo;
    HVCodableValue* m_relationship;
    HVBool* m_isPrimary;
}

@property (readwrite, nonatomic, retain) HVName* name;
@property (readwrite, nonatomic, retain) NSString* id;
@property (readwrite, nonatomic, retain) HVContact* contactInfo;
@property (readwrite, nonatomic, retain) HVCodableValue* relationship;
@property (readwrite, nonatomic, retain) HVBool* isPrimary;

@end


@interface HVAdvanceDirectiveContactTypeCollection : HVCollection

-(void) addItem:(HVAdvanceDirectiveContactType *) item;
-(HVAdvanceDirectiveContactType *) itemAtIndex:(NSUInteger) index;

@end
