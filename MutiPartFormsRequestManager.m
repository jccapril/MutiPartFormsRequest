//
//  MutiPartFormsRequestManager.m
//  HJZWeiBo
//
//  Created by 蒋晨成 on 16/6/13.
//  Copyright © 2016年 蒋晨成. All rights reserved.
//

#import "MutiPartFormsRequestManager.h"
#import <AFNetworking.h>
#import <UIKit/UIKit.h>

@implementation MutiPartFormsRequestManager

+ (void)requestWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic images:(NSArray *)images progress:(Progress)progress finish:(Finish)finish error:(Error)error {
    
    // 每次调用的都是controller去调用 请求数据
    MutiPartFormsRequestManager *manager = [[MutiPartFormsRequestManager alloc] init];
    [manager requestWithUrlString:urlString  parDic:parDic images:images progress:(Progress)progress finish:finish error:error];
    
}

- (void)requestWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic images:(NSArray *)images progress:(Progress)progress finish:(Finish)finish error:(Error)error {
    self.finish = finish;
    self.error = error;
    self.progress = progress;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlString parameters:parDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < images.count; i++) {
            NSData *data = nil;
            if (UIImagePNGRepresentation(images[i])) {
                data = UIImagePNGRepresentation(images[i]);
            }else {
                data = UIImageJPEGRepresentation(images[i], 1.0);
            }
            
            NSString *fileName = [NSString stringWithFormat:@"jcc%d.png",i];
            [formData appendPartWithFileData:data name:@"pic" fileName:fileName mimeType:@"image/png"];
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        self.progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.error(error);
    }];
}


@end
