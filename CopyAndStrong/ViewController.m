//
//  ViewController.m
//  CopyAndStrong
//
//  Created by kim on 2018/10/14.
//  Copyright © 2018年 kedc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSString * sStr;
@property (nonatomic, copy) NSString * cStr;

@property (nonatomic, strong) NSArray * sArr;
@property (nonatomic, copy) NSArray * cArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self 研究Copy和MutableCopy];

    [self 研究Copy和Strong];

}

- (void)研究Copy和Strong {

    [self customLog: @"kim 研究Copy和Strong ==============="];

    [self proof1];
    [self proof2];
    [self proof3];
    [self proof4];
    [self proof5];

    [self proof2_str];

    [self customLog: @"kim 研究Copy和Strong ==============="];

}

- (void)proof1 {

    [self customLog: @"-- proof1 --"];

    NSArray *tmpArr = @[@1];

    NSLog(@"赋值前：%d", (int)CFGetRetainCount((__bridge CFTypeRef)tmpArr));

    self.sArr = tmpArr;

    NSLog(@"赋值后：%ld", CFGetRetainCount((__bridge CFTypeRef)tmpArr));

}

- (void)proof2 {

    [self customLog: @"-- proof2 --"];

    NSArray *tmpArr = @[@1];

    NSLog(@"tmpArr：%p", tmpArr);

    self.cArr = tmpArr;

    NSLog(@"self.cArr：%p", self.cArr);

}

- (void)proof2_str {

    [self customLog: @"-- proof2_str --"];

    NSString *tmpStr = @"hi";

    NSLog(@"tmpStr：%p", tmpStr);

    self.cStr = tmpStr;

    NSLog(@"cStr：%p", self.cStr);

}

- (void)proof3 {

    [self customLog: @"-- proof3 --"];

    NSMutableArray *tmpArr_mute = [NSMutableArray arrayWithObject:@1];

    NSLog(@"tmpArr：%p", tmpArr_mute);

    self.cArr = tmpArr_mute;

    NSLog(@"self.cArr：%p", self.cArr);

}

- (void)proof4 {

    [self customLog: @"-- proof4 --"];

    NSMutableArray *tmpArr_mute = [NSMutableArray arrayWithObject:@1];
    NSArray *tmpArr = @[@1];

    NSLog(@"tmpArr_mute：%@", [tmpArr_mute class]);
    NSLog(@"tmpArr：%@", [tmpArr class]);

    self.cArr = tmpArr_mute;
    NSLog(@"赋值可变 - self.cArr：%@", [self.cArr class]);

    self.cArr = tmpArr;
    NSLog(@"赋值不可变 - self.cArr：%@", [self.cArr class]);

}

- (void)proof5 {

    [self customLog: @"-- proof5 --"];

    NSMutableArray *tmpArr_mute = [NSMutableArray arrayWithObject:@1];
    NSArray *tmpArr = @[@1];

    NSLog(@"赋值可变前：%d", (int)CFGetRetainCount((__bridge CFTypeRef)tmpArr_mute));
    NSLog(@"赋值不可变前：%d", (int)CFGetRetainCount((__bridge CFTypeRef)tmpArr));

    self.cArr = tmpArr_mute;
    NSLog(@"赋值可变后：%ld", CFGetRetainCount((__bridge CFTypeRef)tmpArr_mute));

    self.cArr = tmpArr;
    NSLog(@"赋值不可变后：%ld", CFGetRetainCount((__bridge CFTypeRef)tmpArr));

}

- (void)研究Copy和MutableCopy {

    [self customLog: @"研究Copy和MutableCopy ==============="];

    [self copy和mutableCopy: @"字符串"
                    不可变源: @""
                      可变源: [NSMutableString stringWithString:@""]];

    [self copy和mutableCopy: @"数组"
                    不可变源: [NSArray array]
                     可变源: [NSMutableArray array]];

    [self copy和mutableCopy: @"字典"
                    不可变源: [NSDictionary dictionary]
                     可变源: [NSMutableDictionary dictionary]];

    [self copy和mutableCopy: @"集合"
                    不可变源: [NSSet set]
                     可变源: [NSMutableSet set]];

    [self NSNumber的Copy];

}

- (void)copy和mutableCopy:(NSString*)标题
                    不可变源:(id)不可变源
                       可变源:(id)可变源{

    [self customLog: 标题];
    NSLog(@"不可变源: %p, %@",不可变源, [不可变源 class]);
    NSLog(@"可变源: %p, %@", 可变源, [可变源 class]);

    [self customLog: @"Copy"];
    id 不可变调用Copy = [不可变源 copy];
    id 可变调用Copy = [可变源 copy];
    NSLog(@"不可变调用Copy: %p, %@", 不可变调用Copy, [不可变调用Copy class]);
    NSLog(@"可变调用Copy: %p, %@", 可变调用Copy, [可变调用Copy class]);

    [self customLog: @"mutableCopy"];
    id 不可变调用MutableCopy = [不可变源 mutableCopy];
    id 可变调用MutableCopy = [可变源 mutableCopy];
    NSLog(@"不可变调用MutableCopy: %p, %@", 不可变调用MutableCopy, [不可变调用MutableCopy class]);
    NSLog(@"可变调用MutableCopy: %p, %@", 可变调用MutableCopy, [可变调用MutableCopy class]);
    [self logEnd];

}

- (void)NSNumber的Copy {

    [self customLog: @"NSNumber"];
    NSNumber *源NSNumber = [NSNumber numberWithInt:10];
    NSLog(@"originNum: %p, %@", 源NSNumber, [源NSNumber class]);
    id copyNum = [源NSNumber copy];
    NSLog(@"copyNum  : %p, %@", copyNum, [copyNum class]);
    [self logEnd];
}

- (void)customLog:(NSString *)str {

    NSLog(@"========== %@ ===========", str);
}

- (void)logEnd {

    NSLog(@"=========================");
    NSLog(@"");

}

- (void)logObj:(id)obj desc:(NSString*)desc {

    NSLog(@"%@ == %ld == %p == %@",
          desc,
          CFGetRetainCount((__bridge CFTypeRef)(obj)),
          obj,
          [obj class]
          );

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
