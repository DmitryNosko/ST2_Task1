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
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Photo picker";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addScrollView:)];
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.currentCustomView != nil) {
        
        [self.view addSubview:self.currentCustomView];
        self.currentCustomView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.currentCustomView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                                  [self.currentCustomView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
                                                  [self.currentCustomView.widthAnchor constraintEqualToConstant:100],
                                                  [self.currentCustomView.heightAnchor constraintEqualToConstant:100]
                                                  ]];
    }
}

- (void)addScrollView:(id) sender {
    SecondViewController* sVc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:sVc animated:YES];
}

#pragma mark - Gesture

- (void) handlePan:(UIPanGestureRecognizer*) panGesture {
    
    UIView* selectedView = [self.view hitTest:[panGesture locationInView:self.view] withEvent:nil];
    if (![selectedView isEqual:self.view]) {
        self.currentCustomView = [self.view.subviews objectAtIndex:[self.view.subviews indexOfObject:selectedView]];
        
        self.currentCustomView.center = [panGesture locationInView:self.view];
    }
}

- (void) handleTap:(UITapGestureRecognizer*) tapGesture {
    UIView* selectedView = [self.view hitTest:[tapGesture locationInView:self.view] withEvent:nil];
    if (![selectedView isEqual:self.view]) {
        self.currentCustomView = [self.view.subviews objectAtIndex:[self.view.subviews indexOfObject:selectedView]];
        self.title = self.currentCustomView.imageURL;
    } else {
        self.title = @"Photo picker";
    }
}



@end

