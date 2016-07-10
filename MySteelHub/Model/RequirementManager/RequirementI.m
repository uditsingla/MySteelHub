//
//  RequirementI.m
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "RequirementI.h"

@implementation RequirementI

@synthesize userID,quantity,length,type,rate,deliveryAddress;

- (id)init
{
    self = [super init];
    if (self) {
        userID=@"";
        quantity=@"";
        length=@"";
        type=@"";
        rate=@"";
        deliveryAddress=@"";

    }
    return self;
}

@end
