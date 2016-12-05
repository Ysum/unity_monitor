//
//  PDPatch.h
//  UnityMonitor
//
//  Created by Lukas Musy on 16/05/16.
//  Copyright © 2016 Lukas Musy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PdDispatcher.h"
#import <UIKit/UIKit.h>

@interface PDPatch : NSObject

- (instancetype)initWithFile:(NSString *)pdFile;

@end
