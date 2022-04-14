//
//  CarPlaySceneDelegate.m
//  CarPlayDemo
//
//  Created by wx on 2022/4/13.
//

#import "CarPlaySceneDelegate.h"
#import "CarPlayTabViewController.h"

@interface CarPlaySceneDelegate() <CPTemplateApplicationSceneDelegate>

@end


@implementation CarPlaySceneDelegate


- (void)templateApplicationScene:(CPTemplateApplicationScene *)templateApplicationScene didDisconnectInterfaceController:(CPInterfaceController *)interfaceController {
    NSLog(@"didDisconnectInterfaceController");

}

- (void)templateApplicationScene:(CPTemplateApplicationScene *)templateApplicationScene didConnectInterfaceController:(CPInterfaceController *)interfaceController {
    NSLog(@"didConnectInterfaceController");
    
    self.interfaceController = interfaceController;
    
    CarPlayTabViewController *tabBoard = [CarPlayTabViewController new];
    [tabBoard initTabTemplate];
    
//    window.rootViewController = tabBoard;
    
    [self.interfaceController setRootTemplate:tabBoard.tabTemplate animated:YES];
    
    tabBoard.interfaceController = interfaceController;
    
    //设置正在播放页面模板
//    CPNowPlayingTemplate *nowTemplate = [CPNowPlayingTemplate sharedTemplate];
//
//    CPNowPlayingPlaybackRateButton *playButton = [[CPNowPlayingPlaybackRateButton alloc] initWithHandler:^(__kindof CPNowPlayingButton * _Nonnull button) {
//        NSLog(@"playButton");
//    }];
//
//    CPNowPlayingRepeatButton *repeatButton = [[CPNowPlayingRepeatButton alloc] initWithHandler:^(__kindof CPNowPlayingButton * _Nonnull button) {
//        NSLog(@"repeatButton");
//    }];
//
//    [nowTemplate updateNowPlayingButtons:@[playButton,repeatButton]];
}

// CarPlay connected
- (void)templateApplicationScene:(CPTemplateApplicationScene *)templateApplicationScene didConnectInterfaceController:(CPInterfaceController *)interfaceController toWindow:(CPWindow *)window {


}

// CarPlay disconnected
- (void)templateApplicationScene:(CPTemplateApplicationScene *)templateApplicationScene didDisconnectInterfaceController:(CPInterfaceController *)interfaceController fromWindow:(CPWindow *)window {
}

@end
