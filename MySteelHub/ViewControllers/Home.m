//
//  Home.m
//  Sourcefuse
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 Sourcefuse. All rights reserved.
//

#import "Home.h"
#import "HomeCell.h"
//#import <GoogleMaps/GoogleMaps.h>
#import "RequirementI.h"

@interface Home ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,SWTableViewCellDelegate>
{
    __weak IBOutlet UISwitch *switchPhysical;
    __weak IBOutlet UISwitch *switchChemical;
    __weak IBOutlet UISwitch *switchCertReq;
    
    __weak IBOutlet UISegmentedControl *sgmtControlLenghtRequired;
    
    __weak IBOutlet UISegmentedControl *sgmtControlTypeRequired;
    
    __weak IBOutlet UIButton *btnPreferedBrands;
    
    __weak IBOutlet UIButton *btnGradeRequired;
    
    __weak IBOutlet UITextField *txtFieldCity;
    
    __weak IBOutlet UITextField *txtFieldState;
    
    __weak IBOutlet UITextField *txtFieldBudget;
    
    CLLocationManager *locationManager;
    
    __weak IBOutlet UIScrollView *_scrollView;
    
    __weak IBOutlet UITableView *tblViewSizes;
    NSString *selectedDiameter;
    UITextField *selectedDiameterTextfield;
    
    NSMutableArray *arrayTblDict;
    
    UIView *pickerToolBarView;
    NSMutableArray *arraySteelSizes;
    
    UIView *pickerPreferredBrandsView;
    NSMutableArray *arrayPreferredBrands;
    NSMutableArray *arraySelectedPreferredBrands;


    UIView *pickerGradeRequiredView;
    NSMutableArray *arrayGradeRequired;
    NSMutableArray *arraySelectedGradeRequired;

    
    __weak IBOutlet NSLayoutConstraint *tblViewHeightConstraint;
    __weak IBOutlet NSLayoutConstraint *scrollContentViewHeightConstraint;
}

- (IBAction)preferedBrandsBtnAction:(UIButton *)sender;
- (IBAction)gradeRequiredBtnAction:(UIButton *)sender;
- (IBAction)submitBtnAction:(UIButton *)sender;

@end

@implementation Home

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //switch controlls reframe
    switchPhysical.transform = CGAffineTransformMakeScale(0.8, 0.8);
    switchPhysical.onTintColor = kBlueColor
    
    switchChemical.transform = CGAffineTransformMakeScale(0.8, 0.8);
    switchChemical.onTintColor = kBlueColor

    switchCertReq.transform = CGAffineTransformMakeScale(0.8, 0.8);
    switchCertReq.onTintColor = kBlueColor

    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardDidHideNotification object:nil ];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil ];
    
    [self setTitleLabel:@"NEW REQUIREMENT"];
    [self setMenuButton];
    [self setBackButton];
    
    arrayTblDict = [NSMutableArray new];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"diameter",@"",@"quantity", nil];
    [arrayTblDict addObject:dict];
    
    tblViewSizes.dataSource = self;
    tblViewSizes.delegate = self;
    tblViewHeightConstraint.constant = (arrayTblDict.count+1)*44;
    [tblViewSizes reloadData];
    //[self getUserLocation];
    /*
     GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
     longitude:151.2086
     zoom:6];
     //mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
     GMSMarker *marker = [[GMSMarker alloc] init];
     marker.position = camera.target;
     marker.snippet = @"Hello World";
     marker.appearAnimation = kGMSMarkerAnimationPop;
     marker.map = mapView;
     self.view = mapView;
     */
    
    arraySteelSizes = [NSMutableArray arrayWithObjects:@"8mm",@"10mm",@"12mm",@"14mm",@"16mm", nil];
    
    // initiaize picker view
    pickerToolBarView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [pickerToolBarView setBackgroundColor:[UIColor whiteColor]];
    [self createPickerWithTag:111 inView:pickerToolBarView];
    [self.view addSubview:pickerToolBarView];
    pickerToolBarView.hidden = YES;
    
    arrayPreferredBrands = [NSMutableArray arrayWithObjects:@"Birla",@"Binani",@"Jindal",@"Reliance",@"Tata", nil];
    arraySelectedPreferredBrands = [NSMutableArray new];
    
    // initiaize picker view
    pickerPreferredBrandsView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [pickerPreferredBrandsView setBackgroundColor:[UIColor whiteColor]];
    [self createTableViewWithTag:222 inView:pickerPreferredBrandsView];
    [self.view addSubview:pickerPreferredBrandsView];
    pickerPreferredBrandsView.hidden = YES;
    
    arrayGradeRequired = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    arraySelectedGradeRequired = [NSMutableArray new];

    // initiaize picker view
    pickerGradeRequiredView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [pickerGradeRequiredView setBackgroundColor:[UIColor whiteColor]];
    [self createTableViewWithTag:333 inView:pickerGradeRequiredView];
    [self.view addSubview:pickerGradeRequiredView];
    pickerGradeRequiredView.hidden = YES;
}

