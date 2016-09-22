//
//  Home.m
//  Sourcefuse
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 Sourcefuse. All rights reserved.
//

#import "Home.h"
#import "HomeCell.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"
#import "Home_SellerResponse.h"    //TableviewCell
//#import <GoogleMaps/GoogleMaps.h>
#import "RequirementI.h"
#import "Conversation.h"

@interface Home ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,SWTableViewCellDelegate>
{
    __weak IBOutlet UITableView *tblSellerResponse;
    
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
    
    __weak IBOutlet UIButton *btnRequiredByDate;
    
    __weak IBOutlet UIButton *btnPreferedTax;
    
    
    
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
    NSString *selectedGradeRequired;
    NSString *selectedGradeID;
    
    
    UIView *datePickerView;
    NSString *selectedDate;
    
    UIView *pickerTaxView;
    NSMutableArray *arrayTaxes;
    NSString *selectedTax;
    NSString *selectedTaxID;
    
    UILabel *lbCity,*lbState,*lbAmount;
    
    UIView *pickerViewState;
    NSMutableArray *arrayStates;
    NSString *selectedState;

    
    //for content view border
    UILabel *lbl;
    
    __weak IBOutlet UITextField *txtFieldQuantity;
    
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet NSLayoutConstraint *tblViewHeightConstraint;
    __weak IBOutlet NSLayoutConstraint *scrollContentViewHeightConstraint;
    
    //Array seller Response
    
    __weak IBOutlet UIView *viewCustom;
    __weak IBOutlet NSLayoutConstraint *sellerReponseHeightConstraint;
    __weak IBOutlet NSLayoutConstraint *customViewHeightConstarint;
    __weak IBOutlet UIButton *btnLoadMore;
    
    BOOL isLoadMoreClicked;
    
    BOOL isAccepted;
}

- (IBAction)preferedBrandsBtnAction:(UIButton *)sender;
- (IBAction)gradeRequiredBtnAction:(UIButton *)sender;
- (IBAction)submitBtnAction:(UIButton *)sender;
- (IBAction)requiredByDateBtnAction:(UIButton *)sender;
- (IBAction)preferedTaxBtnAction:(UIButton *)sender;

- (IBAction)clkLoadMore:(UIButton *)sender;

@end

@implementation Home

-(void)viewWillAppear:(BOOL)animated
{
    
    [self setMarginBoundary];
    
}

