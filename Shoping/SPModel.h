//
//  SPModel.h
//  Shoping
//
//  Created by qianfeng on 16/1/17.
//  Copyright © 2016年 boge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPModel : NSObject

@property (nonatomic,assign) float now_price;
@property (nonatomic,strong) NSString *num_iid;
@property (nonatomic,assign) float origin_price;
@property (nonatomic,strong) NSString * pic_url;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *url;


@end
