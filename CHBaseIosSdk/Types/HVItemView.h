//
//  HVItemView.h
//  HVLib
//
//

#import <Foundation/Foundation.h>
#import "HVType.h"
#import "HVItemSection.h"

@interface HVItemView : HVType
{
@private
    enum HVItemSection m_sections;
    HVStringCollection* m_transforms;
    HVStringCollection* m_typeVersions;
}
@property (readwrite, nonatomic) enum HVItemSection sections;
@property (readonly, nonatomic) HVStringCollection* transforms;
@property (readonly, nonatomic) HVStringCollection* typeVersions;

@end