-(void)createPickerWithTag:(int)tag inView:(UIView*)parentview
{
    UIPickerView *pickerView=[[UIPickerView alloc]init];
    pickerView.frame=CGRectMake(0,0,self.view.frame.size.width, 216);
    pickerView.showsSelectionIndicator = YES;
    [pickerView setDataSource: self];
    [pickerView setDelegate: self];
    pickerView.tag = tag;
    pickerView.backgroundColor = [UIColor whiteColor];
    
    
    [parentview addSubview:pickerView];
    
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneButtonPressed)];
    
    
    [pickerToolbar setItems:@[flexSpace, doneBtn] animated:YES];
    
    [parentview addSubview:pickerToolbar];
}

-(void)createTableViewWithTag:(int)tag inView:(UIView*)parentview
{
    UITableView *tblView=[[UITableView alloc]init];
    tblView.frame=CGRectMake(0,44,self.view.frame.size.width, 216-44);
    [tblView setDataSource: self];
    [tblView setDelegate: self];
    tblView.tag = tag;
    tblView.backgroundColor = [UIColor whiteColor];
    
    
    [parentview addSubview:tblView];
    
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(tableDoneButtonPressed)];
    
    
    [pickerToolbar setItems:@[flexSpace, doneBtn] animated:YES];
    
    [parentview addSubview:pickerToolbar];
}

#pragma mark - UIPickerView delgates

// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView.tag==111)
        return [arraySteelSizes count];
    else
        return 0;

}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag==111)
        return [arraySteelSizes objectAtIndex: row];
    else
        return @"";
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView.tag==111)
    {
        NSLog(@"You selected this: %@", [arraySteelSizes objectAtIndex: row]);
        selectedDiameter = [arraySteelSizes objectAtIndex: row];
    }
    
}

-(void)pickerDoneButtonPressed
{
    pickerToolBarView.hidden = YES;
    selectedDiameterTextfield.text = selectedDiameter;
    selectedDiameter = @"";
}

-(void)tableDoneButtonPressed
{
    pickerGradeRequiredView.hidden = YES;
    pickerPreferredBrandsView.hidden = YES;
    
    
    if(arraySelectedPreferredBrands.count>0)
    {
        
        [btnPreferedBrands setTitle:[NSString stringWithFormat:@"Prefered Brands : %@",[arraySelectedPreferredBrands componentsJoinedByString:@", "]] forState:UIControlStateNormal];

    }
    
    if(arraySelectedGradeRequired.count>0)
    {
        
        [btnGradeRequired setTitle:[NSString stringWithFormat:@"Grade Required : %@",[arraySelectedGradeRequired componentsJoinedByString:@", "]] forState:UIControlStateNormal];

    }
}


