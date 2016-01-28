//
//  CollectionCell2.m
//  Shoping
//
//  Created by qianfeng on 16/1/20.
//  Copyright © 2016年 boge. All rights reserved.
//

#import "CollectionCell2.h"
#import "UIImageView+WebCache.h"

@implementation CollectionCell2

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(SPModel *)model
{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    self.titleLb.text = model.title;
    self.cutPriceLb.text = [NSString stringWithFormat:@"¥%.2f", model.origin_price];
    self.nowPriceLb.text = [NSString stringWithFormat:@"¥%.2f",model.now_price];
}

@end
