//
//  Home.m
//  Sourcefuse
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 Sourcefuse. All rights reserved.
//

#import "Home.h"
#import "HomeCell.h"
#import "OrderConfirmation.h"

#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"

//#import <GoogleMaps/GoogleMaps.h>
#import "RequirementI.h"
#import "Conversation.h"
#import "OrderI.h"
#import "PickAddressVC.h"

//TableviewCell
#import "HomeQuantityCell.h"
#import "HomeAddMoreCell.h"
#import "HomeProductDetailCell.h"
#import "Home_SellerResponse.h"

@interface Home ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,SWTableViewCellDelegate>
{
//<<<<<<< HEAD
//    __weak IBOutlet NSLayoutConstraint *contraintBrandsLbl;
//    __weak IBOutlet UITableView *tblSellerResponse;
//    
//    __weak IBOutlet UISwitch *switchPhysical;
//    __weak IBOutlet UISwitch *switchChemical;
//    __weak IBOutlet UISwitch *switchCertReq;
//    
//    __weak IBOutlet UISegmentedControl *sgmtControlLenghtRequired;
//    
//    __weak IBOutlet UISegmentedControl *sgmtControlTypeRequired;
//    
//    __weak IBOutlet UIButton *btnPreferedBrands;
//    
//    __weak IBOutlet UIButton *btnGradeRequired;
//    
//    __weak IBOutlet UITextField *txtFieldCity;
//    
//    __weak IBOutlet UITextField *txtFieldState;
//    
//    __weak IBOutlet UITextField *txtFieldBudget;
//    
//    __weak IBOutlet UIButton *btnRequiredByDate;
//    
//    __weak IBOutlet UIButton *btnPreferedTax;
    
//=======
    __weak IBOutlet UITableView *tblView;
//>>>>>>> 68bbcdf6b67d35f7c61bb1ea2c08bad9c01be04a
    __weak IBOutlet UIButton *btnSubmit;
    
    CLLocationManager *locationManager;
    
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
    NSString *selectedGradeRequired;
    NSString *selectedGradeID;
    
    UIView *datePickerView;
    NSString *selectedDate;
    
    UIView *pickerTaxView;
    NSMutableArray *arrayTaxes;
    NSString *selectedTax;
    NSString *selectedTaxID;
    
    
    UIView *pickerViewState;
    NSMutableArray *arrayStates;
    NSString *selectedState;
    

    RequirementI *newRequirement;
    
    UIToolbar *keyboardDoneButtonView;

    __weak IBOutlet UIButton *btnLoadMore;
    
    BOOL isLoadMoreClicked;
    
    __weak IBOutlet NSLayoutConstraint *constraintSubmitBtnHeight;
    
   UITextField *actifText;

    BOOL isAccepted;
}


- (IBAction)submitBtnAction:(UIButton *)sender;



@end

