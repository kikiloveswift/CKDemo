//
//  ProductComponentContext.h
//  CKDemo
//
//  Created by kong on 2019/10/11.
//

#import <Foundation/Foundation.h>

@protocol CKNetworkImageDownloading;

NS_ASSUME_NONNULL_BEGIN

@interface ProductComponentContext : NSObject

@property (nonatomic, weak) UIViewController *controller;

@property (nonatomic, assign) CGFloat containerWidth;

@property (nonatomic, strong) id<CKNetworkImageDownloading> imageDownloader;

@end

NS_ASSUME_NONNULL_END
