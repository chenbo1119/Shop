//
//  CBRequest.h
//  Shoping
//
//  Created by qianfeng on 16/1/15.
//  Copyright © 2016年 boge. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^httpBlock) (NSData *data);

@interface CBRequest : NSObject

- (id)initWithRequestString:(NSString *)path andBlock:(httpBlock)block;

@end
