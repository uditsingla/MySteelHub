//
//  OrderConfirmation.m
//  MySteelHub
//
//  Created by Abhishek Singla on 30/11/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "OrderConfirmation.h"

@interface OrderConfirmation ()
@property (weak, nonatomic) IBOutlet UITableView *tableOrderDescription;

@end

@implementation OrderConfirmation
@synthesize selectedRequirement;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.contentView.backgroundColor = kBlueColor;
    
    [self setBackButton];
    [self setMenuButton];
    [self setTitleLabel:@"Confirm Order"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -TableView Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return selectedRequirement.arraySpecifications.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  static NSString *_simpleTableIdentifier = @"Cell";
        
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:_simpleTableIdentifier];
        // Configure the cell...
        if(cell==nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_simpleTableIdentifier];
        }
    
    
    float height = 21;
    
    UILabel *lbl1 = (UILabel *)[cell.contentView viewWithTag:1];
    lbl1.text = [[selectedRequirement.arraySpecifications objectAtIndex:indexPath.row]valueForKey:@"size"];
    
    UILabel *lbl2 = (UILabel *)[cell.contentView viewWithTag:2];
    lbl2.text = [[selectedRequirement.arraySpecifications objectAtIndex:indexPath.row]valueForKey:@"quantity"];
    
    UILabel *lbl3 = (UILabel *)[cell.contentView viewWithTag:3];
    lbl3.hidden = YES;

    UILabel *lbl4 = (UILabel *)[cell.contentView viewWithTag:4];
    lbl4.hidden = YES;
    
    lbl1.frame = CGRectMake(0, 12, (cell.frame.size.width/2), height);
    lbl2.frame = CGRectMake((cell.frame.size.width/2), 12, (cell.frame.size.width/2), height);
    
    if([[selectedRequirement.arraySpecifications objectAtIndex:indexPath.row]valueForKey:@"priceOld"])
    {
        lbl3.hidden = NO;

        lbl3.text = [[selectedRequirement.arraySpecifications objectAtIndex:indexPath.row]valueForKey:@"priceOld"];
        
        lbl1.frame = CGRectMake(0, 12, (cell.frame.size.width/3), height);
        lbl2.frame = CGRectMake((cell.frame.size.width/3), 12, (cell.frame.size.width/3), height);
        lbl3.frame = CGRectMake(((cell.frame.size.width/3)*2), 12, (cell.frame.size.width/3), height);
    }
    
    if([[selectedRequirement.arraySpecifications objectAtIndex:indexPath.row]valueForKey:@"priceNew"])
    {
        lbl4.hidden = NO;

        lbl4.text = [[selectedRequirement.arraySpecifications objectAtIndex:indexPath.row]valueForKey:@"priceNew"];
        
        lbl1.frame = CGRectMake(0, 12, (cell.frame.size.width/4), height);
        lbl2.frame = CGRectMake((cell.frame.size.width/4),12 , (cell.frame.size.width/4), height);
        lbl3.frame = CGRectMake(((cell.frame.size.width/4)*2), 12, (cell.frame.size.width/4), height);
        lbl4.frame = CGRectMake(((cell.frame.size.width/4)*3),12 , (cell.frame.size.width/4), height);
    }
    
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
        return cell;
}
    

- (IBAction)clkSubmit:(id)sender {
    
    NSLog(@"Click Submit");
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
