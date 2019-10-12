//
//  ProductViewModel.m
//  CKDemo
//
//  Created by kong on 2019/10/12.
//

#import "ProductViewModel.h"
#import "ProductModel.h"

@interface ProductViewModel()

@property (nonatomic, copy) NSString *path;

@end

@implementation ProductViewModel

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        _path = path;
    }
    return self;
}

- (RACSignal *)fetchNew {
    @weakify(self);
    return [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        /// network with path request
        NSString *path = self.path;
        [subscriber sendNext:<#(nullable id)#>]
        [subscriber sendCompleted];
    }] replayLast] deliverOnMainThread];
}


@end
