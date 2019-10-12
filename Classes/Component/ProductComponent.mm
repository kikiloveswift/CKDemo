//
//  ProductComponent.m
//  CKDemo
//
//  Created by kong on 2019/10/11.
//

#import "ProductComponent.h"
#import "ProductModel.h"
#import "ProductComponentContext.h"

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
                                            .alignment = NSTextAlignmentRight,
                                            .string = m.name,
                                            .font = [UIFont boldSystemFontOfSize:20],
                                            .color = [UIColor blackColor],
                                            .lineBreakMode = NSLineBreakByTruncatingTail,
                                            .maximumNumberOfLines = 2,
                                        } viewAttributes:{
                                            {
                                                @selector(setBackgroundColor:), [UIColor clearColor]
                                            }
                                        } size:{}];
    
    CKComponent *subname = [CKLabelComponent newWithLabelAttributes:{
                                            .alignment = NSTextAlignmentRight,
                                            .string = m.subName,
                                            .font = [UIFont italicSystemFontOfSize:17],
                                            .color = [UIColor lightTextColor],
                                            .lineBreakMode = NSLineBreakByTruncatingTail,
                                        } viewAttributes:{
                                            {
                                                @selector(setBackgroundColor:), [UIColor clearColor]
                                            }
                                        } size:{}];
    
    CKComponent *price = [CKLabelComponent newWithLabelAttributes:{
                        .alignment = NSTextAlignmentRight,
                        .string = [NSString stringWithFormat:@"%d", m.price],
                        .font = [UIFont boldSystemFontOfSize:24],
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
                      size:{}
                      style:{
                    .direction = CKFlexboxDirectionRow,
                    .justifyContent = CKFlexboxJustifyContentStart,
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
    
    ProductComponent *p = [ProductComponent newWithComponent:c];
    p.context = context;
    p.model = m;
    return p;
}

@end
