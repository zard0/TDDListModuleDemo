//
//  MyTableViewDataSource.h
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/10.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *theDataArray;

@end
