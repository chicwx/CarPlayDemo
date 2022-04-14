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
#import <CarPlay/CarPlay.h>

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
    
    UIButton *changeButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 50)];
    [changeButton setTitle:@"更换标题" forState:UIControlStateNormal];
    changeButton.backgroundColor = [UIColor grayColor];
    [changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(changeButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeButton];
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

- (void)changeButton {
    [self updateCenterInfo];
}

- (void)play {
    [self.player play];
    
//    [MPNowPlayingInfoCenter defaultCenter].playbackState = MPNowPlayingPlaybackStatePlaying;
}

- (void)pause {
    [self.player pause];
//    [MPNowPlayingInfoCenter defaultCenter].playbackState = MPNowPlayingPlaybackStatePaused;
}

- (void)updateCenterInfo {
    NSMutableDictionary *nowPlayingInfo = [[MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo mutableCopy];
    
    [nowPlayingInfo setValue:@"换一个标题" forKey:MPMediaItemPropertyTitle];
    
    UIImage *image = [UIImage imageNamed:@"fantastic"];
    
    MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithBoundsSize:image.size requestHandler:^UIImage * _Nonnull(CGSize size) {
        return image;
    }];
    
    [nowPlayingInfo setObject:artwork forKey:MPMediaItemPropertyArtwork];
    

    
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nowPlayingInfo;
    
    CPNowPlayingImageButton *imageButton = [[CPNowPlayingImageButton alloc] initWithImage:image handler:^(__kindof CPNowPlayingButton * _Nonnull button) {
        NSLog(@"click CPNowPlayingImageButton");
    }];
    
    
    CPNowPlayingTemplate *nowTemplate = [CPNowPlayingTemplate sharedTemplate];
    [nowTemplate updateNowPlayingButtons:@[imageButton]];
    
}

//通过MPNowPlayingInfoCenter与carplay交互音频播放
- (void)prepareMPNowPlayingInfoCenter {
    
    NSMutableDictionary *nowPlayingInfo = [NSMutableDictionary new];
    [nowPlayingInfo setObject:@"爱在西元前" forKey:MPMediaItemPropertyTitle];
    [nowPlayingInfo setObject:@"JAY" forKey:MPMediaItemPropertyArtist];
    [nowPlayingInfo setObject:@(300) forKey:MPMediaItemPropertyPlaybackDuration];
        
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nowPlayingInfo;

    

    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

#pragma mark - Lazy
- (AVPlayer *)player {
    if (!_player) {
        //[NSURL URLWithString:@"https://ipa.cm.jstv.com/azxyq.mp3"]
        NSString *path = [[NSBundle mainBundle] pathForResource:@"azxyq" ofType:@"mp3"];
        _player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:path]];
        [self prepareMPNowPlayingInfoCenter];

    }
    return _player;
}

@end
