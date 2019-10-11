//
//  ImageDownloader.h
//  AdvancedUISDKUseAge
//
//  Created by kong on 2018/8/23.
//  Copyright © 2018年 konglee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ComponentKit/CKNetworkImageDownloading.h>

@class SDWebImageManager;

@interface ImageDownloader : NSObject<CKNetworkImageDownloading>

+ (instancetype)sharedManager;

@end
