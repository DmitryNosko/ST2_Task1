//
//  MainViewController.m
//  PhotoPicker
//
//  Created by Dima  on 6/2/19.
//  Copyright © 2019 Dima . All rights reserved.
//

#import "MainViewController.h"
#import "SecondViewController.h"

@interface MainViewController ()
@property (assign, nonatomic) CGPoint touchOffset;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Photo picker";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addScrollView:)];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.draggingCustomView != nil) {
        [self.view addSubview:self.draggingCustomView];
        self.draggingCustomView.frame = CGRectMake(self.view.center.x - 50, self.view.center.y - 50, 100, 100);
    }
 }

#pragma mark - Navigation

- (void)addScrollView:(id) sender {
    SecondViewController* sVc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:sVc animated:YES];
}

#pragma mark - Touches

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    CGPoint pointOnMainView = [touch locationInView:self.view];
    UIView* view = [self.view hitTest:pointOnMainView withEvent:event];
    if (![view isEqual:self.view]) {
        self.draggingCustomView = ((CustomView*)view);
        self.title = self.draggingCustomView.imageURL;
        CGPoint touchPoint = [touch locationInView:self.draggingCustomView];
        self.touchOffset = CGPointMake(CGRectGetMidX(self.draggingCustomView.bounds) - touchPoint.x,
                                       CGRectGetMidY(self.draggingCustomView.bounds) - touchPoint.y);
    } else {
        self.draggingCustomView = nil;
        self.title = @"Photo picker";
    }
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    CGPoint pointOnMainView = [touch locationInView:self.view];
    if (self.draggingCustomView) {
        CGPoint correction = CGPointMake(pointOnMainView.x + self.touchOffset.x,
                                         pointOnMainView.y + self.touchOffset.y);
        self.draggingCustomView.center = correction;
    }
    
}


@end