@implementation Home

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:true];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardDidHideNotification object:nil ];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil ];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:true];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    model_manager.requirementManager.requirementDetailDelegate = self;
    
    isLoadMoreClicked = false;
    [self clkLoadMore:nil];
    
    isAccepted = NO;
    
    if(_selectedRequirement)
        newRequirement = _selectedRequirement;
    else
        newRequirement = [RequirementI new];
    
    selectedGradeRequired = @"";
    selectedDate = @"";
    selectedTax = @"";
    selectedState = @"";

    if (_selectedRequirement) {
        constraintSubmitBtnHeight.constant = 0;
    }
    
    
    //switch controlls reframe
    /*
    switchPhysical.transform = CGAffineTransformMakeScale(0.8, 0.8);
    switchPhysical.onTintColor = kBlueColor;
    
    switchChemical.transform = CGAffineTransformMakeScale(0.8, 0.8);
    switchChemical.onTintColor = kBlueColor;
    
    switchCertReq.transform = CGAffineTransformMakeScale(0.8, 0.8);
    switchCertReq.onTintColor = kBlueColor;
    
    */

    
    if(_selectedRequirement)
    {
        [self setTitleLabel:@"ORDER DETAILS"];
    }
    else
        [self setTitleLabel:@"NEW REQUIREMENT"];
    
    [self setMenuButton];
    [self setBackButton];
    
    /*
    //Custom UI for TextFilds
    [self customtxtfield:txtFieldCity withrightIcon:nil borderLeft:false borderRight:false borderBottom:false borderTop:false];
    
    [self customtxtfield:txtFieldState withrightIcon:nil borderLeft:false borderRight:false borderBottom:false borderTop:false];
    
    [self customtxtfield:txtFieldBudget withrightIcon:nil borderLeft:false borderRight:false borderBottom:false borderTop:false];
    
    //New Implemetation
    UIFont *font = [UIFont fontWithName:@"Raleway-Regular" size:15];
    
    
    
    lbCity = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110, 15)];
    lbCity.textColor =  kPlaceHolderGrey;
    lbCity.font = font;
    lbCity.text = @"   Delivery City ";
    [txtFieldCity setLeftView:lbCity];
    [txtFieldCity setLeftViewMode:UITextFieldViewModeAlways];
    
    lbState = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 15)];
    lbState.textColor =  kPlaceHolderGrey;
    lbState.font = font;
    lbState.text = @"   State ";
    [txtFieldState setLeftView:lbState];
    [txtFieldState setLeftViewMode:UITextFieldViewModeAlways];
    
    lbAmount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 15)];
    lbAmount.textColor =  kPlaceHolderGrey;
    lbAmount.font = font;
    lbAmount.text = @"   Budget Amount (Rs) ";
    [txtFieldBudget setLeftView:lbAmount];
    [txtFieldBudget setLeftViewMode:UITextFieldViewModeAlways];
    
    
    [txtFieldCity setValue:[UIColor lightGrayColor]
                forKeyPath:@"_placeholderLabel.textColor"];
    [txtFieldState setValue:[UIColor lightGrayColor]
                 forKeyPath:@"_placeholderLabel.textColor"];
    [txtFieldBudget setValue:[UIColor lightGrayColor]
                  forKeyPath:@"_placeholderLabel.textColor"];
    
    */
    
    
    //btnPreferedBrands.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
       // btnGradeRequired.titleLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:15];
    //    btnPreferedBrands.titleLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:15];
    //    btnRequiredByDate.titleLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:15];
    
    
    arrayTblDict = [NSMutableArray new];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"size",@"",@"quantity", nil];
    [arrayTblDict addObject:dict];
    
    
    tblView.dataSource = self;
    tblView.delegate = self;
    
    tblView.estimatedRowHeight = 200.0;
    tblView.rowHeight = UITableViewAutomaticDimension;
    [tblView layoutIfNeeded];
    [tblView setNeedsLayout];

    
   // tblViewHeightConstraint.constant = (arrayTblDict.count+1)*44;

   // if (_selectedRequirement) {
       // tblViewHeightConstraint.constant = (arrayTblDict.count)*44;

    //}
    //[tblViewSizes reloadData];
    
    
    
    //[tblSellerResponse reloadData];
    
    
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
    
    
    if(model_manager.requirementManager.arraySteelSizes.count>0)
        arraySteelSizes = [NSMutableArray arrayWithArray:model_manager.requirementManager.arraySteelSizes];
    else
        arraySteelSizes = [NSMutableArray new];
    
    // initiaize picker view
    pickerToolBarView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [pickerToolBarView setBackgroundColor:[UIColor whiteColor]];
    [self createPickerWithTag:111 inView:pickerToolBarView];
    [self.view addSubview:pickerToolBarView];
    pickerToolBarView.hidden = YES;
    
    //arrayPreferredBrands = [NSMutableArray arrayWithObjects:@"Birla",@"Binani",@"Jindal",@"Reliance",@"Tata", nil];
    if(model_manager.requirementManager.arraySteelBrands.count>0)
        arrayPreferredBrands = [NSMutableArray arrayWithArray:model_manager.requirementManager.arraySteelBrands];
    else
        arrayPreferredBrands = [NSMutableArray new];
    
    
    arraySelectedPreferredBrands = [NSMutableArray new];
    
    // initiaize picker view
    pickerPreferredBrandsView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [pickerPreferredBrandsView setBackgroundColor:[UIColor whiteColor]];
    [self createTableViewWithTag:222 inView:pickerPreferredBrandsView];
    [self.view addSubview:pickerPreferredBrandsView];
    pickerPreferredBrandsView.hidden = YES;
    
    //arrayGradeRequired = [NSMutableArray arrayWithObjects:@"A",@"B",@"C",@"D", nil];
    if(model_manager.requirementManager.arraySteelGrades.count>0)
        arrayGradeRequired = [NSMutableArray arrayWithArray:model_manager.requirementManager.arraySteelGrades];
    else
        arrayGradeRequired = [NSMutableArray new];
    
    
    // initiaize picker view
    pickerGradeRequiredView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [pickerGradeRequiredView setBackgroundColor:[UIColor whiteColor]];
    [self createPickerWithTag:333 inView:pickerGradeRequiredView];
    [self.view addSubview:pickerGradeRequiredView];
    pickerGradeRequiredView.hidden = YES;
    
    //initialize date picker
    datePickerView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [datePickerView setBackgroundColor:[UIColor whiteColor]];
    [self createDatePickerWithTag:444 inView:datePickerView];
    [self.view addSubview:datePickerView];
    datePickerView.hidden = YES;
    
    //initialize taxes picker
    pickerTaxView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [pickerTaxView setBackgroundColor:[UIColor whiteColor]];
    [self createPickerWithTag:555 inView:pickerTaxView];
    [self.view addSubview:pickerTaxView];
    pickerTaxView.hidden = YES;
    
    //arrayTaxes = [NSMutableArray arrayWithObjects:@"CST",@"VAT",@"SST", nil];
    
    //initialize picker for states
    pickerViewState = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [pickerViewState setBackgroundColor:[UIColor whiteColor]];
    [self createPickerWithTag:777 inView:pickerViewState];
    [self.view addSubview:pickerViewState];
    pickerViewState.hidden = YES;
    
    arrayStates = [NSMutableArray arrayWithArray:model_manager.requirementManager.arrayStates];
    
    [model_manager.requirementManager getStates:^(NSDictionary *json, NSError *error) {
        if(model_manager.requirementManager.arrayStates.count>0)
        {
            arrayStates = [NSMutableArray arrayWithArray:model_manager.requirementManager.arrayStates];
            UIPickerView *pickerView = [pickerViewState viewWithTag:777];
            [pickerView reloadAllComponents];
        }
    }];
    
    
    [model_manager.requirementManager getSteelBrands:^(NSDictionary *json, NSError *error) {
        if(model_manager.requirementManager.arraySteelBrands.count>0)
        {
            arrayPreferredBrands = [NSMutableArray arrayWithArray:model_manager.requirementManager.arraySteelBrands];
            UITableView *tblViewBrands = [pickerPreferredBrandsView viewWithTag:222];
            [tblViewBrands reloadData];
            
        }
    }];
    
    [model_manager.requirementManager getSteelSizes:^(NSDictionary *json, NSError *error) {
        if(model_manager.requirementManager.arraySteelSizes.count>0)
        {
            arraySteelSizes = [NSMutableArray arrayWithArray:model_manager.requirementManager.arraySteelSizes];
            UIPickerView *pickerView = [pickerToolBarView viewWithTag:111];
            [pickerView reloadAllComponents];
        }
    }];
    
    [model_manager.requirementManager getSteelGrades:^(NSDictionary *json, NSError *error) {
        if(model_manager.requirementManager.arraySteelGrades.count>0)
        {
            arrayGradeRequired = [NSMutableArray arrayWithArray:model_manager.requirementManager.arraySteelGrades];
            UIPickerView *pickerView = [pickerGradeRequiredView viewWithTag:333];
            [pickerView reloadAllComponents];
        }
    }];
    
    
    [model_manager.requirementManager getTaxTypes:^(NSDictionary *json, NSError *error) {
        if(model_manager.requirementManager.arrayTaxTypes.count>0)
        {
            arrayTaxes = [NSMutableArray arrayWithArray:model_manager.requirementManager.arrayTaxTypes];
            UIPickerView *pickerView = [pickerTaxView viewWithTag:555];
            [pickerView reloadAllComponents];
        }
    }];
    
    
    keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleBlackOpaque;
    [keyboardDoneButtonView sizeToFit];
    
    [keyboardDoneButtonView setBackgroundImage:[UIImage new]
                   forToolbarPosition:UIToolbarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
    [keyboardDoneButtonView setBackgroundColor:kBlueColor];
    
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(doneClicked:)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
    
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexSpace,doneBtn, nil]];
    [tblView reloadData];
    
    /*
    txtFieldBudget.inputAccessoryView = keyboardDoneButtonView;
    
    txtFieldQuantity.inputAccessoryView = keyboardDoneButtonView;
    
    */
    
    if(_selectedRequirement)
    {
        [self updateRequirementDetails];
    }
    

    
    
}

