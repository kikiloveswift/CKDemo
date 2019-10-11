//
//  ProductComponentContext.h
//  CKDemo
//
//  Created by kong on 2019/10/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductComponentContext : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, weak) UIViewController *controller;



@end

NS_ASSUME_NONNULL_END
