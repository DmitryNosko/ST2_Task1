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
@property (weak, nonatomic) MainViewController* mainVC;
@property (strong, nonatomic) NSDictionary* imageNameToURL;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select item";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageNameToURL = @{@"dog1" : @"http://url_dog1",
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(moveToRootView:)];
    
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * (self.imageNameToURL.count / 2))];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self setScrollViewConstraints];

    [self fillScrollView];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToFirstView:)];
    [self.scrollView addGestureRecognizer:tapGesture];
}

- (void) setScrollViewConstraints {
    [NSLayoutConstraint activateConstraints:@[
                                              [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                              [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
                                              [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                              [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor]
                                              ]];
}

- (void) fillScrollView {
    
    CustomView* prevView = nil;
    
    for(id key in self.imageNameToURL) {
        UIImage *image = [UIImage imageNamed:key];
        
        UILabel* descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.layer.cornerRadius = 5;
        descriptionLabel.layer.borderWidth = 1;
        descriptionLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        descriptionLabel.textColor = [UIColor blackColor];
        descriptionLabel.text = [self.imageNameToURL objectForKey:key];
        [self.scrollView addSubview:descriptionLabel];
        
        CustomView* customImageView = [[CustomView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height) imageName:key url:[self.imageNameToURL objectForKey:key]];
        customImageView.layer.borderWidth = 2;
        customImageView.layer.borderColor = [UIColor blackColor].CGColor;
        [self.scrollView addSubview:customImageView];
        
        customImageView.translatesAutoresizingMaskIntoConstraints = NO;
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
                                                  [customImageView.centerXAnchor constraintEqualToAnchor:self.scrollView.safeAreaLayoutGuide.centerXAnchor],
                                                  [customImageView.heightAnchor constraintEqualToConstant:image.size.height],
                                                  [customImageView.widthAnchor constraintEqualToConstant:image.size.width],
                                                  [descriptionLabel.topAnchor constraintEqualToAnchor:customImageView.bottomAnchor constant:4],
                                                  [descriptionLabel.heightAnchor constraintEqualToConstant:20],
                                                  [descriptionLabel.widthAnchor constraintEqualToConstant:image.size.width],
                                                  [descriptionLabel.centerXAnchor constraintEqualToAnchor:self.scrollView.safeAreaLayoutGuide.centerXAnchor]
                                                  ]];
        if (prevView == nil) {
            [NSLayoutConstraint activateConstraints:@[
                                                      [customImageView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:50]
                                                      ]];
        } else {
            [NSLayoutConstraint activateConstraints:@[
                                                      [customImageView.topAnchor constraintEqualToAnchor:prevView.bottomAnchor constant:50]
                                                      ]];
        }
        prevView = customImageView;
    }
}

- (void)moveToFirstView:(UITapGestureRecognizer*) tapGesture {
    
    UIView* selectedView = [self.scrollView hitTest:[tapGesture locationInView:self.scrollView] withEvent:nil];
    if (![selectedView isEqual:self.scrollView]) {
        
        self.customView = [self.scrollView.subviews objectAtIndex:[self.scrollView.subviews indexOfObject:selectedView]];
        MainViewController* root = [self.navigationController.viewControllers objectAtIndex:0];
        [root addSelectedView:self.customView.imageName url:self.customView.imageURL];
        root.title = self.customView.imageURL;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

- (void)moveToRootView:(id) sender {
    MainViewController* root = [self.navigationController.viewControllers objectAtIndex:0];
    root.draggingCustomView = nil;
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
