//
//  ViewController4.m
//  IOSNote
//
//  Created by PF on 2025/1/21.
//

#import "ViewController4.h"

@interface ViewController4 ()

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self runloop];
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

@end
