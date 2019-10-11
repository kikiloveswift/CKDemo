//
//  ProductComponentContext.m
//  CKDemo
//
//  Created by kong on 2019/10/11.
//

#import "ProductComponentContext.h"

@implementation ProductComponentContext

+ (instancetype)sharedInstance {
    static ProductComponentContext *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ProductComponentContext alloc] init];
    });
    return instance;
}

@end
