//
//  MutiPartFormsRequestManager.h
//  HJZWeiBo
//
//  Created by 蒋晨成 on 16/6/13.
//  Copyright © 2016年 蒋晨成. All rights reserved.
//

#import <Foundation/Foundation.h>

// 请求成功的回调block，返回的是NSdata (最外层的大数组或者大字典)
typedef void(^Finish)(NSData *data);
// 请求失败的回调block，返回的是NSError (返回的error,失败的错误信息)
typedef void(^Error)(NSError *error);
// 请求的进度
typedef void(^Progress)(CGFloat progress);

@interface MutiPartFormsRequestManager : NSObject


// block属性 用于接收外界传进来的block的值
@property (nonatomic, copy) Finish finish;
@property (nonatomic, copy) Error error;
@property (nonatomic, copy) Progress progress;
// 在此类方法中，需要进行本类对象的创建 然后再去请求数据
+ (void)requestWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic images:(NSArray *)images progress:(Progress)progress finish:(Finish)finish error:(Error)error;

@end
