//
//  ProductViewController.m
//  ComponentKitDemo
//
//  Created by kong on 2019/9/27.
//  Copyright © 2019 kong. All rights reserved.
//

#import "ProductViewController.h"
#import <Masonry/Masonry.h>
#import <ComponentKit/ComponentKit.h>
#import "ImageDownloader.h"
#import "ProductComponentContext.h"
#import "ProductViewModel.h"
#import "ProductModel.h"
#import "ProductComponent.h"

#define ScreenSize [UIScreen mainScreen].bounds.size

@interface ProductViewController ()<CKComponentProvider>

@property (nonatomic) UICollectionView *collectionView;

@property (nonatomic) CKComponentFlexibleSizeRangeProvider *provider;

@property (nonatomic) CKCollectionViewDataSource *dataSource;

@property (nonatomic) ProductViewModel *viewModel;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self configSetting];
    [self requestData];
}

- (void)configSetting {
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
    path = [path URLByAppendingPathComponent:@"CKDemo"];
    path = [path URLByAppendingPathExtension:@"framework"];
    self.viewModel = [[ProductViewModel alloc] initWithPath:path.absoluteString];
}

- (void)requestData {
    @weakify(self);
    [[[[self.viewModel fetchNew]
       takeUntil:self.rac_willDeallocSignal]
      deliverOnMainThread]
     subscribeNext:^(NSArray<ProductModel *> * _Nullable arr) {
        @strongify(self);
        [self enquePage:arr];
    } error:^(NSError * _Nullable error) {
        /// show alert
    }];
}

- (void)enquePage:(nullable NSArray<ProductModel *> *)arr {
    if (arr == nil) {
        return;
    }
    
    CKDataSourceChangesetBuilder *builder = [CKDataSourceChangesetBuilder new];
    if (self.viewModel.dataArr.count > 0) {
        // clear oldData
        NSArray *oldData = self.viewModel.dataArr;
        NSMutableSet *set = [NSMutableSet set];
        [oldData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [set addObject:[NSIndexPath indexPathForItem:idx inSection:0]];
        }];
        [builder withRemovedItems:set];
    }
    
    // insert new
    self.viewModel.dataArr = [arr copy];
    NSMutableDictionary *insertDic = [NSMutableDictionary dictionary];
    [self.viewModel.dataArr enumerateObjectsUsingBlock:^(ProductModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [insertDic setObject:obj forKey:[NSIndexPath indexPathForRow:idx inSection:0]];
    }];
    
    [builder withInsertedSections:[NSIndexSet indexSetWithIndex:0]];
    [builder withInsertedItems:insertDic];
    [self.dataSource applyChangeset:builder.build mode:CKUpdateModeAsynchronous userInfo:nil];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 初始化 sizeRange
    self.provider = [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:CKComponentSizeRangeFlexibilityNone];
    const CKSizeRange sizeRange = CKSizeRange({ScreenSize.width, 0}, {ScreenSize.width, INFINITY});
    
    //dataSource config
    CKDataSourceConfiguration *config = [[CKDataSourceConfiguration alloc] initWithComponentProvider:[self class] context:[self collectionViewContext] sizeRange:sizeRange];
    self.dataSource = [[CKCollectionViewDataSource alloc] initWithCollectionView:self.collectionView supplementaryViewDataSource:nil configuration:config];
}

- (id)collectionViewContext {
    ProductComponentContext *context = [[ProductComponentContext alloc] init];
    context.controller = self;
    context.containerWidth = CGRectGetWidth(self.view.bounds);
    context.imageDownloader = [ImageDownloader sharedManager];
    return context;
}

#pragma mark - CKComponentProvider
+ (CKComponent *)componentForModel:(id<NSObject>)model context:(id<NSObject>)context {
    if ([model isKindOfClass:ProductModel.class]) {
        return [ProductComponent newWithModel:(ProductModel *)model context:(ProductComponentContext *)context];
    }
    return nil;
}


@end
