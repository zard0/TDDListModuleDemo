//
//  MyCellJumper.h
//  TDDListModuleDemo
//
//  Created by linkunzhu on 2017/8/23.
//  Copyright © 2017年 Etop. All rights reserved.
//

#import "JumperProtocol.h"

@interface MyCellJumper : NSObject <JumperProtocol>

@property (nonatomic, readonly, weak) UINavigationController *navigationController;

@end