-(void)setMarginBoundary
{
    float requirment =_selectedRequirement.arrayConversations.count * 44;
    float sellerResponse =arrayTblDict.count * 70;
    float costantheight = 0;
    if (isLoadMoreClicked) {
        costantheight = 404;
    }
    
    float combineHeight = requirment+ sellerResponse+costantheight+100;
    lbl.frame = CGRectMake(10,20,self.view.frame.size.width-20, combineHeight);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    isLoadMoreClicked = false;
    [self clkLoadMore:nil];
    
    isAccepted = NO;
    //La
    lbl = [[UILabel alloc]init];
    
    lbl.frame = CGRectMake(10,20,self.view.frame.size.width-20,contentView.frame.size.height-180+ btnLoadMore.frame.size.height + tblSellerResponse.frame.size.height );
    
    
    //lblBorderColor.backgroundColor = kBlueColor;
    lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    lbl.layer.borderWidth = 1.0;
    [contentView addSubview:lbl];
    
    
    //switch controlls reframe
    switchPhysical.transform = CGAffineTransformMakeScale(0.8, 0.8);
    switchPhysical.onTintColor = kBlueColor
    
    switchChemical.transform = CGAffineTransformMakeScale(0.8, 0.8);
    switchChemical.onTintColor = kBlueColor
    
    switchCertReq.transform = CGAffineTransformMakeScale(0.8, 0.8);
    switchCertReq.onTintColor = kBlueColor
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardDidHideNotification object:nil ];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil ];
    
    if(_selectedRequirement)
    {
        [self setTitleLabel:@"ORDER DETAILS"];
    }
    else
        [self setTitleLabel:@"NEW REQUIREMENT"];
    
    [self setMenuButton];
    [self setBackButton];
    
    
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
    
    
    //    btnGradeRequired.titleLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:15];
    //    btnPreferedBrands.titleLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:15];
    //    btnRequiredByDate.titleLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:15];
    
    
    
    
    
    arrayTblDict = [NSMutableArray new];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"size",@"",@"quantity", nil];
    [arrayTblDict addObject:dict];
    
    tblViewSizes.dataSource = self;
    tblViewSizes.delegate = self;
    tblViewHeightConstraint.constant = (arrayTblDict.count+1)*44;
    [tblViewSizes reloadData];
    
    
    
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
            UITableView *tblView = [pickerPreferredBrandsView viewWithTag:222];
            [tblView reloadData];
            
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
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleBlackOpaque;
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(doneClicked:)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexSpace,doneButton, nil]];
    txtFieldBudget.inputAccessoryView = keyboardDoneButtonView;
    
    txtFieldQuantity.inputAccessoryView = keyboardDoneButtonView;
    
    
    if(_selectedRequirement)
    {
        [self disableUIElements];
        isLoadMoreClicked = true;
        [self clkLoadMore:nil];
        
        [arrayTblDict removeAllObjects];
        arrayTblDict = _selectedRequirement.arraySpecifications;
        tblViewHeightConstraint.constant = (arrayTblDict.count+1)*44 + 5;
        scrollContentViewHeightConstraint.constant = scrollContentViewHeightConstraint.constant + tblViewHeightConstraint.constant - 150;
        [tblViewSizes reloadData];
        
        if(_selectedRequirement.arrayConversations.count>0)
        {
            sellerReponseHeightConstraint.constant = (_selectedRequirement.arrayConversations.count+1)*70 + 5;
            scrollContentViewHeightConstraint.constant = scrollContentViewHeightConstraint.constant + sellerReponseHeightConstraint.constant - 75;
            
            [tblSellerResponse reloadData];
        }
        
        lbl.frame = CGRectMake(10,20,self.view.frame.size.width-20,contentView.frame.size.height-65);
        
        
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
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isAccepted == %@", @YES];
        NSArray *filteredArray = [_selectedRequirement.arrayConversations filteredArrayUsingPredicate:predicate];
        
        if(filteredArray.count>0) {
            isAccepted = YES;
        }
    }
    
    
    
    
    //update read status
    for(Conversation *conversation in _selectedRequirement.arrayConversations)
    {
        if(conversation.initialAmount.intValue>0 && conversation.isBuyerRead == false)
        {
            [_selectedRequirement updateBuyerReadStatus:conversation.sellerID withCompletion:^(NSDictionary *json, NSError *error) {
                
            }];
        }
        else if(conversation.bargainAmount.intValue>0 && conversation.isBargainRequired == true && conversation.isBuyerReadBargain ==false)
        {
            [_selectedRequirement updateBuyerReadBargainStatus:conversation.sellerID withCompletion:^(NSDictionary *json, NSError *error) {
                
            }];
        }
    }
    
    _selectedRequirement.isUnreadFlag = NO;
}

- (void)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}


-(void)disableUIElements
{
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
    pickerToolBarView.userInteractionEnabled = NO;
    pickerPreferredBrandsView.userInteractionEnabled = NO;
    pickerGradeRequiredView.userInteractionEnabled = NO;
    datePickerView.userInteractionEnabled = NO;
    btnPreferedTax.userInteractionEnabled = NO;
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

-(void)createDatePickerWithTag:(int)tag inView:(UIView*)parentview
{
    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
    [datePicker setFrame:CGRectMake(0,0, self.view.frame.size.width,216)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.timeZone = [NSTimeZone localTimeZone];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.tag = tag;
    
    
    [parentview addSubview:datePicker];
    
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(datePickerDoneButtonPressed)];
    
    
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
    
    [btnRequiredByDate setTitle:[NSString stringWithFormat:@"Required by Date : %@",selectedDate] forState:UIControlStateNormal];
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
        CGPoint rootViewPoint = [selectedDiameterTextfield.superview convertPoint:center toView:tblViewSizes];
        NSIndexPath *indexPath = [tblViewSizes indexPathForRowAtPoint:rootViewPoint];
        
        HomeCell *cell = [tblViewSizes cellForRowAtIndexPath:indexPath];
        [cell.txtFieldQuantity becomeFirstResponder];
        
        [[arrayTblDict objectAtIndex:indexPath.row] setValue:selectedDiameter forKey:@"size"];
        
        selectedDiameter = @"";
    }
    
    pickerGradeRequiredView.hidden = YES;
    if(selectedGradeRequired.length>0)
    {
        [btnGradeRequired setTitle:[NSString stringWithFormat:@"Grade Required : %@",selectedGradeRequired] forState:UIControlStateNormal];
        //selectedGradeRequired = @"";
    }
    
    pickerTaxView.hidden = YES;
    if(selectedTax.length>0)
    {
        [btnPreferedTax setTitle:[NSString stringWithFormat:@"Prefered Tax : %@",selectedTax] forState:UIControlStateNormal];
        //selectedTax = @"";
    }
    
    pickerViewState.hidden = YES;
    if(selectedState.length>0)
    {
        txtFieldState.text = [selectedState capitalizedString];
    }
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 0, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
}

