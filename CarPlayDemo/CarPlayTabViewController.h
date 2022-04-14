//
//  CarPlayTabViewController.h
//  CarPlayDemo
//
//  Created by wx on 2022/4/14.
//

#import <UIKit/UIKit.h>
#import <CarPlay/CarPlay.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarPlayTabViewController : UIViewController

@property (nonatomic, strong) CPTabBarTemplate *tabTemplate;
@property (nonatomic, strong) CPInterfaceController *interfaceController;

- (void)initTabTemplate;

@end

NS_ASSUME_NONNULL_END
