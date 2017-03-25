//
//  OrderI.m
//  MySteelHub
//
//  Created by Abhishek Singla on 12/03/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import "OrderI.h"
#import "RequirementI.h"

@implementation OrderI

@synthesize req, statusCode, orderID , finalAmount;

- (id)init
{
    self = [super init];
    if (self) {
        req = [RequirementI new];
        finalAmount = @"";
    }
    return self;
}

@end
