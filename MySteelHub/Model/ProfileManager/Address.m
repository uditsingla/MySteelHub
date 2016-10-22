//
//  Address.m
//  MySteelHub
//
//  Created by Amit Yadav on 16/10/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "Address.h"

@implementation Address

@synthesize ID,address1,address2,firmName,city,state,pin,mobile,isCurrent,landLine,addressType,landmark;

- (id)init
{
    self = [super init];
    if (self) {
        ID = @"";
        address1 = @"";
        address2 = @"";
        firmName = @"";
        city = @"";
        state = @"";
        pin = @"";
        mobile = @"";
        landLine = @"";
        addressType = @"";
        landmark = @"";
        isCurrent = NO;
    }
    return self;
}

@end
