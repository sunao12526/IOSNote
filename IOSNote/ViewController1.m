//
//  ViewController1.m
//  IOSNote
//
//  Created by PF on 2025/1/15.
//

#import "ViewController1.h"
#import "AView.h"
@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    AView *aView = [[AView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    aView.backgroundColor = [UIColor redColor];
    [self.view addSubview:aView];
    
    AView *aView2 = [[AView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    aView2.backgroundColor = [UIColor blueColor];
    [aView addSubview:aView2];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"1111");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
