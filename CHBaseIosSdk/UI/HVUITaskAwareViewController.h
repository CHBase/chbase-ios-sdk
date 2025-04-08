//
//  HVUITaskAwareViewController.h
//  HVLib
//
//
//
//

#import <UIKit/UIKit.h>
#import "HVAsyncTask.h"

@interface HVUITaskAwareViewController : UIViewController
{
    HVTask* m_activeTask;
}

@property (readonly, nonatomic) BOOL hasActiveTask;
@property (readwrite, nonatomic, retain) HVTask* activeTask;

-(void) cancelActiveTask;
//
// You can override this to cancel any other tasks
// Indicates that the view will *really* disappear
//
-(void) viewWillClose;

@end
