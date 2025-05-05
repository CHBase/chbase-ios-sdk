//
//  HVMasterViewController.m
//  HelloHealthVault
//
//
//

#import "HVMasterViewController.h"

@implementation HVMasterViewController;
@synthesize itemsTable;


//---------------------------
//
// Application Startup
//
//---------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.itemsTable.dataSource = self;
    //
    // Start the HealthVault client
    //
    [self startApp];
}

-(void)startApp
{
    //
    // Startup the HealthVault Client
    // This will automatically ensure that application instance is correctly provisioned to access the user's HealthVault record
    // Look at ClientSettings.xml
    //
    [[HVClient current] startWithParentController:self andStartedCallback:^(id sender) 
    {
        //dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //dispatch_async(myQueue, ^{
            if ([HVClient current].provisionStatus == HVAppProvisionSuccess)
            {
                [self startupSuccess];
            }
            else
            {
                [self startupFailed];
            }
       // });
        
        //dispatch_release(myQueue);
        
    }];
}

-(void)startupSuccess
{
    //
    // Update the UI to show the record owner's display name
    //
    NSString* displayName = [HVClient current].currentRecord.displayName;
    self.navigationItem.title = [NSString stringWithFormat:@"%@'s Data", displayName];
    //
    // Fetch list of data from HealthVault
    //
    [self getDataFromHealthVault];   
}

-(void)startupFailed
{
    [HVUIAlert showWithMessage:@"Provisioning not completed. Retry?" callback:^(id sender) {
        
        HVUIAlert *alert = (HVUIAlert *) sender;
        if (alert.result == HVUIAlertOK)
        {
            [self startApp];
        }
    }];
}

//-------------------------------------------
//
// Get/Put items to/from HealthVault
//
//-------------------------------------------
-(void)getDataFromHealthVault
{
    [[HVClient current].currentRecord getItemsForClass:[HVBodyDimension class] callback:^(HVTask *task) 
    {
        @try {
            //
            // Save the collection of items retrieved
            //
            HVCLEAR(m_items);
            m_items = [((HVGetItemsTask *) task).itemsRetrieved retain];
            //
            // Refresh UI
            //
            [self refreshView];
        }
        @catch (NSException *exception) {
            [HVUIAlert showInformationalMessage:exception.description];
        }
    }];
}

//
// Push a new data into HealthVault
//
-(void)putDataInHealthVault:(HVItem *)item
{
    [[HVClient current].currentRecord putItem:item callback:^(HVTask *task) 
    {
        @try {
            //
            // Throws if there was a failure. Look at HVServerException for details
            //
            [task checkSuccess];  
            //
            // Refresh with the latest list of data from HealthVault
            //
            [self getDataFromHealthVault];  
        }
        @catch (NSException *exception) {
            [HVUIAlert showInformationalMessage:exception.description];
        }
    } ];
}

-(void)removeDataFromHealthVault:(HVItemKey *)itemKey
{
    [[HVClient current].currentRecord removeItemWithKey:itemKey callback:^(HVTask *task) {
        @try {
            [task checkSuccess];  
            //
            // Refresh
            //
            [self getDataFromHealthVault];
        }
       @catch (NSException *exception) {
            [HVUIAlert showInformationalMessage:exception.description];
        }
    }];
}

//
// Create a new random data
//
-(HVItem *)newData
{
    HVItem* item = [HVBodyDimension newItem];

    item.bodyDimension.when = [[[HVApproxDateTime alloc] initNow] autorelease];

    item.bodyDimension.measurementName= [[[HVCodableValue alloc] initWithText:@"height"] autorelease];
    item.bodyDimension.value =  [[[HVLengthMeasurement alloc] initWithMeters:1.80] autorelease];
    
    return item;
}

-(void)changeData:(HVItem *)item
{
    item.bodyDimension.value.value.value = item.bodyDimension.value.value.value+.01;
}

