//
//  EnterRTGS.m
//  MySteelHub
//
//  Created by Amit Yadav on 30/03/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import "EnterRTGS.h"

@interface EnterRTGS ()

@property (weak, nonatomic) IBOutlet UITextField *txtFieldRTGS;

- (IBAction)btnSubmitAction:(UIButton *)sender;
@end

@implementation EnterRTGS

@synthesize selectedOrder;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitleLabel:@"RTGS"];
    [self setBackButton];

    _txtFieldRTGS.delegate = self;
    
    
    //Custom UI for TextFilds
    [self customtxtfield:_txtFieldRTGS withrightIcon:nil borderLeft:true borderRight:true borderBottom:true borderTop:true];
    
    [_txtFieldRTGS setValue:[UIColor lightGrayColor]
                  forKeyPath:@"_placeholderLabel.textColor"];
}


-(BOOL)validateData
{
    NSString *value = [_txtFieldRTGS.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([value length] == 0)
    {
        
        NSLog(@"Please enter RTGS");
        [self showError:@"Please enter RTGS number"];
        return false;
        
    }
    
    
    return true;
    
}

-(void)showError:(NSString*)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@", error] preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    
    // Present action sheet.
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnSubmitAction:(UIButton *)sender {
    
    if ([self validateData]) {
        [SVProgressHUD show];
        [selectedOrder buyerPostRTGS:_txtFieldRTGS.text toSeller:selectedOrder.sellerID withCompletion:^(NSDictionary *json, NSError *error) {
            [SVProgressHUD dismiss];
            if([[json valueForKey:@"success"] boolValue])
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self showError:@"Something went wrong. Please try again"];
            }
        }];
    }

}
@end
