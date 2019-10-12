//
//  ImageDownloader.m
//  AdvancedUISDKUseAge
//
//  Created by kong on 2018/8/23.
//  Copyright © 2018年 konglee. All rights reserved.
//

#import "ImageDownloader.h"
#import <ComponentKit/CKNetworkImageComponent.h>
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/SDWebImageDownloader.h>

@interface ImageDownloader()

@property (nonatomic) SDWebImageManager *sdManager;

@property (nonatomic) SDWebImageOptions imgOptions;

@end

@implementation ImageDownloader

+ (instancetype)sharedManager {
    static ImageDownloader * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
        _manager.sdManager = [SDWebImageManager sharedManager];
        _manager.imgOptions = SDWebImageRetryFailed | SDWebImageContinueInBackground;
    });
    return _manager;
}


// MARK: -CKNetworkImageDownloading

- (void)cancelImageDownload:(id)download {
    NSAssert(download != nil, @"download 为空");
    id <SDWebImageOperation> operation = download;
    [operation cancel];
}

- (id)downloadImageWithURL:(NSURL *)URL
                    caller:(id)caller
             callbackQueue:(dispatch_queue_t)callbackQueue
     downloadProgressBlock:(void (^)(CGFloat progress))downloadProgressBlock
                completion:(void (^)(CGImageRef image, NSError *error))completion {
    NSAssert(URL != nil, @"URL 不可为空");
    UIImage *img = [[SDImageCache sharedImageCache] imageFromCacheForKey:URL.absoluteString];
    if (img) {
        completion(img.CGImage, nil);
        return nil;
    }
    
    return [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:URL options:self.imgOptions progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        if (downloadProgressBlock) {
            dispatch_async(callbackQueue ? : dispatch_get_main_queue(), ^{
                downloadProgressBlock(CGFloat(receivedSize) / expectedSize);
            });
        }
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (!finished) {
            return;
        }
        dispatch_async(callbackQueue ? : dispatch_get_main_queue(), ^{
            completion(image.CGImage, error);
            [[SDImageCache sharedImageCache] storeImage:image forKey:URL.absoluteString toDisk:YES completion:nil];
        });
    }];
    
}

@end
