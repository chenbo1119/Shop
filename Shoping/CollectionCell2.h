//
//  CollectionCell2.h
//  Shoping
//
//  Created by qianfeng on 16/1/20.
//  Copyright © 2016年 boge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPModel.h"

@interface CollectionCell2 : UICollectionViewCell

@property (strong,nonatomic) SPModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *nowPriceLb;
@property (weak, nonatomic) IBOutlet UILabel *cutPriceLb;

@end