-(void)tableDoneButtonPressed
{
    pickerGradeRequiredView.hidden = YES;
    pickerPreferredBrandsView.hidden = YES;
    
    
    if(arraySelectedPreferredBrands.count>0)
    {
        
        [btnPreferedBrands setTitle:[NSString stringWithFormat:@"Prefered Brands : %@",[arraySelectedPreferredBrands componentsJoinedByString:@", "]] forState:UIControlStateNormal];
        
    }
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 0, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
}


#pragma mark table view data sources and delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblSellerResponse) {
        return 70;
    }
    
    else if(tableView.tag==222)
        return 44;
    
    return 44;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tblSellerResponse) {
        NSLog(@"Rows Count : %lu",(unsigned long)_selectedRequirement.arrayConversations.count);
        
        return _selectedRequirement.arrayConversations.count;
    }
    
    else if(tableView.tag==222)
        return arrayPreferredBrands.count;
    
    return arrayTblDict.count+1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == tblSellerResponse)
    {
        static NSString *_simpleTableIdentifier = @"Home_SellerResponse";
        
        Home_SellerResponse *cell = (Home_SellerResponse*)[tblSellerResponse dequeueReusableCellWithIdentifier:_simpleTableIdentifier];
        // Configure the cell...
        if(cell==nil)
        {
            cell = [[Home_SellerResponse alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_simpleTableIdentifier];
        }
        
        Conversation *currentRow = [_selectedRequirement.arrayConversations objectAtIndex:indexPath.row];
        
        cell.lblSellerName.text = [NSString stringWithFormat:@"Seller : %@", currentRow.sellerName];
        cell.lblAmount.text = [NSString stringWithFormat:@"Quotation Amount : Rs %@",currentRow.initialAmount];
        if(currentRow.isBargainRequired && currentRow.bargainAmount.intValue>0)
            cell.lblBargainStatus.text = [NSString stringWithFormat:@"Bargain Amount : Rs %@",currentRow.bargainAmount];
        else if(currentRow.isBargainRequired)
            cell.lblBargainStatus.text = [NSString stringWithFormat:@"Bargain Requested"];
        else
            cell.lblBargainStatus.text = [NSString stringWithFormat:@"Slide left to view more options"];
        
        
        
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
        return cell;
    }
    
    if(tableView.tag==222)
    {
        static NSString *_simpleTableIdentifier = @"CellIdentifier";
        
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:_simpleTableIdentifier];
        
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
            
            cell.txtFieldDiameter.text = [[arrayTblDict objectAtIndex:indexPath.row] valueForKey:@"size"];
            cell.txtFieldQuantity.text = [[arrayTblDict objectAtIndex:indexPath.row] valueForKey:@"quantity"];
            
            
            
        }
        
        if(_selectedRequirement)
        {
            cell.btnAdd.hidden = YES;
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == tblSellerResponse) {
        NSLog(@"Table row clicked");
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


- (IBAction)btnAddAction:(UIButton *)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"size",@"",@"quantity", nil];
    [arrayTblDict addObject:dict];
    
    tblViewHeightConstraint.constant = (arrayTblDict.count+1)*44 + 5;
    scrollContentViewHeightConstraint.constant = scrollContentViewHeightConstraint.constant + tblViewHeightConstraint.constant - 150;
    
    [tblViewSizes reloadData];
    
    lbl.frame = CGRectMake(10,20,self.view.frame.size.width-20,contentView.frame.size.height-65);
}

