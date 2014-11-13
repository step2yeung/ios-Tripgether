//
//  ChooseAttractionView.h
//  ios-objective
//
//  Created by Stephen Yeung on 2014-08-25.
//  Copyright (c) 2014 tripgether. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MDCSwipeToChoose.h>

@class Attraction;

@interface ChooseAttractionView : MDCSwipeToChooseView

@property (nonatomic, strong, readonly) UIImage *image;;

- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
                         text:(NSString *)text
                      options:(MDCSwipeToChooseViewOptions *)options;

@end