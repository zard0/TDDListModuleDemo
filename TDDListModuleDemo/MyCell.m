//
//  MyCell.m
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/15.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "MyCell.h"

@interface MyCell()

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIImageView *avatarImgV;

@end

@implementation MyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    self.avatarImgV = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 20, 20)];
    [self.contentView addSubview:self.avatarImgV];
    self.titleLb  = [[UILabel alloc] initWithFrame:CGRectMake(52, 0, self.contentView.bounds.size.width - 52, self.contentView.bounds.size.height)];
    [self.contentView addSubview:self.titleLb];
}

- (void)setModel:(MyModel *)model{
    _model = model;
    if ([_model.picUrl isEqualToString:@"AUrl"]) {
        self.avatarImgV.backgroundColor = [UIColor redColor];
    }else if ([_model.picUrl isEqualToString:@"BUrl"]){
        self.avatarImgV.backgroundColor = [UIColor brownColor];
    }else{
        self.avatarImgV.backgroundColor = [UIColor purpleColor];
    }
    self.titleLb.text = _model.title;
}

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
