//
//  HVMasterViewController.h
//  HelloHealthVault
//
//

@import UIKit;
//
// Include HealthVault Library
//
#import "HVLib.h"
#import "HVHba1cvalue.h"
@interface HVMasterViewController : UIViewController <UITableViewDataSource>
{
    //
    // Collection of items you retrieved from HealthVault
    //
    HVItemCollection* m_items;
}
//
// Table we will display HV items in
//
@property (retain, nonatomic) IBOutlet UITableView *itemsTable;

//
// Application startup
//
-(void) startApp;
-(void) startupSuccess;
-(void) startupFailed;
//
// Asynchronously get items from the user's HealthVault record
//
-(void) getWeightsFromHealthVault;
-(void) getWeightsForLastNDays:(int) numDays;
//
// Asynchronously write items to the User's HealthVault record
//
-(void) putWeightInHealthVault:(HVItem *) weight;
//
// Asynchronously remove items from the User's HealthVault record
//
-(void) removeWeightFromHealthVault:(HVItemKey *) itemKey;
//
// Create a new weight measurement
//
-(HVItem *) newWeight;
-(void) changeWeight:(HVItem *) item;
//
// Displaying Weights in TableView
//
-(void) refreshView;
-(void) displayWeight:(HVWeight *) weight inCell:(UITableViewCell *) cell;
-(UITableViewCell *) getCellFor:(UITableView *) table;
//
// Toolbar button handlers
//
- (IBAction)refreshButtonClicked:(id)sender;
- (IBAction)addButtonClicked:(id)sender;
- (IBAction)deleteButtonClicked:(id)sender;
- (IBAction)updateButtonClicked:(id)sender;
- (IBAction)disconnectClicked:(id)sender;

@end
