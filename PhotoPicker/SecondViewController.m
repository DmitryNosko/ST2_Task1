//
//  SecondViewController.m
//  PhotoPicker
//
//  Created by Dima  on 6/2/19.
//  Copyright © 2019 Dima . All rights reserved.
//

#import "SecondViewController.h"
#import "CustomView.h"
#import "MainViewController.h"


@interface SecondViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) CustomView* customView;
@property (weak, nonatomic) UILabel* descriptionLabel;
@property (weak, nonatomic) MainViewController* mainVC;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select item";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backToRootVC:)];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 9)];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CustomView* view = [[CustomView alloc] init];
    [view drawRect:CGRectMake(50, 100, 320, 100)];
    [self.view addSubview:view];
    
    [self scrollViewConstraints];
    
    int step = 200;
    
    NSDictionary* imagesWithURL = @{@"BY" : @"http://url_BY",
                                    @"UA" : @"http://url_UA",
                                    @"MD" : @"http://url_MD",
                                    @"KG" : @"http://url_KG"
                                    };
    
    int i = 0;
    for(id key in imagesWithURL) {
        CGRect rectForImage = CGRectMake(50, i * step + 20, 320, 130);
        CGRect rectForDescription = CGRectMake(50, i * step + 152, 320, 30);
        
        UILabel* descriptionLabel = [[UILabel alloc] initWithFrame:rectForDescription];
        descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.layer.cornerRadius = 5;
        descriptionLabel.layer.borderWidth = 1;
        descriptionLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        descriptionLabel.textColor = [UIColor blackColor];
        descriptionLabel.text = [imagesWithURL objectForKey:key];
        CustomView* customImageView = [[CustomView alloc] initWithFrame:rectForImage imageName:key url:[imagesWithURL objectForKey:key]];
        [customImageView drawRect:rectForImage];
        customImageView.layer.borderWidth = 3;
        customImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customImageView.layer.cornerRadius = 3;
        [self.scrollView addSubview:customImageView];
        [self.scrollView addSubview:descriptionLabel];
        
        i++;
    }
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapForDiscripyion:)];
    [self.scrollView addGestureRecognizer:tapGesture];
    
}


#pragma mark - Gesture

- (void)handleTapForDiscripyion:(UITapGestureRecognizer*) tapGesture {
    
    UIView* selectedView = [self.scrollView hitTest:[tapGesture locationInView:self.scrollView] withEvent:nil];
    if (![selectedView isEqual:self.scrollView]) {
        
        self.customView = [self.scrollView.subviews objectAtIndex:[self.scrollView.subviews indexOfObject:selectedView]];
        MainViewController* root = [self.navigationController.viewControllers objectAtIndex:0];
        root.currentCustomView = self.customView;
        root.title = self.customView.imageURL;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

#pragma mark - Constraints

- (void)backToRootVC:(id) sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) scrollViewConstraints {
    [NSLayoutConstraint activateConstraints:@[
                                              [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                              [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
                                              [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                              [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor]
                                              ]];
}



@end
