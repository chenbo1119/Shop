//
//  CollectionCell.m
//  Shoping
//
//  Created by qianfeng on 16/1/20.
//  Copyright © 2016年 boge. All rights reserved.
//

#import "CollectionCell.h"
#import "UIImageView+WebCache.h"

@implementation CollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(SPModel *)model
{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
}

@end
