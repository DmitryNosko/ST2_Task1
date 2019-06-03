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

static NSString* const DEFAULT_TITLE_NAME = @"Photo picker";

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = DEFAULT_TITLE_NAME;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(moveToSecondView:)];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)moveToSecondView:(id) sender {
    SecondViewController* sVc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:sVc animated:YES];
}

- (void) handleTap:(UITapGestureRecognizer*) tapGesture {
    
    CGPoint pointOnMainView = [tapGesture locationInView:self.view];
    UIView* selectedView = [self.view hitTest:pointOnMainView withEvent:nil];
    if ([selectedView isEqual:self.view]) {
        self.draggingCustomView = nil;
        self.title = DEFAULT_TITLE_NAME;
    } else {
        self.draggingCustomView = ((CustomView*)selectedView);
        self.title = self.draggingCustomView.imageURL;
    }
}

- (void) addSelectedView:(NSString*) image url:(NSString*) url {
    CustomView* selectedView = [[CustomView alloc] initWithFrame:CGRectMake(self.view.center.x - 50, self.view.center.y - 50, 100, 100) imageName:image url:url];
    [self.view addSubview:selectedView];
}

@end

