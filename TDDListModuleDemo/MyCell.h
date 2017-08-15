//
//  MyCell.h
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/15.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModel.h"

@interface MyCell : UITableViewCell

@property (nonatomic, strong) MyModel *model;

+ (NSString *)reuseIdentifier;

@end
