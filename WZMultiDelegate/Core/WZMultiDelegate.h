//
//  WZMultiDelegate.h
//  WZMultiDelegate
//
//  Created by 牛胖胖 on 2019/7/22.
//  Copyright © 2019 我主良缘. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WZMultiDelegate : NSObject

- (instancetype)initWithDelegates:(nullable NSArray*)delegates;

/**
 添加代理

 @param delegate delegate
 */
- (void)addDelegate:(nonnull id)delegate;

/**
 添加此代理在哪个代理前面

 @param delegate 当前代理
 @param otherDelegate 位于代理
 */
- (void)addDelegate:(nonnull id)delegate beforeDelegate:(nonnull id)otherDelegate;

/**
 添加此代理在哪个代理后面
 
 @param delegate 当前代理
 @param otherDelegate 位于代理
 */
- (void)addDelegate:(nonnull id)delegate afterDelegate:(nonnull id)otherDelegate;

/**
 移除代理

 @param delegate delegate
 */
- (void)removeDelegate:(nonnull id)delegate;

/**
 移除所有的代理
 */
- (void)removeAllDelegates;

@end

NS_ASSUME_NONNULL_END
