//
//  Attraction.m
//  ios-objective
//
//  Created by Jackie Kong on 8/13/14.
//  Copyright (c) 2014 tripgether. All rights reserved.
//

// Attractions for a city should be saved on device, so that it can be re-accessed later so user doesnt have to
// yes/no the same attraction
// talk to damoun to parse the response from our attraction getter API to a known response structure
// need schema

#import "Attraction.h"

@implementation Attraction

- (instancetype) initWithData:(NSString*)iD name:(NSString*)name source:(NSString*)source type:(AttractionType*)type address:(NSString*)address {
    self = [self init];
    if (self) {
        _name = name;
        _iD = iD;
        _source = source;
        _type = type;
        _address = address;
    }
    return self;
}

- (instancetype) initWithData:(NSString*)iD name:(NSString*)name source:(NSString*)source type:(AttractionType*)type address:(NSString*)address phone:(NSString*)phone {
    self = [self init];
    if (self) {
        _name = name;
        _iD = iD;
        _source = source;
        _type = type;
        _address = address;
        _phone = phone;
    }
    return self;
}

- (instancetype) initWithData:(NSString*)iD name:(NSString*)name source:(NSString*)source type:(AttractionType*)type address:(NSString*)address phone:(NSString*)phone photo:(NSString*)photo{
    self = [self init];
    if (self) {
        _name = name;
        _iD = iD;
        _source = source;
        _type = type;
        _address = address;
        _phone = phone;
        _photoUrl = photo;
        if([_photoUrl length] != 0)
        {
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSURL *url = [NSURL URLWithString:_photoUrl];
                NSData * data = [[NSData alloc] initWithContentsOfURL:url];
                if ( data == nil )
                    return;
                dispatch_async(dispatch_get_main_queue(), ^{
                    // WARNING: is the cell still using the same data by this point??
                    _photoData= [[UIImage alloc] initWithData: data];
                    _photoSize=  _photoData.size;
                });
            });
        }
        
        
    }
    return self;
}

@end
