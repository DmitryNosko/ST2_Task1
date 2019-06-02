//
//  CustomView.m
//  PhotoPicker
//
//  Created by Dima  on 6/2/19.
//  Copyright © 2019 Dima . All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString*) name url:(NSString*) url
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageURL = url;
        _imageName = name;
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:self.imageName];
    CGRect imageRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, rect.size.height);
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), imageRect, image.CGImage);
}

@end