#pragma mark table view data sources and delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==222)
        return arrayPreferredBrands.count;
    else if(tableView.tag==333)
        return arrayGradeRequired.count;
    return arrayTblDict.count+1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag==222)
    {
        static NSString *_simpleTableIdentifier = @"CellIdentifier";
        
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:_simpleTableIdentifier];
        
        // Configure the cell...
        if(cell==nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_simpleTableIdentifier];
            
        }
        
        cell.textLabel.text = [arrayPreferredBrands objectAtIndex:indexPath.row];

        
        if ([arraySelectedPreferredBrands containsObject:[arrayPreferredBrands objectAtIndex:indexPath.row]])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    else if(tableView.tag==333)
    {
        static NSString *_simpleTableIdentifier = @"CellIdentifier";
        
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:_simpleTableIdentifier];
        
        // Configure the cell...
        if(cell==nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_simpleTableIdentifier];
            
        }
        
        cell.textLabel.text = [arrayGradeRequired objectAtIndex:indexPath.row];
        
        if ([arraySelectedGradeRequired containsObject:[arrayGradeRequired objectAtIndex:indexPath.row]])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    else
    {
        HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if(indexPath.row==arrayTblDict.count)
        {
            cell.btnAdd.hidden = NO;
            cell.txtFieldDiameter.hidden = YES;
            cell.txtFieldQuantity.hidden = YES;
            [cell setRightUtilityButtons:nil WithButtonWidth:0];
            [cell setDelegate:nil];
            
        }
        else
        {
            cell.txtFieldDiameter.hidden = NO;
            cell.txtFieldQuantity.hidden = NO;
            cell.btnAdd.hidden = YES;
            
            NSArray *arrayRightBtns = [self rightButtons];
            [cell setRightUtilityButtons:arrayRightBtns WithButtonWidth:70];
            [cell setDelegate:self];
            
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==222)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        //the below code will allow multiple selection
        if ([arraySelectedPreferredBrands containsObject:[arrayPreferredBrands objectAtIndex:indexPath.row]])
        {
            [arraySelectedPreferredBrands removeObject:[arrayPreferredBrands objectAtIndex:indexPath.row]];
        }
        else
        {
            [arraySelectedPreferredBrands addObject:[arrayPreferredBrands objectAtIndex:indexPath.row]];
        }
        [tableView reloadData];
    }
    else if(tableView.tag==333)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        //the below code will allow multiple selection
        if ([arraySelectedGradeRequired containsObject:[arrayGradeRequired objectAtIndex:indexPath.row]])
        {
            [arraySelectedGradeRequired removeObject:[arrayGradeRequired objectAtIndex:indexPath.row]];
        }
        else
        {
            [arraySelectedGradeRequired addObject:[arrayGradeRequired objectAtIndex:indexPath.row]];
        }
        [tableView reloadData];
    }
    else
    {
        
    }
}

- (IBAction)btnAddAction:(UIButton *)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"diameter",@"",@"quantity", nil];
    [arrayTblDict addObject:dict];
    
    tblViewHeightConstraint.constant = (arrayTblDict.count+1)*44;
    [tblViewSizes reloadData];
}

#pragma mark - Swipe Cell Delegate
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    UIButton *btn_accept = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_accept setFrame:CGRectMake(0, 0, 40, 50)];
    [btn_accept setBackgroundColor:[UIColor redColor]];
    [btn_accept setTitle:NSLocalizedString(@"Delete",nil) forState:UIControlStateNormal];
    [btn_accept setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightUtilityButtons addObject:btn_accept];
    
    
    return rightUtilityButtons;
}


- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
            
        case 0:
        {
            // accept button is pressed
            NSIndexPath *indexPath;
            indexPath = [tblViewSizes indexPathForCell:cell];

            [arrayTblDict removeObjectAtIndex:indexPath.row];
            tblViewHeightConstraint.constant = (arrayTblDict.count+1)*44;
            [tblViewSizes reloadData]; // tell table to refresh now
            break;
        }
        
        default: break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Methods