-(void)updateRequirementDetails
{
    [self disableUIElements];
    isLoadMoreClicked = true;
    [self clkLoadMore:nil];
    
    btnSubmit.hidden = YES;
    
    arrayTblDict = nil;
    arrayTblDict = _selectedRequirement.arraySpecifications;
    [tblView reloadData];
    
    arraySelectedPreferredBrands = _selectedRequirement.arrayPreferedBrands;
    
    selectedGradeRequired = _selectedRequirement.gradeRequired;
    selectedDate = _selectedRequirement.requiredByDate;
    selectedState = _selectedRequirement.state;
    selectedTax = _selectedRequirement.taxType;
    
    /*
    
    switchPhysical.on = _selectedRequirement.isPhysical;
    switchChemical.on = _selectedRequirement.isChemical;
    switchCertReq.on = _selectedRequirement.isTestCertificateRequired;
    sgmtControlLenghtRequired.selectedSegmentIndex = [_selectedRequirement.length intValue];
    sgmtControlTypeRequired.selectedSegmentIndex = [_selectedRequirement.type intValue];
    
    [btnPreferedBrands setTitle:[NSString stringWithFormat:@"Prefered Brands : %@",[_selectedRequirement.arrayPreferedBrands componentsJoinedByString:@","]] forState:UIControlStateNormal];
    
    [btnGradeRequired setTitle:[NSString stringWithFormat:@"Grade Required : %@",_selectedRequirement.gradeRequired] forState:UIControlStateNormal];
    txtFieldCity.text = _selectedRequirement.city;
    txtFieldState.text = _selectedRequirement.state;
    txtFieldBudget.text = _selectedRequirement.budget;
    
    [btnRequiredByDate setTitle:[NSString stringWithFormat:@"Required by Date : %@",_selectedRequirement.requiredByDate] forState:UIControlStateNormal];
    
    [btnPreferedTax setTitle:[NSString stringWithFormat:@"Prefered Tax : %@",_selectedRequirement.taxType] forState:UIControlStateNormal];
    */
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isAccepted == %@", @YES];
    NSArray *filteredArray = [_selectedRequirement.arrayConversations filteredArrayUsingPredicate:predicate];
    
    if(filteredArray.count>0) {
        isAccepted = YES;
    }
    
    
    //update read status
    for(Conversation *conversation in _selectedRequirement.arrayConversations)
    {
        if(conversation.initialAmount.intValue>0 && conversation.isBuyerRead == false)
        {
            [_selectedRequirement updateBuyerReadStatus:conversation.sellerID withCompletion:^(NSDictionary *json, NSError *error) {

                [tblView reloadData];

            }];
        }
        else if(conversation.bargainAmount.intValue >= 0 && conversation.isBargainRequired == true && conversation.isBuyerReadBargain == false)
        {
            [_selectedRequirement updateBuyerReadBargainStatus:conversation.sellerID withCompletion:^(NSDictionary *json, NSError *error) {
                
                conversation.isBuyerReadBargain = true;
                [tblView reloadData];
            }];
        }
    }
    
    _selectedRequirement.isUnreadFlag = NO;
}

-(void)newUpdateReceived
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"requirementID == %@", _selectedRequirement.requirementID];
    NSArray *filteredArray = [model_manager.requirementManager.arrayPostedRequirements filteredArrayUsingPredicate:predicate];
    
    if(filteredArray.count>0) {
        _selectedRequirement = [filteredArray firstObject];
        
        [self updateRequirementDetails];
    }
}

-(void)viewDidLayoutSubviews
{
    [self.view setTranslatesAutoresizingMaskIntoConstraints:YES];
}


- (void)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}


-(void)disableUIElements
{
    /*
    tblViewSizes.userInteractionEnabled = NO;
    switchPhysical.userInteractionEnabled = NO;
    switchChemical.userInteractionEnabled = NO;
    switchCertReq.userInteractionEnabled = NO;
    sgmtControlLenghtRequired.userInteractionEnabled = NO;
    sgmtControlTypeRequired.userInteractionEnabled = NO;
    btnPreferedBrands.userInteractionEnabled = NO;
    btnGradeRequired.userInteractionEnabled = NO;
    txtFieldCity.userInteractionEnabled = NO;
    txtFieldState.userInteractionEnabled = NO;
    txtFieldBudget.userInteractionEnabled = NO;
    btnRequiredByDate.userInteractionEnabled = NO;
    btnPreferedTax.userInteractionEnabled = NO;
    */
    pickerToolBarView.userInteractionEnabled = NO;
    pickerPreferredBrandsView.userInteractionEnabled = NO;
    pickerGradeRequiredView.userInteractionEnabled = NO;
    datePickerView.userInteractionEnabled = NO;
    
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
    
    [pickerToolbar setBackgroundImage:[UIImage new]
                  forToolbarPosition:UIToolbarPositionAny
                          barMetrics:UIBarMetricsDefault];
    
    [pickerToolbar setBackgroundColor:kBlueColor];


    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneButtonPressed)];
    
    
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];

    
    [pickerToolbar setItems:@[flexSpace, doneBtn] animated:YES];
    
    [parentview addSubview:pickerToolbar];
}

-(void)createTableViewWithTag:(int)tag inView:(UIView*)parentview
{
    UITableView *tblViewSellerResponse=[[UITableView alloc]init];
    tblViewSellerResponse.frame=CGRectMake(0,44,self.view.frame.size.width, 216-44);
    [tblViewSellerResponse setDataSource: self];
    [tblViewSellerResponse setDelegate: self];
    tblViewSellerResponse.tag = tag;
    tblViewSellerResponse.backgroundColor = [UIColor whiteColor];
    
    
    [parentview addSubview:tblViewSellerResponse];
    
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    [pickerToolbar setBackgroundImage:[UIImage new]
                   forToolbarPosition:UIToolbarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
    [pickerToolbar setBackgroundColor:kBlueColor];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(tableDoneButtonPressed)];
    
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    
    [pickerToolbar setItems:@[flexSpace, doneBtn] animated:YES];
    
    [parentview addSubview:pickerToolbar];
}

