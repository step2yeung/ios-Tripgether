//
//  City.m
//  ios-objective
//
//  Created by Jackie Kong on 8/13/14.
//  Copyright (c) 2014 tripgether. All rights reserved.
//

#import "City.h"
#import "Attraction.h"

@interface City ()
@property (strong, nonatomic) NSMutableData *receivedData;
@end

@implementation City

- (instancetype) initWithName:(NSString*) name {
    self = [self init];
    if (self) {
        _name = name;
        _attractions = [[NSMutableArray alloc] initWithCapacity:100];
        _attractionsLiked = [[NSMutableArray alloc] initWithCapacity:50];
        _attractionsDisliked = [[NSMutableArray alloc] initWithCapacity:50];
    }
    return self;
}

- (void) getAttractions: (NSArray*) byTastes {
    // Create the request.
    
    for(NSString* taste in byTastes)
    {
        [self getAttraction:taste];
    }
}

- (void) getAttraction: (NSString*) byTaste {
    // Create the request.
    
    NSString *url = [NSString stringWithFormat:@"http://fast-lowlands-2164.herokuapp.com/foursquare_locations/%@/%@", self.name, @"sushi"];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
     NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // Create the NSMutableData to hold the received data.
    // receivedData is an instance variable declared elsewhere.
    self.receivedData = [NSMutableData dataWithCapacity: 0];
    
    // create the connection with the request
    // and start loading the data
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];

    if (!connection) {
        // Release the receivedData object.
        self.receivedData = nil;
        
        // Inform the user that the connection failed.
    }
}

-(Attraction*) getNextAttraction{
    if(self.attractions.count > 0)
    {
        Attraction* curAttraction = self.attractions[0];
        [self.attractions removeObjectAtIndex:0];
        return curAttraction;
    }
    return nil;
}

#pragma NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
didFailWithError:(NSError *)error {
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    connection = nil;
    self.receivedData = nil;
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    if ([self.delegate respondsToSelector:@selector(getAttractionsFailed:)]) {
        [self.delegate getAttractionsFailed:[error localizedDescription]];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a property elsewhere
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[self.receivedData length]);
    NSData* responseData = self.receivedData;
    NSError* error = nil;
    
    id attractionsList = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    
    if ([attractionsList isKindOfClass:[NSArray class]] && error == nil)
    {
        NSLog(@"dictionary: %@", attractionsList);
        for(NSDictionary* att in attractionsList)
        {
            Attraction* a = [[Attraction alloc] initWithData:att[@"id"] name:att[@"name"] source:att[@"source"] type:Food address:att[@"address"] phone:att[@"phone"] photo:att[@"photo"]];
            
            [self.attractions addObject:a];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(getAttractionsSucceeded)]) {
        [self.delegate getAttractionsSucceeded];
    }
    
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    connection = nil;
    self.receivedData = nil;
}

@end
