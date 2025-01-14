//
//  ViewController.m
//  IOSNote
//
//  Created by PF on 2025/1/13.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, <#dispatchQueue#>);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, <#intervalInSeconds#> * NSEC_PER_SEC, <#leewayInSeconds#> * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        <#code to be executed when timer fires#>
    });
    dispatch_activate(timer);
    NSProxy *aaa;
    NSLog(@"finished!");
}

#pragma mark -note
/**
 1. - (void)willMoveToWindow:(UIWindow *)newWindow
 2. NSTimer 和 CADisplayLink 内存泄漏问题和解决方案
 3. NSRunLoop关联哪些知识点
 4. Crash预防方案
 5. 事件传递和事件响应
 6. ios内存管理，内存区域
 7. NSProxy
 
 
 **/
@end
