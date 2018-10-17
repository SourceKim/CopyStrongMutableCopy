//
//  NSString+NotiCopyAndMutableCopy.m
//  CopyAndStrong
//
//  Created by kim on 2018/10/14.
//  Copyright © 2018年 kedc. All rights reserved.
//

#import "NSString+NotiCopyAndMutableCopy.h"
#import "objc/runtime.h"

@implementation NSObject (NotiCopyAndMutableCopy)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"Start swizzing");
//        [self swizzCopy];
//        [self swizzMutableCopy];
        NSLog(@"Finish swizzing");
    });
}

+ (void)swizzCopy {
    Class class = [self class];
    SEL originalSelector = @selector(copy);
    SEL swizzledSelector = @selector(kCopy);
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)swizzMutableCopy {
    Class class = [self class];
    SEL originalSelector = @selector(mutableCopy);
    SEL swizzledSelector = @selector(kMutableCopy);
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark - Method Swizzling
- (id)kCopy {
    NSLog(@"%p, 触发了 COPY", self);
    return [self kCopy];
}

- (id)kMutableCopy {
    NSLog(@"%p, 触发了 MUTABLECOPY", self);
    return [self kMutableCopy];
}

@end
