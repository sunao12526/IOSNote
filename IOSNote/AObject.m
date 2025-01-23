//
//  AObject.m
//  IOSNote
//
//  Created by PF on 2025/1/20.
//

#import "AObject.h"
@implementation AObject
//@dynamic age;

+(void)initialize
{
    NSLog(@"initialize");
}
-(void)dealloc
{
    NSLog(@"%@ %ld", self,CFGetRetainCount((__bridge CFTypeRef)self));
    NSLog(@"dealloc");
}
@end
