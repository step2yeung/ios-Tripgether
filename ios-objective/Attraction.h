//
//  Attraction.h
//  ios-objective
//
//  Created by Jackie Kong on 8/13/14.
//  Copyright (c) 2014 tripgether. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Attraction : NSObject

typedef NS_ENUM(NSInteger, AttractionType) {
    Food,
    Outdoors,
    Music,
    Museum
};

@property (strong, nonatomic) NSString* iD;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* source;
@property (nonatomic) AttractionType* type;
@property (strong, nonatomic) NSString* phone;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* photoUrl;
@property (strong, nonatomic) UIImage* photoData;
@property (nonatomic) CGSize photoSize;

- (instancetype) initWithData:(NSString*)iD name:(NSString*)name source:(NSString*)source type:(AttractionType*)type address:(NSString*)address;
- (instancetype) initWithData:(NSString*)iD name:(NSString*)name source:(NSString*)source type:(AttractionType*)type address:(NSString*)address phone:(NSString*)phone;
- (instancetype) initWithData:(NSString*)iD name:(NSString*)name source:(NSString*)source type:(AttractionType*)type address:(NSString*)address phone:(NSString*)phone photo:(NSString*)photo;

@end
