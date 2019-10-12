//
//  ProductComponent.h
//  CKDemo
//
//  Created by kong on 2019/10/11.
//

#import <ComponentKit/ComponentKit.h>

@class ProductModel;
@class ProductComponentContext;

NS_ASSUME_NONNULL_BEGIN

@interface ProductComponent : CKCompositeComponent

@property (nonatomic) ProductModel *model;
@property (nonatomic) ProductComponentContext *context;

+ (instancetype)newWithModel:(ProductModel *)card
                     context:(ProductComponentContext *)context;


@end

NS_ASSUME_NONNULL_END
