//
//  ProductModel.h
//  CKDemo
//
//  Created by kong on 2019/10/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *subName;

@property (nonatomic, copy) NSString *imageURL;

@property (nonatomic, strong) NSNumber *price;

@end

NS_ASSUME_NONNULL_END
