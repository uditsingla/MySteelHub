//
//  Address.h
//  MySteelHub
//
//  Created by Amit Yadav on 16/10/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject

@property(strong,nonatomic) NSString *ID;
@property(strong,nonatomic) NSString *address1;
@property(strong,nonatomic) NSString *address2;
@property(strong,nonatomic) NSString *firmName;
@property(strong,nonatomic) NSString *city;
@property(strong,nonatomic) NSString *state;
@property(strong,nonatomic) NSString *pin;
@property(strong,nonatomic) NSString *mobile;
@property(strong,nonatomic) NSString *landLine;
@property(strong,nonatomic) NSString *addressType;
@property(strong,nonatomic) NSString *landmark;
@property(assign,nonatomic) BOOL isCurrent;


@end
