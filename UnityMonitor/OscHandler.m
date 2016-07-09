//
//  OSC_Handler.m
//  UnityMonitor
//
//  Created by Lukas Musy on 09/07/16.
//  Copyright © 2016 Lukas Musy. All rights reserved.
//

#import "OscHandler.h"

#define RECEIVEPORT 3333


@implementation OscHandler

- (id)initWithOwner:(MonitorViewController*)owner
{
    self = [super init];
    if (self) {
        self.owner = owner;
        
        self.server = [[OSCServer alloc]init];
        self.server.delegate = self;
        [self.server listen:RECEIVEPORT];
    }
    return self;
}

- (void)handleMessage:(OSCMessage*)message {
    //split address
    NSArray *components = [message.address componentsSeparatedByString:@"/"];
    if ([[components objectAtIndex:1] isEqualToString:@"profiler"]) {
        NSString *parameter = [components objectAtIndex:2];
        NSString *args = [[message.arguments valueForKey:@"description"] componentsJoinedByString:@":"];
        //        NSString *subsection =[components objectAtIndex:1];
        //        NSString *subsection_formatted = [[subsection stringByReplacingOccurrencesOfString:@"_" withString:@" "]capitalizedString];
        
        
        NSString *param_formated_sel = [parameter stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        param_formated_sel = [param_formated_sel lowercaseString];
        param_formated_sel = [param_formated_sel stringByAppendingString:@":"];
        
        SEL selector = NSSelectorFromString(param_formated_sel);
        if ([self respondsToSelector:selector]) {
            [self performSelector:selector withObject:[NSArray arrayWithObjects:parameter, args, nil]];
            
        }
    }
}

- (void)vsync:(NSArray *)container{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.owner displayParam:[container objectAtIndex:0] withValue: [container objectAtIndex:1]];
    });
    
}

- (void)mesh_memory:(NSArray *)container{
    
}

- (void)contacts:(NSArray *)container{
    if ([[container objectAtIndex:1] isEqualToString:@"1"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.owner vibrate];
        });
    }
}

@end
