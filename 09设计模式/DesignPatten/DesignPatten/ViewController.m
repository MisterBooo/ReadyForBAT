//
//  ViewController.m
//  DesignPatten
//
//  Created by MisterBooo on 2018/5/4.
//  Copyright © 2018年 MisterBooo. All rights reserved.
//

#import "ViewController.h"
#import "BridgeDemo.h"
#import "CoolTarget.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *arrayM = [NSMutableArray array];
    void(^blk)(void) = ^{
//        arrayM = [NSMutableArray array]; //不允许
        [arrayM addObject:@"object"];
    };
    blk();
    
}

- (IBAction)bridgeDemo:(id)sender {
    BridgeDemo *demo = [[BridgeDemo alloc] init];
    [demo fetch];
}

- (IBAction)adapterDemo:(id)sender {
    CoolTarget *cool = [[CoolTarget alloc] init];
    Target *target = [[Target alloc] init];
    cool.target = target;
    [cool request];
}
@end
