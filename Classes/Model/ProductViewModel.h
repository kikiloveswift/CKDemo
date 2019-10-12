//
//  ProductViewModel.h
//  CKDemo
//
//  Created by kong on 2019/10/12.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

@class ProductModel;

NS_ASSUME_NONNULL_BEGIN

@interface ProductViewModel : NSObject

@property (nonatomic, copy) NSArray<ProductModel *> *dataArr;

- (instancetype)initWithPath:(NSString *)path;

- (RACSignal *)fetchNew;

@end

NS_ASSUME_NONNULL_END
