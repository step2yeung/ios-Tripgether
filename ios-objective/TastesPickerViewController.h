//
//  TasteViewController.h
//  ios-objective
//
//  Created by Jackie Kong on 8/13/14.
//  Copyright (c) 2014 tripgether. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface TastesPickerViewController : UIViewController<CityDelegate>{}

@property (strong, nonatomic) City *city;
@property (strong, nonatomic) NSArray *tastes;

@end
