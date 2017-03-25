//
//  OrderI.h
//  MySteelHub
//
//  Created by Abhishek Singla on 12/03/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequirementI.h"
@interface OrderI : NSObject

@property(nonatomic,strong)RequirementI *req;
@property(nonatomic,assign) int statusCode;
@property(strong,nonatomic) NSString *orderID;
@property(strong,nonatomic) NSString *finalAmount;
@end
