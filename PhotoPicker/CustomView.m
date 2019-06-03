//
//  CustomView.m
//  PhotoPicker
//
//  Created by Dima  on 6/2/19.
//  Copyright © 2019 Dima . All rights reserved.
//

#import "CustomView.h"
@interface CustomView ()
@property (assign, nonatomic) CGPoint touchOffset;
@end

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
    CGRect imageRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, rect.size.height);
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), imageRect, image.CGImage);
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    self.touchOffset = CGPointMake(CGRectGetMidX(self.bounds) - touchPoint.x,
                                   CGRectGetMidY(self.bounds) - touchPoint.y);
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.superview];
    CGPoint correction = CGPointMake(touchPoint.x + self.touchOffset.x,
                                     touchPoint.y + self.touchOffset.y);
    self.center = correction;
    
}

@end
