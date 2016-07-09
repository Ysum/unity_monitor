//
//  PDPatch.m
//  UnityMonitor
//
//  Created by Lukas Musy on 16/05/16.
//  Copyright © 2016 Lukas Musy. All rights reserved.
//

#import "PDPatch.h"

@implementation PDPatch

int osc_freq = 440;
int osc_modSteps = 1;

-(instancetype)initWithFile:(NSString *)pdFile {
    void *patch;
    self = [super init];
    
    if (self) {
        patch = [PdBase openFile:pdFile path:[[NSBundle mainBundle] resourcePath]];
        
        if (!patch) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Could not find PD patch." delegate:self cancelButtonTitle:@"Hmm ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    return self;
}

-(void)pitchUpDown:(BOOL)upDown {
//    osc_freq = upDown ? osc_freq+osc_modSteps : osc_freq-osc_modSteps;
//    [PdBase sendFloat: osc_freq toReceiver:@"freq"];
    
}

@end
