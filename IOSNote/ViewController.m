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
                   @"kvo",
                   @"kvc",
                   @"block",
                   @"多线程相关（gcd、operation、锁）",
                   @"SDWebImage源码",
                   @"属性关键字copy，与深复制、浅复制",
                   @"load方法与initialize方法的区别和作用",
                   @"归档NSKeyedArchiver与NSCoding协议",
                   @"NSNotification",
                   @"mqtt",
                   @"Objection",
    ];
    [self test_NSError];
}

//NSError 内存泄漏的 case
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


//离屏渲染 mask shadow allowsGroupOpacity cornerRadius+masksToBounds+有子layer
-(void)offScreen
{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100,100)];
//    view.backgroundColor = [UIColor redColor];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200,200)];
//    imageView.backgroundColor = [UIColor blueColor];
//    [imageView addSubview: view];
//    imageView.layer.opacity = 0.9;
//    imageView.layer.allowsGroupOpacity = NO;
//    [self.view addSubview:imageView];
    
    UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
    view.frame = CGRectMake(0, 0, 400,400);
    view.backgroundColor = [UIColor blueColor];
//    view.layer.masksToBounds = YES;
//    view.layer.cornerRadius = 30;
    [self.view addSubview:view];
    
    UIButton* bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(200 -20, 300-50, 200, 100);
    bt.backgroundColor = [UIColor redColor];
//    bt.layer.shadowColor = [UIColor greenColor].CGColor;
//    bt.layer.shadowOpacity = 1;
//    bt.layer.shadowOffset = CGSizeMake(5, 5);
    [view addSubview:bt];
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor greenColor].CGColor;
    layer.frame = CGRectMake(0, 0, 100, 100);
    bt.layer.mask = layer;
    
}

-(void)runloop
{
    static CFRunLoopObserverRef observer;
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFOptionFlags activities = kCFRunLoopAllActivities;
    
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self,
        &CFRetain,
        &CFRelease,
        NULL
    };
    observer = CFRunLoopObserverCreate(NULL,
                                       activities,
                                       YES,
                                       INT_MAX,
                                       &_transactionGroupRunLoopObserverCallback,
                                       &context);
    CFRunLoopAddObserver(runLoop, observer, kCFRunLoopCommonModes);
    CFRelease(observer);
    
    [self performSelectorOnMainThread:@selector(test) withObject:nil waitUntilDone:NO];
    [self performSelector:@selector(test) withObject:nil afterDelay:5];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self test];
    });
}
static void _transactionGroupRunLoopObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void* info) {
    CustomLog(@"111111!");
    if(activity == kCFRunLoopEntry){
        NSLog(@"进入 Runloop");
    }else if(activity == kCFRunLoopBeforeWaiting){
        NSLog(@"即将进入等待状态");
    }else if(activity == kCFRunLoopAfterWaiting){
        NSLog(@"结束等待状态");
    }
    else if(activity == kCFRunLoopExit){
        NSLog(@"退出 Runloop");
    }
    else if(activity == kCFRunLoopBeforeSources){
        NSLog(@"即将处理 Source");
    }
    else if(activity == kCFRunLoopBeforeTimers){
        NSLog(@"即将处理 Timer");
    }
}

void CustomLog(NSString *format, ...) { va_list args; va_start(args, format); NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:args]; va_end(args); NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"]; NSString *timestamp = [dateFormatter stringFromDate:[NSDate date]]; fprintf(stderr, "%s %s\n", [timestamp UTF8String], [formattedString UTF8String]); }

-(void)test
{
    NSLog(@"finished!");
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
 
 
 
 
 
 
 **/
@end
