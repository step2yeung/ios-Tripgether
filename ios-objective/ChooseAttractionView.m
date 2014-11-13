//
//  ChooseAttractionView.m
//  ios-objective
//
//  Created by Stephen Yeung on 2014-08-25.
//  Copyright (c) 2014 tripgether. All rights reserved.
//

#import "ChooseAttractionView.h"

@interface ChooseAttractionView ()
@property (nonatomic, strong) UIView *informationView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation ChooseAttractionView

#pragma mark - Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
                       image:(UIImage *)image
                         text:(NSString *)text
                      options:(MDCSwipeToChooseViewOptions *)options {
    self = [super initWithFrame:frame options:options];
    if (self) {
        self.imageView.image = image;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleBottomMargin;
        self.imageView.autoresizingMask = self.autoresizingMask;
        
        [self constructInformationView:text];
    }
    return self;
}

- (void)constructInformationView:(NSString*) text{
    CGFloat bottomHeight = 60.f;
    CGRect bottomFrame = CGRectMake(0,
                                    CGRectGetHeight(self.bounds) - bottomHeight,
                                    CGRectGetWidth(self.bounds),
                                    bottomHeight);
    _informationView = [[UIView alloc] initWithFrame:bottomFrame];
    _informationView.backgroundColor = [UIColor whiteColor];
    _informationView.clipsToBounds = YES;
    _informationView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_informationView];
    
    [self constructNameLabel:text];
}

- (void)constructNameLabel:(NSString*) text{
    CGFloat leftPadding = 12.f;
    CGFloat topPadding = 17.f;
    CGRect frame = CGRectMake(leftPadding,
                              topPadding,
                              floorf(CGRectGetWidth(_informationView.frame)/2),
                              CGRectGetHeight(_informationView.frame) - topPadding);
    _nameLabel = [[UILabel alloc] initWithFrame:frame];
    _nameLabel.text = text;
    [_informationView addSubview:_nameLabel];
}

@end