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

@interface Home ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
{
    __weak IBOutlet UISwitch *switchPhysical;
    __weak IBOutlet UISwitch *switchChemical;
    __weak IBOutlet UISwitch *switchCertReq;
    
    CLLocationManager *locationManager;
    
    __weak IBOutlet UIScrollView *_scrollView;
    
    __weak IBOutlet UITableView *tblViewSizes;
    
    int rowCountSizesTable;
    
    UIView *pickerToolBarView;
    NSMutableArray *arraySteelSizes;
}
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
    
    tblViewSizes.dataSource = self;
    tblViewSizes.delegate = self;
    rowCountSizesTable = 1;
    
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
    
    
    UIPickerView *pickerView=[[UIPickerView alloc]init];
    pickerView.frame=CGRectMake(0,0,self.view.frame.size.width, 216);
    pickerView.showsSelectionIndicator = YES;
    [pickerView setDataSource: self];
    [pickerView setDelegate: self];
    pickerView.backgroundColor = [UIColor whiteColor];
    
    
    [pickerToolBarView addSubview:pickerView];
    
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneButtonPressed)];
    
    
    [pickerToolbar setItems:@[flexSpace, doneBtn] animated:YES];
    
    [pickerToolBarView addSubview:pickerToolbar];
    [self.view addSubview:pickerToolBarView];
    pickerToolBarView.hidden = YES;
}

#pragma mark - UIPickerView delgates

// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [arraySteelSizes count];
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [arraySteelSizes objectAtIndex: row];
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"You selected this: %@", [arraySteelSizes objectAtIndex: row]);
}


-(void)pickerDoneButtonPressed
{
    pickerToolBarView.hidden = YES;
}

#pragma mark table view data sources and delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return rowCountSizesTable+1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(indexPath.row==rowCountSizesTable)
    {
        cell.btnAdd.hidden = NO;
        cell.txtFieldDiameter.hidden = YES;
        cell.txtFieldQuantity.hidden = YES;
    }
    else
    {
        cell.txtFieldDiameter.hidden = NO;
        cell.txtFieldQuantity.hidden = NO;
        cell.btnAdd.hidden = YES;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)btnAddAction:(UIButton *)sender {
    
    rowCountSizesTable++;
    [tblViewSizes reloadData];
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

@end
