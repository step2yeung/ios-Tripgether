//
//  TasteViewController.m
//  ios-objective
//
//  Created by Jackie Kong on 8/13/14.
//  Copyright (c) 2014 tripgether. All rights reserved.
//

#import "TastesPickerViewController.h"
#import "AttractionsPickerViewController.h"

@interface TastesPickerViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *tasteButtons;
@property (strong, nonatomic) NSMutableArray* userRankedTastes;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation TastesPickerViewController

- (NSMutableArray *) userRankedTastes {
    if (!_userRankedTastes) _userRankedTastes = [[NSMutableArray alloc] init];
    return _userRankedTastes;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)selectTaste:(id)sender {
    UIButton *selectedButton = (UIButton*) sender;
    NSString *chosenTaste = selectedButton.currentTitle;
    
    NSRange range = [chosenTaste rangeOfString:@"-"];
    
    if (range.location != NSNotFound) {
        chosenTaste = [chosenTaste substringToIndex:(range.location-1)];
    }
    
    NSInteger index = [self.userRankedTastes indexOfObject:chosenTaste];
    
    NSLog(@"%@", [self.userRankedTastes description]);
    
    NSLog(@"chosenTaste - %@ @ index %zd", chosenTaste, index);
    
    if (index == NSNotFound) {
        [self.userRankedTastes addObject:chosenTaste];
        // add code to call server to get attractions related to this taste
        self.city.delegate = self;
        [self.city getAttraction:chosenTaste];
        
    } else {
        [self.userRankedTastes removeObject:chosenTaste];
        [selectedButton setTitle:chosenTaste forState:UIControlStateNormal];
    }
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *tasteButton in self.tasteButtons) {
        NSString *taste = tasteButton.currentTitle;
        NSRange range = [taste rangeOfString:@"-"];
        
        if (range.location != NSNotFound) {
            taste = [taste substringToIndex:(range.location-1)];
        }

        NSInteger index = [self.userRankedTastes indexOfObject:taste];
        if (index != NSNotFound) {
            [tasteButton setTitle:[NSString stringWithFormat:@"%@ - %zd", taste, index] forState:UIControlStateNormal];
        }
    }
    
    if ([self.userRankedTastes count] == 0 && [self.nextButton.currentTitle isEqualToString:@"Continue"]){
        [self.nextButton setTitle:@"Skip" forState:UIControlStateNormal];
    } else if([self.userRankedTastes count] > 0 && [self.nextButton.currentTitle isEqualToString:@"Skip"]) {
        [self.nextButton setTitle:@"Continue" forState:UIControlStateNormal] ;
    }
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toAttractions"]) {
        if ([segue.destinationViewController isKindOfClass:[AttractionsPickerViewController class]]) {
            AttractionsPickerViewController * apvc = (AttractionsPickerViewController*) segue.destinationViewController;
            [apvc setCity:self.city];
            [apvc setTastes:self.userRankedTastes];
        }
    }
}

#pragma CityDelegate
- (void) getAttractionsSucceeded{
    NSLog(@"getAttractionsSucceeded");
    
}

- (void) getAttractionsFailed:(NSString *)failedMessage {
    NSLog(@"getAttractionsFailed: %@", failedMessage);
}
@end
