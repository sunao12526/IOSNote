//
//  ViewController2.m
//  IOSNote
//
//  Created by PF on 2025/1/21.
//

#import "ViewController2.h"
#import "AObject.h"
#import "AsubObject.h"
@interface ViewController2 ()

@end

@implementation ViewController2

#pragma mark -note
/**
 1. runtime源码
 2. 内存布局
 3. 方法调用和消息转发过程
 4. category原理和底层结构
 5. 运行时加载类和初始化类的结构的过程
 6. class_rw_t 和 class_ro_t
 7. 属性和方法的区别
 8. 优先调用分类中的方法。如果存在多个分类，根据编译顺序晚编译优先调用
 9. 先调用本类load再分别调用各个分类的load；先编译的类先调用load；先调用父类的load再调用自己的load；
 10. 分类的load方法调用只和编译顺序有关
 11. weak的底层原理
 12. self和super的区别
 13. load方法与initialize方法调用的底层逻辑，时机，区别
 14. 关联对象底层原理
 15. autoReleasePool底层原理，gcd会自动配置autoReleasePool，NSThread不会自动配置autoReleasePool但是会走别的逻辑会走在main函数中的autoReleasePool
 
 **/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self test_NSError];
//    [self test_weak];
 
    [self block_byref];
 
}
 
-(void)block_byref{
    AsubObject *a = [AsubObject new];
      NSInteger obj = 0;
    NSLog(@"%p",&obj);
    void(^block)(void)=^(){
        
        NSLog(@"%p",&obj);
    };
    NSLog(@"%p",&obj);
    block();
    void(^block_strong)(void) = block;
    NSLog(@"%p",&obj);
    block_strong();
}

- (void)test_weak
{
    AObject *a = [AObject new];
    id __weak weakA = a;
}

- (void)test_initialize
{
    AsubObject *a = [AsubObject new];
}

- (void)test_property
{
    AObject *a = [AObject new];
    a.age = 1;
}

//NSError 内存泄漏
- (void)test_NSError {
    for (NSInteger index = 0; index <= 100; index++) {
        NSString *str;
        str = [NSString stringWithFormat:@"welcome to zoom:%ld", index];
        str = [str stringByAppendingString:@" user"];
        NSError * error = NULL;
//        NSError * __autoreleasing tmp = error; 编译器会替换成&temp
        if ([self isZoomUserWithUserID:index error:&error]) {
            // error = tmp;编译器会添加替换error成tmp;
            NSLog(@"%@", str);
        } else {
            NSLog(@"%@", error);
        }
    }
}
- (BOOL)isZoomUserWithUserID:(NSInteger)userID error:(NSError **)error
{
    @autoreleasepool {
        NSString *errorMessage = [[NSString alloc] initWithFormat:@"the user is not zoom user"];
        if (userID == 100) {
            *error = [NSError errorWithDomain:@"com.test" code:userID userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
            return NO;
        }
    }
    return YES;
}

@end
