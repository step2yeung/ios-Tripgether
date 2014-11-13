//
//  City.h
//  ios-objective
//
//  Created by Jackie Kong on 8/13/14.
//  Copyright (c) 2014 tripgether. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attraction.h"

@protocol CityDelegate

@optional
- (void) getAttractionsSucceeded;
- (void) getAttractionsFailed:(NSString *)failedMessage;
@end

@interface City : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, assign) id delegate;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSMutableArray *attractions;
@property (strong, nonatomic) NSMutableArray *attractionsLiked;
@property (strong, nonatomic) NSMutableArray *attractionsDisliked;

- (instancetype) initWithName:(NSString*) name;
- (void) getAttractions: (NSArray*) byTastes;
- (void) getAttraction: (NSString*) byTaste;
- (Attraction*) getNextAttraction;
@end
