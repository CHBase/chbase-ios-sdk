//
//  HVWorkerStatus.h
//  HVLib
//
//
//
//

#import <Foundation/Foundation.h>

@interface HVWorkerStatus : NSObject
{
@private
    BOOL m_isBusy;
    BOOL m_hasPendingWork;
    BOOL m_isEnabled;
}

@property (readwrite, nonatomic, assign) BOOL isEnabled;
@property (readonly, nonatomic) BOOL isBusy;
@property (readonly, nonatomic) BOOL hasPendingWork;

-(BOOL) beginWork;
-(BOOL) completeWork;
-(BOOL) shouldScheduleWork;

@end
