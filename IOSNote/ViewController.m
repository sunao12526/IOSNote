//
//  ViewController.m
//  IOSNote
//
//  Created by PF on 2025/1/13.
//

#import "ViewController.h"
#import "AObject.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _dataArray = @[@"事件响应者链",
                   @"runtime相关",
                   @"UI相关",
                   @"runloop相关",
                   
                   
                   
                   @"多线程相关（gcd、operation、锁）",
                   @"SDWebImage源码",
                   @"属性关键字copy，与深复制、浅复制",
                   @"load方法与initialize方法的区别和作用",
                   @"归档NSKeyedArchiver与NSCoding协议",
                   @"NSNotification",
                   @"mqtt",
                   @"Objection",
    ];
  
}

# pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
static NSString *cellIdentfier = @"Cell";
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentfier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentfier];
    }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class a = NSClassFromString([NSString stringWithFormat:@"ViewController%ld",(indexPath.row+1)]);
    [self presentViewController:[a new] animated:YES completion:nil];
  
    //解决 编译警告PerformSelector may cause a leak because its selector is unknown
//    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"test%ld",(indexPath.row+1)]);
//    IMP imp = [self methodForSelector:sel];
//    void (*func) (id, SEL) = (void *)imp;
//    if ([self respondsToSelector:sel]) {
//        func(self, sel);
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 80;
}

-(void)dealloc{
    NSLog(@"dealloc");
}
  

#pragma mark -note
/**
 1. - (void)willMoveToWindow:(UIWindow *)newWindow
 2. NSTimer 和 CADisplayLink 内存泄漏问题和解决方案
 3. NSRunLoop关联哪些知识点
 4. Crash预防方案
 5. 事件传递和事件响应
 6. 内存管理
 7. NSProxy
 8. 离屏渲染(allowsGroupOpacity)
 9. 内存布局
 10. 静态库，动态库和Framework的区别（假设一个静态库，库中有OC写的分类，但分类所属的类定义不在库中如NSString。
 在把这个静态库集成到工程里后，如果编译设置other linker flags没有添加-ObjC，那么在使用这个OC分类的方法时，就会在运行时奔溃: unrecognized selector sent to class ..
 解决办法：在编译设置other linker flags添加-ObjC）
 11.
 **/
@end