-(void)createDatePickerWithTag:(int)tag inView:(UIView*)parentview
{
    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
    [datePicker setFrame:CGRectMake(0,0, self.view.frame.size.width,216)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.timeZone = [NSTimeZone localTimeZone];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.tag = tag;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:7];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];


    datePicker.minimumDate = minDate;
    
    [parentview addSubview:datePicker];
    
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    [pickerToolbar setBackgroundImage:[UIImage new]
                   forToolbarPosition:UIToolbarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
    [pickerToolbar setBackgroundColor:kBlueColor];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(datePickerDoneButtonPressed)];
    
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    
    [pickerToolbar setItems:@[flexSpace, doneBtn] animated:YES];
    
    [parentview addSubview:pickerToolbar];
}

-(void)datePickerDoneButtonPressed
{
    datePickerView.hidden = YES;
    UIDatePicker *datePicker = [datePickerView viewWithTag:444];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    selectedDate = [NSString stringWithFormat:@"%@",
                    [df stringFromDate:datePicker.date]];
    df = nil;
    
    [tblView reloadData];
   // [btnRequiredByDate setTitle:[NSString stringWithFormat:@"Required by Date : %@",selectedDate] forState:UIControlStateNormal];
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
    else if(pickerView.tag==333)
        return [arrayGradeRequired count];
    else if(pickerView.tag==555)
        return [arrayTaxes count];
    else if(pickerView.tag==777)
        return [arrayStates count];
    else
        return 0;
    
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag==111)
        return [NSString stringWithFormat:@"%@ mm",[[arraySteelSizes objectAtIndex: row] valueForKey:@"size"]];
    else if(pickerView.tag==333)
        return [[arrayGradeRequired objectAtIndex: row] valueForKey:@"grade"];
    else if(pickerView.tag==555)
        return [[arrayTaxes objectAtIndex: row] valueForKey:@"type"];
    else if(pickerView.tag==777)
        return [NSString stringWithFormat:@"%@ (%@)",[[arrayStates objectAtIndex: row] valueForKey:@"name"],[[arrayStates objectAtIndex: row] valueForKey:@"code"]];
    else
        return @"";
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView.tag==111)
    {
        NSLog(@"You selected this: %@", [[arraySteelSizes objectAtIndex: row] valueForKey:@"size"]);
        selectedDiameter = [NSString stringWithFormat:@"%@ mm",[[arraySteelSizes objectAtIndex: row] valueForKey:@"size"]];
    }
    else if(pickerView.tag==333)
    {
        NSLog(@"You selected this: %@", [[arrayGradeRequired objectAtIndex: row] valueForKey:@"grade"]);
        selectedGradeRequired = [[arrayGradeRequired objectAtIndex: row] valueForKey:@"grade"];
        selectedGradeID = [[arrayGradeRequired objectAtIndex: row] valueForKey:@"id"];
        
    }
    else if(pickerView.tag==555)
    {
        NSLog(@"You selected this: %@", [[arrayTaxes objectAtIndex: row] valueForKey:@"type"]);
        selectedTax = [[arrayTaxes objectAtIndex: row] valueForKey:@"type"];
        selectedTaxID = [[arrayTaxes objectAtIndex: row] valueForKey:@"id"];
    }
    else if(pickerView.tag==777)
    {
        NSLog(@"You selected this: %@", [[arrayStates objectAtIndex: row] valueForKey:@"name"]);
        selectedState = [[arrayStates objectAtIndex: row] valueForKey:@"name"];
    }
    
}

-(void)pickerDoneButtonPressed
{
    pickerToolBarView.hidden = YES;
    if(selectedDiameter.length>0)
    {
        
        selectedDiameterTextfield.text = selectedDiameter;
        
        // getting indexpath from selected button
        CGPoint center= selectedDiameterTextfield.center;
        CGPoint rootViewPoint = [selectedDiameterTextfield.superview convertPoint:center toView:tblView];
        NSIndexPath *indexPath = [tblView indexPathForRowAtPoint:rootViewPoint];
        
        HomeQuantityCell *cell = [tblView cellForRowAtIndexPath:indexPath];
        [cell.txtQuantity becomeFirstResponder];
        
        [[arrayTblDict objectAtIndex:indexPath.row] setValue:selectedDiameter forKey:@"size"];
        
        selectedDiameter = @"";
    }
    
    pickerGradeRequiredView.hidden = YES;
    if(selectedGradeRequired.length>0)
    {
        //[btnGradeRequired setTitle:[NSString stringWithFormat:@"Grade Required : %@",selectedGradeRequired] forState:UIControlStateNormal];
    }
    
    pickerTaxView.hidden = YES;
    if(selectedTax.length>0)
    {
        //[btnPreferedTax setTitle:[NSString stringWithFormat:@"Prefered Tax : %@",selectedTax] forState:UIControlStateNormal];
    }
    
    pickerViewState.hidden = YES;
    if(selectedState.length>0)
    {
        //txtFieldState.text = [selectedState capitalizedString];
    }
    
    [tblView reloadData];
}

