//
//  ViewController.m
//  ios-objective
//
//  Created by Jackie Kong on 8/13/14.
//  Copyright (c) 2014 tripgether. All rights reserved.
//

#import "MainViewController.h"
#import "City.h"
#import "TastesPickerViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toTastes"]) {
        if ([segue.destinationViewController isKindOfClass:[TastesPickerViewController class]]) {
            NSString *cityName = [self.cityTextField text];
            City *city = [[City alloc] initWithName:cityName];
            TastesPickerViewController * tpvc = (TastesPickerViewController*) segue.destinationViewController;
            [tpvc setCity:city];
        }
    }
}

@end
