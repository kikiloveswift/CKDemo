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

#define ScreenSize [UIScreen mainScreen].bounds.size

@interface ProductViewController ()<CKComponentProvider>

@property (nonatomic) UICollectionView *collectionView;

@property (nonatomic) CKComponentFlexibleSizeRangeProvider *provider;

@property (nonatomic) CKCollectionViewDataSource *dataSource;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    // 初始化 sizeRange
    self.provider = [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:CKComponentSizeRangeFlexibilityNone];
    const CKSizeRange sizeRange = CKSizeRange({ScreenSize.width, 0}, {ScreenSize.width, INFINITY});
    
    //dataSource config
    CKDataSourceConfiguration *config = [[CKDataSourceConfiguration alloc] initWithComponentProvider:[self class] context:self sizeRange:sizeRange];
    self.dataSource = [[CKCollectionViewDataSource alloc] initWithCollectionView:self.collectionView supplementaryViewDataSource:nil configuration:config];
}

#pragma mark - CKComponentProvider
+ (CKComponent *)componentForModel:(id<NSObject>)model context:(id<NSObject>)context {
    
    return nil;
}


@end