-(void)getUserLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse
        //[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways
        ) {
        // Will open an confirm dialog to get user's approval
        [locationManager requestWhenInUseAuthorization];
        //[_locationManager requestAlwaysAuthorization];
    } else {
        [locationManager startUpdatingLocation]; //Will update location immediately
    }
}
-(IBAction)btnClicked:(id)sender
{
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:nil timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
    }];
}


//- (IBAction)btnPhysical:(id)sender {
//    if (btnPhysical.selected==NO) {
//        btnPhysical.selected=YES;
//    }
//    else{
//        btnPhysical.selected=NO;
//    }
//}
//
//- (IBAction)btnChemical:(id)sender {
//    if (btnChemical.selected==NO) {
//        btnChemical.selected=YES;
//    }
//    else{
//        btnChemical.selected=NO;
//    }
//    
//}
//- (IBAction)btnCertReq:(id)sender {
//    if (btnCertReq.selected==NO) {
//        btnCertReq.selected=YES;
//    }
//    else{
//        btnCertReq.selected=NO;
//    }
//    
//}


-(void)Back
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag==777)
    {
        pickerToolBarView.hidden = NO;
        [self.view bringSubviewToFront:pickerToolBarView];
//        if(textField.text.length>0)
//        {
//            selectedDiameter = textField.text;
//        }
//        else
            selectedDiameter = [arraySteelSizes objectAtIndex:0];
        
        UIPickerView *pickerView = [pickerToolBarView viewWithTag:111];
        
        [pickerView selectRow:0 inComponent:0 animated:NO];

        
        selectedDiameterTextfield = textField;
        [textField resignFirstResponder];
    }
}


#pragma mark - Core Location Delegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to get your location." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
    }
    // After fetching the user location stop updating the location.
    [locationManager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
        } break;
        case kCLAuthorizationStatusDenied: {
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [locationManager startUpdatingLocation]; //Will update location immediately
        } break;
        default:
            break;
    }
}

#pragma mark Keyboard
-(void)showKeyboard:(NSNotification*)notification
{
    NSLog(@"Keyboard shown");
    
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, kbSize.height, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    
}
-(void)hideKeyboard:(NSNotification*)notification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0,0, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
}

-(void)Closekeyboard:(NSNotification*)notification
{
    NSLog(@"Keyboard hidden");
    
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)preferedBrandsBtnAction:(UIButton *)sender {
    pickerPreferredBrandsView.hidden = NO;
    [self.view bringSubviewToFront:pickerPreferredBrandsView];
}

- (IBAction)gradeRequiredBtnAction:(UIButton *)sender {
    pickerGradeRequiredView.hidden = NO;
    [self.view bringSubviewToFront:pickerGradeRequiredView];
}

- (IBAction)submitBtnAction:(UIButton *)sender {
    
    RequirementI *newRequirement = [RequirementI new];
    newRequirement.userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"];
    newRequirement.arraySpecifications = arraySteelSizes;
    newRequirement.isChemical = switchChemical.isSelected;
    newRequirement.isPhysical = switchPhysical.isSelected;
    newRequirement.isTestCertificateRequired = switchCertReq.isSelected;
    newRequirement.length = [NSString stringWithFormat:@"%li", (long)sgmtControlLenghtRequired.selectedSegmentIndex];
    newRequirement.type = [NSString stringWithFormat:@"%li", (long)sgmtControlTypeRequired.selectedSegmentIndex];
    newRequirement.arrayPreferedBrands = arraySelectedPreferredBrands;
    newRequirement.budget = txtFieldBudget.text;
    newRequirement.city = txtFieldCity.text;
    newRequirement.state = txtFieldState.text;
    
    [model_manager.requirementManager postRequirement:newRequirement completion:^(NSDictionary *json, NSError *error) {
        
    }];
}
@end