-(void)getDataForLastNDays:(int)numDays
{
    //
    // Set up a filter for HealthVault items
    //
    HVItemFilter* itemFilter = [[[HVItemFilter alloc] initWithTypeClass:[HVBodyDimension class]] autorelease];  // Querying for weights
    //
    // We only want weights no older than numDays
    //
    itemFilter.effectiveDateMin = [[[NSDate alloc] initWithTimeIntervalSinceNow:(-(numDays * (24 * 3600)))] autorelease]; // Interval is in seconds
    //
    // Create a query to issue
    //
    HVItemQuery* query = [[[HVItemQuery alloc] initWithFilter:itemFilter] autorelease];
    
    [[HVClient current].currentRecord getItems:query callback:^(HVTask *task) {
        
        @try {
            //
            // Save the collection of items retrieved
            //
            HVCLEAR(m_items);
            m_items = [((HVGetItemsTask *) task).itemsRetrieved retain];
            //
            // Refresh UI
            //
            [self refreshView];
        }
        @catch (NSException *exception) {
            [HVUIAlert showInformationalMessage:exception.description];
        }       
    }];
}

//-------------------------------------------
//
// Displaying a list of items in a Table View
//
//-------------------------------------------
        
-(void)refreshView
{
    [self.itemsTable reloadData];
}
        
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //
    // If we've already retrieved items, then one row per item
    //
    if (m_items)
    {
        return m_items.count;
    }
    
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger itemIndex = indexPath.row;

    HVBodyDimension* item = [m_items itemAtIndex:itemIndex].bodyDimension;
    //
    // Display it in the table cell for the current row
    //
    UITableViewCell *cell = [self getCellFor:tableView];
    [self displayData:item inCell:cell];
     
    return cell;
}

-(void)displayData:(HVBodyDimension *)item inCell:(UITableViewCell *)cell
{
    cell.textLabel.text = [item.when toStringWithFormat:@"MM/dd/YY hh:mm aaa"];
    cell.detailTextLabel.text = [item.value.value toString];
}

-(UITableViewCell *)getCellFor:(UITableView *)table
{
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"HV"];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"HV"] autorelease];
    }
    
    return cell;
}

//-------------------------------------------
//
// Button Handlers
//
//-------------------------------------------
//
// Refresh Displayed Data from HealthVault
//
- (IBAction)refreshButtonClicked:(id)sender 
{
    [self getDataFromHealthVault];
}

//
// Generate a random new weight entry for today and add it to HealthVault
//
- (IBAction)addButtonClicked:(id)sender 
{
    HVItem* item = [[self newData] autorelease];
    [self putDataInHealthVault:item];
}

//
// Delete the selected item from HealthVault
//
- (IBAction)deleteButtonClicked:(id)sender 
{
    NSIndexPath* selection = [self.itemsTable indexPathForSelectedRow];
    if (!selection)
    {
        return;
    }
    
    NSUInteger itemIndex = selection.row;
    [self removeDataFromHealthVault:[m_items itemAtIndex:itemIndex].key];
}

//
// Change the selected item to a new data and push it to HealthVault
//
- (IBAction)updateButtonClicked:(id)sender 
{
    NSIndexPath* selection = [self.itemsTable indexPathForSelectedRow];
    if (!selection)
    {
        return;
    }
    
    NSUInteger itemIndex = selection.row;
    HVItem* item = [m_items itemAtIndex:itemIndex];

    [self changeData:item];
    
    [self putDataInHealthVault:item];
}

//
// User may want to disconnect their account
//
- (IBAction)disconnectClicked:(id)sender
{
    [HVUIAlert showYesNoWithMessage:@"Are you sure you want to disconnect this application from CHBase?\r\nIf you click Yes, you will need to re-authorize the app." callback:^(id sender) {
        
        HVUIAlert* alert = (HVUIAlert *) sender;
        if (alert.result != HVUIAlertOK)
        {
            return;
        }
        HVCLEAR(m_items);
        [self refreshView];
        //
        // REMOVE RECORD AUTHORIZATION.
        //
        [[HVClient current].user removeAuthForRecord:[HVClient current].currentRecord withCallback:^(HVTask *task) {
            
            [[HVClient current] resetProvisioning];  // Removes local state
            
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (NSHTTPCookie *cookie in [storage cookies]) {
                [storage deleteCookie:cookie];
            }
            [[NSUserDefaults standardUserDefaults] synchronize];
            //
            // Restart app auth
            //
            [self startApp];
        }];
    }];
}

//-------------------------------------------
//
// Standard View Infrastructure
//
//-------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Hello CHBase", @"Master view title");
    }
    return self;
}
					
- (void)dealloc
{
    [m_items release];
    [itemsTable release];
    [super dealloc];
}

#pragma mark - Table View

- (void)viewDidUnload {
    [self setItemsTable:nil];
    [super viewDidUnload];
}
@end