#pragma mark - Swipe Cell Delegate
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}

- (NSArray *)tblSellerResponseRightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"Bargain"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
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
                indexPath = [tblSellerResponse indexPathForCell:cell];
                
                if(((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).bargainAmount.intValue==0)
                {
                    [SVProgressHUD show];
                    [_selectedRequirement postBargainForSeller:((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).sellerID withCompletion:^(NSDictionary *json, NSError *error) {
                        [SVProgressHUD dismiss];
                        if(json)
                        {
                            ((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).isBargainRequired = YES;
                            [tblSellerResponse reloadData];
                            
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
                    indexPath = [tblViewSizes indexPathForCell:cell];
                    
                    [arrayTblDict removeObjectAtIndex:indexPath.row];
                    tblViewHeightConstraint.constant = (arrayTblDict.count+1)*44;
                    scrollContentViewHeightConstraint.constant = scrollContentViewHeightConstraint.constant + tblViewHeightConstraint.constant - 150;
                    
                    [tblViewSizes reloadData]; // tell table to refresh now
                    lbl.frame = CGRectMake(10,20,self.view.frame.size.width-20,contentView.frame.size.height-65);
                    
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
                indexPath = [tblSellerResponse indexPathForCell:cell];
                [SVProgressHUD show];
                if(((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).isAccepted)
                {
                    [_selectedRequirement acceptRejectDeal:((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).sellerID status:YES withCompletion:^(NSDictionary *json, NSError *error) {
                        [SVProgressHUD dismiss];
                        if(json)
                        {
                            ((Conversation*)([_selectedRequirement.arrayConversations objectAtIndex:indexPath.row])).isAccepted = YES;
                            [tblSellerResponse reloadData];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Methods

-(IBAction)clkLoadMore:(id)sender
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    if (isLoadMoreClicked)
    {
        isLoadMoreClicked = false;
        customViewHeightConstarint.constant = 0;
        viewCustom.hidden = YES;
        [btnLoadMore setTitle:@"Show More" forState:UIControlStateNormal];
        
    }
    else
    {
        isLoadMoreClicked = true;
        customViewHeightConstarint.constant = 405;
        viewCustom.hidden = NO;
        [btnLoadMore setTitle:@"Show Less" forState:UIControlStateNormal];
        
    }
    
    [UIView commitAnimations];
    
    [self setMarginBoundary];
    
    
}


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

#pragma Mark - TextFiled Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag==786)
    {
        // getting indexpath from selected textfield
        CGPoint center= textField.center;
        CGPoint rootViewPoint = [textField.superview convertPoint:center toView:tblViewSizes];
        NSIndexPath *indexPath = [tblViewSizes indexPathForRowAtPoint:rootViewPoint];
        
        [[arrayTblDict objectAtIndex:indexPath.row] setValue:textField.text forKey:@"quantity"];
    }
    
    else if (textField == txtFieldCity)
    {
        if(txtFieldCity.text.length == 0)
            lbCity.text = @"   Delivery City ";
        
    }
    else if (textField == txtFieldState)
    {
        if(txtFieldState.text.length == 0)
            lbState.text = @"   State :";
        
    }
    else if (textField == txtFieldBudget)
    {
        if(txtFieldBudget.text.length == 0)
            lbAmount.text = @"   Budget Amount (Rs) ";
        
    }
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
        
        selectedDiameter = [NSString stringWithFormat:@"%@ mm",[[arraySteelSizes objectAtIndex: 0] valueForKey:@"size"]];
        
        UIPickerView *pickerView = [pickerToolBarView viewWithTag:111];
        
        
        [pickerView selectRow:0 inComponent:0 animated:NO];
        
        
        selectedDiameterTextfield = textField;
        [textField resignFirstResponder];
    }
    
    else if (textField == txtFieldCity)
    {
        lbCity.text = @"   Delivery City :";
        
    }
//    else if (textField == txtFieldState)
//    {
//        lbState.text = @"   State :";
//        
//    }
    else if (textField == txtFieldBudget)
    {
        lbAmount.text = @"   Budget Amount (Rs) :";
        
    }
    else if(textField == txtFieldState)
    {
        lbState.text = @"   State :";
        [txtFieldState resignFirstResponder];
        pickerViewState.hidden = NO;
        [self.view bringSubviewToFront:pickerViewState];
        
        if(arrayStates.count>0)
            selectedState = [NSString stringWithFormat:@"%@",[[arrayStates objectAtIndex: 0] valueForKey:@"name"]];
        
        UIPickerView *pickerView = [pickerViewState viewWithTag:777];
        
        [pickerView selectRow:0 inComponent:0 animated:NO];
        
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
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 216, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    
}

- (IBAction)gradeRequiredBtnAction:(UIButton *)sender {
    pickerGradeRequiredView.hidden = NO;
    [self.view bringSubviewToFront:pickerGradeRequiredView];
    selectedGradeRequired = [[arrayGradeRequired objectAtIndex: 0] valueForKey:@"grade"];
    selectedGradeID = [[arrayGradeRequired objectAtIndex: 0] valueForKey:@"id"];
    
    
    UIPickerView *pickerView = [pickerGradeRequiredView viewWithTag:333];
    
    [pickerView selectRow:0 inComponent:0 animated:NO];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 216, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    
}

- (IBAction)submitBtnAction:(UIButton *)sender {
    
    if(arrayTblDict.count==1)
    {
        if([[[[arrayTblDict objectAtIndex:0] valueForKey:@"size"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
        {
            [self showAlert:@"Please enter diameter size"];
            return;
        }
        
        else if([[[[arrayTblDict objectAtIndex:0] valueForKey:@"quantity"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
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
    else if([[txtFieldCity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [self showAlert:@"Please enter city"];
    }
    else if([[txtFieldState.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [self showAlert:@"Please enter state"];
    }
    else if([[txtFieldBudget.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [self showAlert:@"Please enter budget"];
    }
    else if([[selectedDate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [self showAlert:@"Please enter required by date"];
    }
    else if(selectedTax.length==0)
    {
        [self showAlert:@"Please select tax category"];
    }
    else
    {
        RequirementI *newRequirement = [RequirementI new];
        newRequirement.userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"];
        newRequirement.arraySpecifications = arrayTblDict;
        newRequirement.isChemical = switchChemical.isOn;
        newRequirement.isPhysical = switchPhysical.isOn;
        newRequirement.isTestCertificateRequired = switchCertReq.isOn;
        newRequirement.length = [NSString stringWithFormat:@"%li", (long)sgmtControlLenghtRequired.selectedSegmentIndex];
        newRequirement.type = [NSString stringWithFormat:@"%li", (long)sgmtControlTypeRequired.selectedSegmentIndex];
        newRequirement.arrayPreferedBrands = arraySelectedPreferredBrands;
        newRequirement.gradeRequired = selectedGradeID;
        newRequirement.budget = txtFieldBudget.text;
        newRequirement.city = txtFieldCity.text;
        newRequirement.state = txtFieldState.text;
        newRequirement.requiredByDate = selectedDate;
        newRequirement.taxType = selectedTaxID;
        
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

- (IBAction)requiredByDateBtnAction:(UIButton *)sender {
    datePickerView.hidden = NO;
    [self.view bringSubviewToFront:datePickerView];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 216, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
}

- (IBAction)preferedTaxBtnAction:(UIButton *)sender {
    pickerTaxView.hidden = NO;
    [self.view bringSubviewToFront:pickerTaxView];
    
    selectedTax = [NSString stringWithFormat:@"%@",[[arrayTaxes objectAtIndex: 0] valueForKey:@"type"]];
    selectedTaxID = [NSString stringWithFormat:@"%@",[[arrayTaxes objectAtIndex: 0] valueForKey:@"id"]];
    
    UIPickerView *pickerView = [pickerTaxView viewWithTag:555];
    
    [pickerView selectRow:0 inComponent:0 animated:NO];
    
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


@end
