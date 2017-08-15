//
//  MyCell.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/15.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier{
    return @"MyCell";
}

@end
