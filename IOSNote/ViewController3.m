//
//  ViewController3.m
//  IOSNote
//
//  Created by PF on 2025/1/21.
//

#import "ViewController3.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self offScreen];
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

@end
