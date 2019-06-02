//
//  CustomView.h
//  PhotoPicker
//
//  Created by Dima  on 6/2/19.
//  Copyright © 2019 Dima . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString*) name url:(NSString*) url;

@property (strong, nonatomic) NSString* imageURL;
@property (strong, nonatomic) NSString* imageName;

@end
