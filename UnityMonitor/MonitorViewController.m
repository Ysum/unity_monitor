//
//  ViewController.m
//  UnityMonitor
//
//  Created by Lukas Musy on 11/04/16.
//  Copyright (c) 2016 Lukas Musy. All rights reserved.
//

#import <AudioToolbox/AudioServices.h>
#import <objc/runtime.h>
#import "MonitorViewController.h"
#import "OscHandler.h"



@interface MonitorViewController ()


@end

@implementation MonitorViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.patch = [[PDPatch alloc] initWithFile:@"main.pd"];
    self.oschandler = [[OscHandler alloc]initWithOwner:self];
    
    // init blank monitor data
    _monitorData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        NSMutableArray *watcher = [NSMutableArray arrayWithObjects:@"", @"", nil];
        [_monitorData addObject:watcher];
    }
    
}

- (void)loadView
{
    _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView reloadData];
    
    _tableView.contentInset = UIEdgeInsetsMake(50.0f, 0.0f, 0.0f, 0.0f);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.allowsSelection = NO;
    self.view = _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_monitorData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Unity Profiler Watchers";
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *watcher = @"Watcher";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:watcher];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:watcher];
    }
    
    NSMutableArray *data = [_monitorData objectAtIndex:indexPath.row];
    cell.textLabel.text =  [data objectAtIndex:0];
    cell.detailTextLabel.text = [data objectAtIndex:1];
    
    return cell;
}

- (void)displayParam: (NSString *)parameter withValue: (NSString *)value inSlot:(int)slot{
    NSMutableArray *entry = [[NSMutableArray alloc] init];
    [entry addObjectsFromArray:@[parameter, value]];
    [_monitorData replaceObjectAtIndex:slot-1 withObject:entry];
    [_tableView reloadData];
}

- (void)soundEnable:(BOOL)b {
    float t = (float) b;
    [PdBase sendFloat:t toReceiver:@"enable"];
}

- (void)soundFreq:(float)f {
    [PdBase sendFloat:f toReceiver:@"freq"];
}

- (void)soundInterval:(int)i {
    [PdBase sendFloat:i toReceiver:@"interval"];
}

- (void)vibrate {
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
