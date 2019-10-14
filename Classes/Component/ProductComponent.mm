//
//  ProductComponent.m
//  CKDemo
//
//  Created by kong on 2019/10/11.
//

#import "ProductComponent.h"
#import "ProductModel.h"
#import "ProductComponentContext.h"

@interface CustomView : UIView

- (void)updateGradientLayer:(nonnull UIColor *)color;

@end

@implementation ProductComponent

+ (instancetype)newWithModel:(ProductModel *)m
                     context:(ProductComponentContext *)context {
    CKComponentScope scope(self);
    
    CKComponent *left = nil;
    if (m.imageURL.length > 0) {
        left = [CKNetworkImageComponent
                newWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/1/q/90/w/240/h/240/", m.imageURL]]
                imageDownloader:context.imageDownloader
                size:{.width = 78, .height = 100}
                options:{}
                attributes:{
                    {CKComponentViewAttribute::LayerAttribute(@selector(setCornerRadius:)), @(6)},
                    {CKComponentViewAttribute::LayerAttribute(@selector(setMasksToBounds:)), @YES},
                    {CKComponentViewAttribute::LayerAttribute(@selector(setBorderColor:)), [NSValue valueWithPointer:[UIColor yellowColor].CGColor]},
                    {CKComponentViewAttribute::LayerAttribute(@selector(setBorderWidth:)), @(0.5)},
                }];
    }
    
    CKComponent *right = nil;
    
    CKComponent *name = [CKLabelComponent newWithLabelAttributes:{
                                            .alignment = NSTextAlignmentLeft,
                                            .string = m.name,
                                            .font = [UIFont boldSystemFontOfSize:19],
                                            .color = [UIColor blackColor],
                                            .lineBreakMode = NSLineBreakByTruncatingTail,
                                            .maximumNumberOfLines = 2,
                                        } viewAttributes:{
                                            {
                                                @selector(setBackgroundColor:), [UIColor clearColor]
                                            }
                                        } size:{}];
    
    CKComponent *subname = [CKLabelComponent newWithLabelAttributes:{
                                            .alignment = NSTextAlignmentLeft,
                                            .string = m.subName,
                                            .font = [UIFont italicSystemFontOfSize:17],
                                            .color = [UIColor blackColor],
                                            .lineBreakMode = NSLineBreakByTruncatingTail,
                                        } viewAttributes:{
                                            {
                                                @selector(setBackgroundColor:), [UIColor clearColor]
                                            }
                                        } size:{}];
    
    CKComponent *price = [CKLabelComponent newWithLabelAttributes:{
                        .alignment = NSTextAlignmentLeft,
                        .string = [NSString stringWithFormat:@"%d", [m.price integerValue]],
                        .font = [UIFont boldSystemFontOfSize:20],
                        .color = [UIColor redColor],
                        .lineBreakMode = NSLineBreakByTruncatingTail,
                    } viewAttributes:{
                        {
                            @selector(setBackgroundColor:), [UIColor clearColor]
                        }
                    } size:{}];
    
    right = [CKFlexboxComponent
             newWithView:{}
             size:{}
             style:{
                .direction = CKFlexboxDirectionColumn,
                .justifyContent = CKFlexboxJustifyContentStart,
                .alignItems = CKFlexboxAlignItemsStretch,
            }
             children:{
            {
                name,
                .spacingAfter = 10,
                .flexGrow = YES,
                .flexShrink = YES,
            }, {
                subname,
                .spacingAfter = 10,
                .flexGrow = YES,
                .flexShrink = YES,
            }, {
                price,
            }
        }];
    
    CKComponent *c = [CKFlexboxComponent
                      newWithView:{}
                      size:{
                    .width = context.containerWidth
                }
                      style:{
                    .direction = CKFlexboxDirectionRow,
                    .justifyContent = CKFlexboxJustifyContentCenter,
                    .alignItems = CKFlexboxAlignItemsCenter,
                }
                      children:{
                {
                    left,
                    .spacingAfter = (left == nil) ? 0 : 20.f,
                }, {
                    right,
                    .flexGrow = YES,
                    .flexShrink = YES,
                }
            }];
    
    ProductComponent *p = [ProductComponent newWithComponent:[CKInsetComponent newWithInsets:{.top = 10, .left = 15, .right = 15, .bottom = 10} component:c]];
    p.context = context;
    p.model = m;
    return p;
}

static inline CKComponent * gradientLayer(ProductModel *m) {
    CKComponent *gradient = [CKComponent
    newWithView:{
        CustomView.class,
        {
            {{"CustomView.config", ^(CustomView *view, id r) {
                [view updateGradientLayer:color]
            }}, m.price.integerValue > 10000},
        }
    } size:{.width = 18, .height = 18}];
    
    
    return nil;
}

@end

@implementation CustomView


- (void)updateGradientLayer:(CGFloat)alpha {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.7].CGColor,
    (__bridge id)[UIColor whiteColor].CGColor];
    gradientLayer.locations = @[@0.7];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = self.frame;
    [self.layer addSublayer:gradientLayer];
}


@end
