//
//  ProductViewModel.m
//  CKDemo
//
//  Created by kong on 2019/10/12.
//

#import "ProductViewModel.h"
#import "ProductModel.h"
#import <YYModel/NSObject+YYModel.h>

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
        NSString *pathJSON = [bundle pathForResource:@"product" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:pathJSON options:NSDataReadingMappedIfSafe error:nil];
    
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([json isKindOfClass:NSArray.class]) {
            NSMutableArray<ProductModel *> *mArr = [NSMutableArray array];
            [(NSArray *)json enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ProductModel *model = [ProductModel yy_modelWithJSON:obj];
                [mArr addObject:model];
            }];
            self.dataArr = [mArr copy];
        }
        
        [subscriber sendNext:self.dataArr];
        [subscriber sendCompleted];
    }] replayLast] deliverOnMainThread];
}


@end
