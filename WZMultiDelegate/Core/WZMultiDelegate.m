//
//  WZMultiDelegate.m
//  WZMultiDelegate
//
//  Created by 牛胖胖 on 2019/7/22.
//  Copyright © 2019 我主良缘. All rights reserved.
//

#import "WZMultiDelegate.h"

@interface WZMultiDelegate ()

@property (nonatomic,strong) NSPointerArray* delegateArray;

@end

@implementation WZMultiDelegate

- (instancetype)init {
    return [self initWithDelegates:nil];
}

- (instancetype)initWithDelegates:(nullable NSArray*)delegates {
    self = [super init];
    if (!self)
        return nil;
    
    self.delegateArray = [NSPointerArray weakObjectsPointerArray];
    for (id delegate in delegates)
        [self.delegateArray addPointer:(__bridge void*)delegate];
    
    return self;
}

// 添加代理
- (void)addDelegate:(nonnull id)delegate{
    if (delegate &&![self.delegateArray.allObjects containsObject:delegate]) {
        [self.delegateArray addPointer:(__bridge void*)delegate];
    }
}

- (void)addDelegate:(nonnull id)delegate beforeDelegate:(nonnull id)otherDelegate {
    NSUInteger index = [self indexOfDelegate:otherDelegate];
    if (index == NSNotFound)
        index = self.delegateArray.count;
    [self.delegateArray insertPointer:(__bridge void*)delegate atIndex:index];
}

- (void)addDelegate:(nonnull id)delegate afterDelegate:(nonnull id)otherDelegate {
    NSUInteger index = [self indexOfDelegate:otherDelegate];
    if (index == NSNotFound)
        index = 0;
    else
        index += 1;
    [self.delegateArray insertPointer:(__bridge void*)delegate atIndex:index];
}


// 移除代理
- (void)removeDelegate:(nonnull id)delegate{
    NSUInteger index = [self indexOfDelegate:delegate];
    if (index == NSNotFound) return;
    [self.delegateArray removePointerAtIndex:index];
    [self.delegateArray compact];
}

// 移除所有代理
- (void)removeAllDelegates{
    for (NSUInteger i = self.delegateArray.count; i > 0; i -= 1){
        [self.delegateArray removePointerAtIndex:i - 1];
    }
}

// 遍历数组
- (NSUInteger)indexOfDelegate:(id)delegate {
    for (int i=0; i<self.delegateArray.count; i++) {
        if ([self.delegateArray pointerAtIndex:i] == (__bridge void*)delegate) {
            return i;
        }
    }
    return NSNotFound;
}

#pragma mark - 系统方法
- (BOOL)respondsToSelector:(SEL)selector {
    if ([super respondsToSelector:selector])
        return YES;
    
    for (id delegate in self.delegateArray) {
        if (delegate && [delegate respondsToSelector:selector])
            return YES;
    }
    
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (signature)
        return signature;
    
    [self.delegateArray compact];
    if (self.delegateArray.count == 0) {
        return [self methodSignatureForSelector:@selector(description)];
    }
    
    for (id delegate in self.delegateArray) {//存储了各个对象的代理
        if (!delegate)
            continue;
        
        signature = [delegate methodSignatureForSelector:selector];
        if (signature)
            break;
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    for (id target in self.delegateArray) {
        if ([target respondsToSelector:invocation.selector]) {
            [invocation invokeWithTarget:target];
        }
    }
}

@end
