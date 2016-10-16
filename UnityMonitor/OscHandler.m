//
//  OSC_Handler.m
//  UnityMonitor
//
//  Created by Lukas Musy on 09/07/16.
//  Copyright © 2016 Lukas Musy. All rights reserved.
//

#import "OscHandler.h"
#import "MonitorViewController.h"

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
    if ([[components objectAtIndex:1] isEqualToString:@"UnityWatchdog"]) {
        
        //get adress and values fields
        NSString *displaySlot = [components objectAtIndex:2];
        int slotNumber = [[displaySlot substringFromIndex:[displaySlot length]-1] intValue];
        NSString *parameter = [components objectAtIndex:3];
        NSString *args = [[message.arguments valueForKey:@"description"] componentsJoinedByString:@":"];
        
        //notify view
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.owner displayParam:parameter withValue: args inSlot:slotNumber];
                });
    }
    
}




@end