- (CGFloat)getLabelHeight:(UIButton *)btn
{
    CGSize constraint = CGSizeMake(btn.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSLog(@"string : %@",btn.titleLabel.text);
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [btn.titleLabel.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:btn.titleLabel.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    
    NSLog(@"string size: %f",size.height);

    return size.height + 3;
}

-(void)tableDoneButtonPressed
{
    pickerGradeRequiredView.hidden = YES;
    pickerPreferredBrandsView.hidden = YES;
    
    
    if(arraySelectedPreferredBrands.count>0)
    {
        
       // [btnPreferedBrands setTitle:[NSString stringWithFormat:@"Prefered Brands : %@",[arraySelectedPreferredBrands componentsJoinedByString:@", "]] forState:UIControlStateNormal];
        
       //contraintBrandsLbl.constant =  [self getLabelHeight:btnPreferedBrands];
        
        //NSString *myString = btnPreferedBrands.titleLabel.text;
        
        
       // CGSize stringsize = [myString sizeWithFont:[UIFont fontWithName:@"Raleway-Regular" size:15]];
        //NSLog(@"string size: %f",stringsize.height);

        
    }
 
    [tblView reloadData];
}


#pragma mark table view data sources and delegates

    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        
        if(tableView == tblView)
        return 3;
        
        else if(tableView.tag == 222)
        return 1;
        
        return 0;
    }
    

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 222)
        return arrayPreferredBrands.count;
    
    
    switch (section)
    {
        case 0:
        
        if (_selectedRequirement) {
            return arrayTblDict.count;
        }
        return arrayTblDict.count+1;
        
        break;
        case 1:
        return 1;
        break;
        
        case 2:
        return _selectedRequirement.arrayConversations.count;
        break;
        
        default:
        break;
    }
    
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag == 222)
    {
        static NSString *_simpleTableIdentifier = @"CellIdentifier";
        
        UITableViewCell *cell = (UITableViewCell*)[tblView dequeueReusableCellWithIdentifier:_simpleTableIdentifier];
        
        // Configure the cell...
        if(cell==nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_simpleTableIdentifier];
            
        }
        
        cell.textLabel.text = [[arrayPreferredBrands objectAtIndex:indexPath.row] valueForKey:@"brand_name"];
        
        
        if ([arraySelectedPreferredBrands containsObject:[[arrayPreferredBrands objectAtIndex:indexPath.row] valueForKey:@"brand_name"]])
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
    
    
    switch (indexPath.section) {
        
        case 0:
        {
        if((indexPath.row == arrayTblDict.count) &&  !_selectedRequirement)
        {
            HomeAddMoreCell *cell = (HomeAddMoreCell *)[tblView dequeueReusableCellWithIdentifier:@"HomeAddMoreCell"];
            if (!cell) {
                cell = [[HomeAddMoreCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"HomeAddMoreCell"];
            }
        
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        else
        {
            HomeQuantityCell *cell = (HomeQuantityCell *)[tblView dequeueReusableCellWithIdentifier:@"HomeQuantityCell"];
            
            if(_selectedRequirement)
                cell.userInteractionEnabled = NO;

            
            NSArray *arrayRightBtns = [self rightButtons];
            [cell setRightUtilityButtons:arrayRightBtns WithButtonWidth:70];
            [cell setDelegate:self];
            
            cell.txtSize.text = [[arrayTblDict objectAtIndex:indexPath.row] valueForKey:@"size"];
            cell.txtQuantity.text = [[arrayTblDict objectAtIndex:indexPath.row] valueForKey:@"quantity"];
            
            
            cell.txtQuantity.inputAccessoryView = keyboardDoneButtonView;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
        
        return [UITableViewCell new];
        break;
        }
        
        case 1:
        {
            HomeProductDetailCell *cell = (HomeProductDetailCell *)[tblView dequeueReusableCellWithIdentifier:@"HomeProductDetailCell"];
            
            if(_selectedRequirement)
                cell.userInteractionEnabled = NO;
            
            cell.switchPhysical.transform = CGAffineTransformMakeScale(0.8, 0.8);
            cell.switchPhysical.onTintColor = kBlueColor;
            cell.switchPhysical.on = newRequirement.isPhysical;
            
            cell.switchChemical.transform = CGAffineTransformMakeScale(0.8, 0.8);
            cell.switchChemical.onTintColor = kBlueColor;
            cell.switchChemical.on =  newRequirement.isChemical;

            
            cell.switchCertReq.transform = CGAffineTransformMakeScale(0.8, 0.8);
            cell.switchCertReq.onTintColor = kBlueColor;
            cell.switchCertReq.on =  newRequirement.isTestCertificateRequired;
            
            cell.sgmtControlLenghtRequired.selectedSegmentIndex = [newRequirement.length intValue];
            cell.sgmtControlTypeRequired.selectedSegmentIndex = [newRequirement.type intValue];

            
            cell.lblGraderequired.text = [NSString stringWithFormat:@"Grade Required : %@",selectedGradeRequired];
            cell.lblPreferedTax.text = [NSString stringWithFormat:@"Prefered Tax : %@",selectedTax];
            cell.txtDeliveryCity.text = [NSString stringWithFormat:@"Delivery City : %@",[newRequirement.city capitalizedString]];
            cell.lblDeliveryState.text = [NSString stringWithFormat:@"State : %@",[selectedState capitalizedString]];
            
            cell.txtBudget.text = [NSString stringWithFormat:@"Budget Amount (Rs) : %@",newRequirement.budget];
            
            if(arraySelectedPreferredBrands.count>0)
                cell.lblPreferedBrands.text = [NSString stringWithFormat:@"Prefered Brands : %@",[arraySelectedPreferredBrands componentsJoinedByString:@", "]];
            else
                cell.lblPreferedBrands.text = [NSString stringWithFormat:@"Prefered Brands :"];
            
            cell.lblRequiredByDate.text = [NSString stringWithFormat:@"Required by Date : %@",selectedDate];
            
            
            cell.txtBudget.inputAccessoryView = keyboardDoneButtonView;
            
            return cell;
            break;
            
        }
        
        case 2:
        {
            
            Home_SellerResponse *cell = (Home_SellerResponse *)[tblView dequeueReusableCellWithIdentifier:@"Home_SellerResponse"];
            
            Conversation *currentRow = [_selectedRequirement.arrayConversations objectAtIndex:indexPath.row];
            
            cell.lblSellerName.text = [NSString stringWithFormat:@"Seller : %@", currentRow.sellerName];
            cell.lblAmount.text = [NSString stringWithFormat:@"Quotation Amount : Rs %@",currentRow.initialAmount];
            cell.lblBrands.text = [NSString stringWithFormat:@"Brands : %@",[currentRow.arrayBrands componentsJoinedByString:@","]];
            
            if(currentRow.isBargainRequired && currentRow.bargainAmount.intValue > 0)
            cell.lblBargainStatus.text = [NSString stringWithFormat:@"Bargain Amount : Rs %@",currentRow.bargainAmount];
            else if(currentRow.isBargainRequired && currentRow.bargainAmount.intValue == 0)
                cell.lblBargainStatus.text = [NSString stringWithFormat:@"Already gave you best price"];
            else if(currentRow.isBargainRequired)
            cell.lblBargainStatus.text = [NSString stringWithFormat:@"Bargain Requested"];
            else
            cell.lblBargainStatus.text = [NSString stringWithFormat:@"Slide left to view more options"];
            
            
            cell.lblSellerName.font = fontRaleway13;
            cell.lblAmount.font = fontRaleway13;
            cell.lblBrands.font = fontRaleway13;
            
            cell.imgViewStatus.hidden = true;
            
            if(currentRow.isAccepted)
            {
                
                cell.imgViewStatus.backgroundColor = GreenColor
                cell.imgViewStatus.hidden = false;
                cell.imgviewStatus.image = [UIImage imageNamed:@"green_bubble.png"];
            }
            else if(!currentRow.isBuyerRead)
            {
                cell.imgViewStatus.backgroundColor = RedColor
                
                cell.lblSellerName.font = fontRalewayBold12;
                cell.lblAmount.font = fontRalewayBold12;
                cell.lblBrands.font = fontRalewayBold12;
                
            }
            else if(!currentRow.isBuyerReadBargain && currentRow.isBargainRequired)
            {
                cell.imgViewStatus.backgroundColor = OrangeColor
                cell.imgViewStatus.hidden = false;
                cell.imgviewStatus.image = [UIImage imageNamed:@"orange_purple.png"];
                
            }
            else if(currentRow.isBuyerReadBargain && currentRow.isBargainRequired)
            {
                cell.imgViewStatus.backgroundColor = PurpleColor
                cell.imgViewStatus.hidden = false;
                cell.imgviewStatus.image = [UIImage imageNamed:@"purple_bubble.png"];
                
                cell.lblSellerName.font = fontRalewayBold12;
                cell.lblAmount.font = fontRalewayBold12;
                cell.lblBrands.font = fontRalewayBold12;
            }
            else
            {
                cell.imgViewStatus.backgroundColor = kBlueColor;
            }
            
            cell.lblBargainStatus.textColor =  cell.imgViewStatus.backgroundColor;
            
            if(isAccepted==false)
            {
                NSArray *arrayRightBtns = [self tblSellerResponseRightButtons];
                [cell setRightUtilityButtons:arrayRightBtns WithButtonWidth:70];
                [cell setDelegate:self];
            }
            else
            {
                [cell setRightUtilityButtons:nil WithButtonWidth:0];
                [cell setDelegate:nil];
            }
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
            
            break;
        }
        
        default:
        break;
    }
    
    
    

    
    
    
    
    return [UITableViewCell new];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblView)
    {
        NSLog(@"Table row clicked");
        
        if(_selectedRequirement)
        {
            OrderConfirmation *orderConfirmation = [kMainStoryboard instantiateViewControllerWithIdentifier:@"orderconfirmation"];
            
            orderConfirmation.selectedRequirement = self.selectedRequirement;
            
            orderConfirmation.selectedConversation = [self.selectedRequirement.arrayConversations objectAtIndex:indexPath.row];
            
            [self.navigationController pushViewController:orderConfirmation animated:YES];
        }         
    }
    
    else if(tableView.tag==222)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        //the below code will allow multiple selection
        if ([arraySelectedPreferredBrands containsObject:[[arrayPreferredBrands objectAtIndex:indexPath.row] valueForKey:@"brand_name"]])
        {
            [arraySelectedPreferredBrands removeObject:[[arrayPreferredBrands objectAtIndex:indexPath.row] valueForKey:@"brand_name"]];
        }
        else
        {
            [arraySelectedPreferredBrands addObject:[[arrayPreferredBrands objectAtIndex:indexPath.row] valueForKey:@"brand_name"]];
        }
        [tableView reloadData];
    }
    
    else
    {
        
    }
}




