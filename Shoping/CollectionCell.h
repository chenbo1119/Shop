//
//  CollectionCell.h
//  Shoping
//
//  Created by qianfeng on 16/1/20.
//  Copyright © 2016年 boge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPModel.h"


@interface CollectionCell : UICollectionViewCell

@property (strong,nonatomic) SPModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end
