//
//  OSC_Handler.h
//  UnityMonitor
//
//  Created by Lukas Musy on 09/07/16.
//  Copyright © 2016 Lukas Musy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OSCKit/OSCKit.h>
#import "MonitorViewController.h"

@interface OscHandler : NSObject <OSCServerDelegate>

@property (strong, nonatomic) OSCServer *server;
@property (strong, nonatomic) MonitorViewController *owner;

- (instancetype)initWithOwner:(MonitorViewController*)owner;
- (void)handleMessage:(OSCMessage*)message;


@end
