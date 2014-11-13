//
//  AttractionsPickerViewController.h
//  ios-objective
//
//  Created by Jackie Kong on 8/13/14.
//  Copyright (c) 2014 tripgether. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "Attraction.h"
#import "ChooseAttractionView.h"

@interface AttractionsPickerViewController : UIViewController<MDCSwipeToChooseDelegate> {
}

@property (strong, nonatomic) City *city;
@property (strong, nonatomic) NSArray *tastes;
@property (nonatomic, strong) ChooseAttractionView *frontCardView;
@property (nonatomic, strong) ChooseAttractionView *backCardView;

@end
