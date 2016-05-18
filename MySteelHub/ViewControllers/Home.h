//
//  Home.h
//  Sourcefuse
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 Sourcefuse. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;


@interface Home : UIViewController <UITextFieldDelegate,CLLocationManagerDelegate>

-(IBAction)btnClicked:(id)sender;
@end