#pragma mark - Swipe Cell Delegate
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}

- (NSArray *)tblSellerResponseRightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:255/255.00 green:165/255.00 blue:0/255.00 alpha:1]
                                                title:@"Bargain"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:40/255.00 green:157/255.00 blue:87/255.00 alpha:1]
                                                title:@"Accept"];
    
    return rightUtilityButtons;
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
            // delete button is pressed
            if ([cell isKindOfClass:[Home_SellerResponse class]])
            {
                NSLog(@"bargain clicked");
                NSIndexPath *indexPath;
                indexPath = [tblView indexPathForCell:cell];
                
                if(((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).bargainAmount.intValue==0 && ((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).isBargainRequired == NO)
                {
                    [SVProgressHUD show];
                    [_selectedRequirement postBargainForSeller:((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).sellerID withCompletion:^(NSDictionary *json, NSError *error) {
                        [SVProgressHUD dismiss];
                        if(json)
                        {
                            ((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).isBargainRequired = YES;
                            
                            ((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).isBuyerRead = true;
                            
                            [tblView reloadData];
                            
                        }
                        else
                        {
                            [self showAlert:@"Some error occured. Please try again"];
                        }
                    }];
                }
            }
            else
            {
                if(arrayTblDict.count>1)
                {
                    NSIndexPath *indexPath;
                    indexPath = [tblView indexPathForCell:cell];
                    
                    [arrayTblDict removeObjectAtIndex:indexPath.row];
                    
                    [tblView reloadData]; // tell table to refresh now
                    //lbl.frame = CGRectMake(10,20,self.view.frame.size.width-20,contentView.frame.size.height-65);
                    
                }
                
            }
            
            break;
        }
        case 1:
        {
            if ([cell isKindOfClass:[Home_SellerResponse class]])
            {
                NSLog(@"Accpet CLicked");
                NSIndexPath *indexPath;
                indexPath = [tblView indexPathForCell:cell];
                
                if(!((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).isAccepted)
                {
                    [SVProgressHUD show];
                    [_selectedRequirement acceptRejectDeal:((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).sellerID status:YES withCompletion:^(NSDictionary *json, NSError *error)
                    {
                        [SVProgressHUD dismiss];
                        
                        if(json)
                        {
                            ((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).isAccepted = YES;
                            
                             ((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).isBuyerRead = true;
                            
                            [tblView reloadData];
                            
                            [self pushToAddressScreen:[json valueForKey:@"order_id"] seller:((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).sellerID];
                        }
                        else
                        {
                            [self showAlert:@"Some error occured. Please try again"];
                        }
                    }];
                }
            }
            
            break;
            
        }
            
        default: break;
    }
}

-(void)pushToAddressScreen:(NSString*)orderID seller:(NSString *)sellerId
{
    OrderI *order = [OrderI new];
    order.orderID = orderID;
    order.sellerID = sellerId;
    order.req = _selectedRequirement;
    
    PickAddressVC *viewcontroller = [shippingStoryboard instantiateViewControllerWithIdentifier: @"pickAddress"];
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    viewcontroller.isFromMenu = NO;
    viewcontroller.selectedOrder = order;
    [navigationController pushViewController:viewcontroller animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Methods
- (IBAction)clkAddMore:(UIButton *)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"size",@"",@"quantity", nil];
    [arrayTblDict addObject:dict];
    
    [tblView reloadData];
}

- (IBAction)isSwithToggeled:(UISwitch *)sender {
    
    
    switch (sender.tag)
    {
        case 1:
            NSLog(@"switch 1 off");
            newRequirement.isPhysical = sender.isOn;
            break;
        case 2:
            NSLog(@"switch 2 off");
            newRequirement.isChemical = sender.isOn;
            break;
        case 3:
            NSLog(@"switch 3 off");
            newRequirement.isTestCertificateRequired = sender.isOn;
            break;
            
        default:
            break;
    }
}


- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    switch (sender.tag)
    {
        case 111:
            NSLog(@"length changes");
            newRequirement.length = [NSString stringWithFormat:@"%li", (long)sender.selectedSegmentIndex];
            break;
        case 222:
            NSLog(@"type changes");
            newRequirement.type = [NSString stringWithFormat:@"%li", (long)sender.selectedSegmentIndex];
            break;
            
        default:
            break;
    }
}


-(IBAction)clkLoadMore:(id)sender
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    if (isLoadMoreClicked)
    {
        isLoadMoreClicked = false;
        //viewCustom.hidden = YES;
        [btnLoadMore setTitle:@"Show More" forState:UIControlStateNormal];
        
    }
    else
    {
        isLoadMoreClicked = true;
        //viewCustom.hidden = NO;
        [btnLoadMore setTitle:@"Show Less" forState:UIControlStateNormal];
        
    }
    
    [UIView commitAnimations];
    
    
    
}

/*
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
 */



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

#pragma Mark - TextFiled Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    actifText = nil;
    
    CGPoint center= textField.center;
    CGPoint rootViewPoint = [textField.superview convertPoint:center toView:tblView];
    NSIndexPath *indexPath = [tblView indexPathForRowAtPoint:rootViewPoint];
    
    switch (indexPath.section) {
        case 0:
        {
            HomeQuantityCell *cell = [tblView cellForRowAtIndexPath:indexPath];

            if(cell.txtQuantity.tag == 786)
            {
                [[arrayTblDict objectAtIndex:indexPath.row] setValue:textField.text forKey:@"quantity"];
            }
        }
            break;
        case 1:
        {
            HomeProductDetailCell *cell = [tblView cellForRowAtIndexPath:indexPath];
            if (textField == cell.txtDeliveryCity)
            {
                if(textField.text.length == 0)
                {
                    textField.text = @"Delivery City : ";
                    newRequirement.city = @"";
                }
                else
                {
                    newRequirement.city = [textField.text substringFromIndex:16];
                }
            }
            
            else if (textField == cell.txtBudget)
            {
                if(textField.text.length == 0)
                {
                    textField.text = @"Budget Amount (Rs) : ";
                    newRequirement.budget = @"";
                }
                else
                {                    
                    newRequirement.budget = [textField.text substringFromIndex:21];
                }
                    
                
            }
            
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }


    /*
    else if (textField == txtFieldState)
    {
        if(txtFieldState.text.length == 0)
            lbState.text = @"   State :";
        
    }
     */

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    if(textField.tag==777)
    {
        [textField resignFirstResponder];
    }
    else{
        
        actifText = textField;
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
    {
        CGPoint center= textField.center;
        CGPoint rootViewPoint = [textField.superview convertPoint:center toView:tblView];
        NSIndexPath *indexPath = [tblView indexPathForRowAtPoint:rootViewPoint];
        
        switch (indexPath.section) {
            case 0:
            {
                if(textField.tag == 777)
                {
                    [self.view endEditing:YES];
                    
                    pickerToolBarView.hidden = NO;
                    [self.view bringSubviewToFront:pickerToolBarView];
                    
                    selectedDiameter = [NSString stringWithFormat:@"%@ mm",[[arraySteelSizes objectAtIndex: 0] valueForKey:@"size"]];
                    
                    UIPickerView *pickerView = [pickerToolBarView viewWithTag:111];
                    
                    
                    [pickerView selectRow:0 inComponent:0 animated:NO];
                    
                    
                    selectedDiameterTextfield = textField;
                    [textField resignFirstResponder];
                }
            }
                break;
            case 1:
            {
                HomeProductDetailCell *cell = [tblView cellForRowAtIndexPath:indexPath];
                
                 if (textField == cell.txtDeliveryCity)
                {
                    textField.text = @"Delivery City : ";
                }
                else if (textField == cell.txtBudget)
                {
                    textField.text = @"Budget Amount (Rs) : ";
                }
            }
                break;

            default:
                break;
        }
        
        
        return YES;
    }

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    
    CGPoint center= textField.center;
    CGPoint rootViewPoint = [textField.superview convertPoint:center toView:tblView];
    NSIndexPath *indexPath = [tblView indexPathForRowAtPoint:rootViewPoint];
    
    switch (indexPath.section) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            HomeProductDetailCell *cell = [tblView cellForRowAtIndexPath:indexPath];
            if (textField == cell.txtDeliveryCity)
            {
                NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
                return !([newString length] < 16);
                
            }
            else if (textField == cell.txtBudget)
            {
                NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
                return !([newString length] < 21);
            }
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }

    return YES;
}

/*
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
*/

#pragma mark Keyboard
-(void)showKeyboard:(NSNotification*)notification
{
    NSLog(@"Keyboard shown");
    
    //NSDictionary *info = [notification userInfo];
    //CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    //UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, kbSize.height, 0);
    //_scrollView.contentInset = contentInsets;
    //_scrollView.scrollIndicatorInsets = contentInsets;
    
    
    // Get the keyboard size
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue: &keyboardBounds];
    
    // Detect orientation
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect frame = tblView.frame;
    
    // Start animation
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:0.3f];
    
    // Reduce size of the Table view
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        frame.size.height -= keyboardBounds.size.height;
    else
        frame.size.height -= keyboardBounds.size.width;
    
    // Apply new size of table view
    tblView.frame = frame;
    
    // Scroll the table view to see the TextField just above the keyboard
    if (actifText)
    {
        CGRect textFieldRect = [tblView convertRect:actifText.bounds fromView:actifText];
        [tblView scrollRectToVisible:textFieldRect animated:NO];
    }
    
    //[UIView commitAnimations];
    
    
}
-(void)hideKeyboard:(NSNotification*)notification
{
    NSLog(@"Keyboard hidden");
    //UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0,0, 0);
    //_scrollView.contentInset = contentInsets;
    //_scrollView.scrollIndicatorInsets = contentInsets;
    
    // Get the keyboard size
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue: &keyboardBounds];
    
    // Detect orientation
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect frame = tblView.frame;
    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:0.3f];
    
    // Increase size of the Table view
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        frame.size.height += keyboardBounds.size.height;
    else
        frame.size.height += keyboardBounds.size.width;
    

    if(keyboardBounds.size.height == 0)
    {
        frame.size.height += 299;
    }
    
    // Apply new size of table view
    tblView.frame = frame;
    
    //[UIView commitAnimations];
    
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */





- (IBAction)submitBtnAction:(UIButton *)sender {
    
    for(int i=0 ; i < arrayTblDict.count ;i++)
    {
        if([[[[arrayTblDict objectAtIndex:i] valueForKey:@"size"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
        {
            [self showAlert:@"Please enter diameter size"];
            return;
        }
        
        else if([[[[arrayTblDict objectAtIndex:i] valueForKey:@"quantity"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
        {
            [self showAlert:@"Please enter quantity"];
            return;
        }
    }
    
    if(arrayTblDict.count==0)
    {
        [self showAlert:@"Please enter specification"];
    }
    else if(selectedGradeRequired.length==0)
    {
        [self showAlert:@"Please select grade"];
    }
    
    else if([[selectedDate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [self showAlert:@"Please enter required by date"];
    }
    else if([[newRequirement.city stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [self showAlert:@"Please enter city"];
    }
    else if([[selectedState stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [self showAlert:@"Please enter state"];
    }
    else if([[newRequirement.budget stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [self showAlert:@"Please enter budget"];
    }
    
    else if(selectedTax.length==0)
    {
        [self showAlert:@"Please select tax category"];
    }
    else
    {
        newRequirement.arraySpecifications = arrayTblDict;
        newRequirement.state = selectedState;
        newRequirement.requiredByDate = selectedDate;
        newRequirement.taxType = selectedTaxID;
        newRequirement.gradeRequired = selectedGradeID;
        newRequirement.arrayPreferedBrands = arraySelectedPreferredBrands;

        
        /*
        newRequirement.isChemical = switchChemical.isOn;
        newRequirement.isPhysical = switchPhysical.isOn;
        newRequirement.isTestCertificateRequired = switchCertReq.isOn;
        newRequirement.length = [NSString stringWithFormat:@"%li", (long)sgmtControlLenghtRequired.selectedSegmentIndex];
        newRequirement.type = [NSString stringWithFormat:@"%li", (long)sgmtControlTypeRequired.selectedSegmentIndex];
        
        
        */
        [SVProgressHUD show];
        
        [model_manager.requirementManager postRequirement:newRequirement completion:^(NSDictionary *json, NSError *error) {
            [SVProgressHUD dismiss];
            if(json)
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self showAlert:@"Some error occured. Please try again"];
            }
        }];
    }
}





-(void)showAlert:(NSString *)errorMsg
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:errorMsg
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             //   [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    
}
    
   
#pragma mark - Tap Gestures
    
- (IBAction)clkPreferedBrands:(UITapGestureRecognizer *)sender {
    
    pickerPreferredBrandsView.hidden = NO;
    [self.view bringSubviewToFront:pickerPreferredBrandsView];
    
    //UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 216, 0);
    //_scrollView.contentInset = contentInsets;
    //_scrollView.scrollIndicatorInsets = contentInsets;
    
    [self.view endEditing:YES];
}
    
- (IBAction)clkGradeRequired:(UITapGestureRecognizer *)sender
    {
    pickerGradeRequiredView.hidden = NO;
    [self.view bringSubviewToFront:pickerGradeRequiredView];
    selectedGradeRequired = [[arrayGradeRequired objectAtIndex: 0] valueForKey:@"grade"];
    selectedGradeID = [[arrayGradeRequired objectAtIndex: 0] valueForKey:@"id"];
    
    
    UIPickerView *pickerView = [pickerGradeRequiredView viewWithTag:333];
    
    [pickerView selectRow:0 inComponent:0 animated:NO];
    
    //UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 216, 0);
    //_scrollView.contentInset = contentInsets;
    //_scrollView.scrollIndicatorInsets = contentInsets;
    
    [self.view endEditing:YES];

}
    
- (IBAction)clkRequiredByDate:(UITapGestureRecognizer *)sender {
    datePickerView.hidden = NO;
    [self.view bringSubviewToFront:datePickerView];
    
    //UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 216, 0);
    //_scrollView.contentInset = contentInsets;
    //_scrollView.scrollIndicatorInsets = contentInsets;
    [self.view endEditing:YES];
    
    }
    
- (IBAction)clkState:(UITapGestureRecognizer *)sender {
    //lbState.text = @"   State :";
    //[txtFieldState resignFirstResponder];
    [self.view endEditing:YES];
    pickerViewState.hidden = NO;
    [self.view bringSubviewToFront:pickerViewState];
    
    if(arrayStates.count>0)
    selectedState = [NSString stringWithFormat:@"%@",[[arrayStates objectAtIndex: 0] valueForKey:@"name"]];
    
    UIPickerView *pickerView = [pickerViewState viewWithTag:777];
    
    [pickerView selectRow:0 inComponent:0 animated:NO];

}
    
- (IBAction)clkPreferedTax:(UITapGestureRecognizer *)sender {
    
    pickerTaxView.hidden = NO;
    [self.view bringSubviewToFront:pickerTaxView];
    
    selectedTax = [NSString stringWithFormat:@"%@",[[arrayTaxes objectAtIndex: 0] valueForKey:@"type"]];
    selectedTaxID = [NSString stringWithFormat:@"%@",[[arrayTaxes objectAtIndex: 0] valueForKey:@"id"]];
    
    UIPickerView *pickerView = [pickerTaxView viewWithTag:555];
    
    [pickerView selectRow:0 inComponent:0 animated:NO];
    
    [self.view endEditing:YES];
    
}


@end
