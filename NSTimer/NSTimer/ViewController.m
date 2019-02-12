//
//  ViewController.m
//  NSTimer
//
//  Created by yy on 2019/2/12.
//  Copyright © 2019年 1. All rights reserved.
//

#import "ViewController.h"
#import "PushViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)push:(id)sender {
    PushViewController * pushVC = [[PushViewController alloc]init];
    [self.navigationController pushViewController:pushVC animated:YES];
}

@end
