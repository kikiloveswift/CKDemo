//
//  ProductComponent.h
//  CKDemo
//
//  Created by kong on 2019/10/11.
//

#import <ComponentKit/ComponentKit.h>

@class ProductComponentContext;

NS_ASSUME_NONNULL_BEGIN

@interface ProductComponent : CKCompositeComponent

@property (nonatomic) ZHQuestionRelatedModel *card;
@property (nonatomic) ZHCKCommonContext *context;

+ (instancetype)newWithModel:(ZHQuestionRelatedModel *)card
                     context:(ZHCKCommonContext *)context


@end

NS_ASSUME_NONNULL_END
