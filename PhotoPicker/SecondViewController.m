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
@property (strong, nonatomic) NSDictionary* imagesWithDiscription;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select item";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imagesWithDiscription = @{@"dog1" : @"http://url_dog1",
                                   @"dog2" : @"http://url_dog2",
                                   @"dog3" : @"http://url_dog3",
                                   @"dog4" : @"http://url_dog4",
                                   @"dog5" : @"http://url_dog5",
                                   @"dog6" : @"http://url_dog6",
                                   @"dog7" : @"http://url_dog7",
                                   @"dog8" : @"http://url_dog8",
                                   @"dog9" : @"http://url_dog9",
                                   @"dog10" : @"http://url_dog10",
                                   @"dog11" : @"http://url_dog11",
                                   @"dog12" : @"http://url_dog12",
                                   @"dog13" : @"http://url_dog13",
                                   @"cat1" : @"http://url_cat1",
                                   @"cat2" : @"http://url_cat2",
                                   @"cat3" : @"http://url_cat3",
                                   @"cat4" : @"http://url_cat4",
                                   @"cat5" : @"http://url_cat5",
                                   @"cat6" : @"http://url_cat6",
                                   @"cat7" : @"http://url_cat7",
                                   @"cat8" : @"http://url_cat8",
                                   @"cat9" : @"http://url_cat9",
                                   @"cat10" : @"http://url_cat10",
                                   @"cat11" : @"http://url_cat11",
                                   @"cat12" : @"http://url_cat12",
                                   @"car" : @"http://url_car",
                                   @"palace" : @"http://url_palace",
                                   @"river" : @"http://url_river",
                                   @"road" : @"http://url_road"
                                   };
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backToRootVC:)];
    
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * (self.imagesWithDiscription.count / 2))];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self scrollViewConstraints];

    [self fillScrollView];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapForDiscription:)];
    [self.scrollView addGestureRecognizer:tapGesture];
}

#pragma mark - Methods

- (void) fillScrollView {
    
    int step = 300;
    
    int i = 0;
    for(id key in self.imagesWithDiscription) {
        
        UIImage *image = [UIImage imageNamed:key];
        
        CGRect rectForImage = CGRectMake(50, i * step + 20, image.size.width, image.size.height);
        CGRect rectForDescription = CGRectMake(50, i * step + 263, image.size.width, 30);
        
        UILabel* descriptionLabel = [[UILabel alloc] initWithFrame:rectForDescription];
        descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.layer.cornerRadius = 5;
        descriptionLabel.layer.borderWidth = 1;
        descriptionLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        descriptionLabel.textColor = [UIColor blackColor];
        descriptionLabel.text = [self.imagesWithDiscription objectForKey:key];
        [self.scrollView addSubview:descriptionLabel];
        
        CustomView* customImageView = [[CustomView alloc] initWithFrame:rectForImage imageName:key url:[self.imagesWithDiscription objectForKey:key]];
        [customImageView drawRect:rectForImage];
        customImageView.layer.borderWidth = 3;
        customImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customImageView.layer.cornerRadius = 3;
        [self.scrollView addSubview:customImageView];
        
        i++;
    }
    
}


#pragma mark - Gesture

- (void)handleTapForDiscription:(UITapGestureRecognizer*) tapGesture {
    
    UIView* selectedView = [self.scrollView hitTest:[tapGesture locationInView:self.scrollView] withEvent:nil];
    if (![selectedView isEqual:self.scrollView]) {
        
        self.customView = [self.scrollView.subviews objectAtIndex:[self.scrollView.subviews indexOfObject:selectedView]];
        MainViewController* root = [self.navigationController.viewControllers objectAtIndex:0];
        root.draggingCustomView = self.customView;
        root.title = self.customView.imageURL;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

#pragma mark - Constraints

- (void) scrollViewConstraints {
    [NSLayoutConstraint activateConstraints:@[
                                              [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                              [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
                                              [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                              [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor]
                                              ]];
}

#pragma mark - Navigation

- (void)backToRootVC:(id) sender {
    MainViewController* root = [self.navigationController.viewControllers objectAtIndex:0];
    root.draggingCustomView = nil;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
