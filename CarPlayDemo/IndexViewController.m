//
//  IndexViewController.m
//  CarPlayDemo
//
//  Created by wx on 2022/4/14.
//

#import "IndexViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>

@interface IndexViewController ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    [self addNotification];
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 100)];
    label.text = @"这是测试标题";
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    
    UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
    [playButton setTitle:@"play" forState:UIControlStateNormal];
    [playButton setTitle:@"pause" forState:UIControlStateSelected];
    playButton.backgroundColor = [UIColor grayColor];
    [playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [playButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [playButton addTarget:self action:@selector(clickPlayButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    
}

#pragma mark - Control
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRemoteControl:) name:@"remoteControlReceivedWithEvent" object:nil];
}

- (void)handleRemoteControl:(NSNotification *)notification {
    NSLog(@"notification");
        
    UIEventType type = [(NSNumber *)notification.object integerValue];

    switch (type) {
        case UIEventSubtypeRemoteControlPlay:
            [self play];
            break;
        case UIEventSubtypeRemoteControlPause:
            [self pause];
            break;
        default:
            break;
    }
}

#pragma mark - Event
- (void)clickPlayButton:(UIButton *)button {
    button.selected = !button.selected;
    
    if (button.selected) {
        [self play];
    }
    else {
        [self pause];
    }
}

- (void)play {
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

//通过MPNowPlayingInfoCenter与carplay交互音频播放
- (void)prepareMPNowPlayingInfoCenter {
    MPNowPlayingInfoCenter *center = [MPNowPlayingInfoCenter defaultCenter];
    
    NSMutableDictionary *info = [NSMutableDictionary new];
    [info setObject:@"爱在西元前" forKey:MPMediaItemPropertyTitle];
    [info setObject:@"JAY" forKey:MPMediaItemPropertyArtist];
    [info setObject:@(300) forKey:MPMediaItemPropertyPlaybackDuration];
    
    center.nowPlayingInfo = info;
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

#pragma mark - Lazy
- (AVPlayer *)player {
    if (!_player) {
        _player = [AVPlayer playerWithURL:[NSURL URLWithString:@"https://ipa.cm.jstv.com/azxyq.mp3"]];
        
        [self prepareMPNowPlayingInfoCenter];
    }
    return _player;
}

@end
