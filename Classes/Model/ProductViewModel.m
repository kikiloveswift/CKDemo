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
        NSBundle *associateBundle = [NSBundle bundleWithURL:[NSURL URLWithString:path]];
        associateBundle = [associateBundle URLForResource:@"CKDemo" withExtension:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithURL:associateBundle];
        NSData *data = [bundle pathForResource:@"product" ofType:@"json"];
        [subscriber sendNext:nil];
        [subscriber sendCompleted];
    }] replayLast] deliverOnMainThread];
}


@end
