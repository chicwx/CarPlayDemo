//
//  CarPlayTabViewController.m
//  CarPlayDemo
//
//  Created by wx on 2022/4/14.
//

#import "CarPlayTabViewController.h"

@interface CarPlayTabViewController ()

@end

@implementation CarPlayTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initTabTemplate {
//    CPListItem *listItem = [[CPListItem alloc] initWithText:@"首页-1" detailText:@"首页-1-副标题"];
//    CPListItem *listItem2 = [[CPListItem alloc] initWithText:@"首页-2" detailText:@"首页-2-副标题"];
//
//    CPListSection *sections = [[CPListSection alloc] initWithItems:@[listItem,listItem2]];
//
//    CPListItem *listItem3 = [[CPListItem alloc] initWithText:@"推荐-1" detailText:@"推荐-1-副标题"];
//    CPListItem *listItem4 = [[CPListItem alloc] initWithText:@"推荐-2" detailText:@"推荐-2-副标题"];
//
//    CPListSection *sections2 = [[CPListSection alloc] initWithItems:@[listItem3,listItem4]];
//
//    CPListTemplate *listTemplate = [[CPListTemplate alloc] initWithTitle:@"首页" sections:@[sections]];
//    listTemplate.tabTitle = @"首页";
//
//    CPListTemplate *listTemplate2 = [[CPListTemplate alloc] initWithTitle:@"推荐" sections:@[sections2]];
//    listTemplate.tabTitle = @"推荐";

    
    NSMutableArray *tabList = [NSMutableArray new];

    for (int i = 0; i < 4; i++) {
        
        NSMutableArray *list = [NSMutableArray new];
        
        for (int j = 0; j < 10; j++) {
            NSString *title = [NSString stringWithFormat:@"%@页-第%@个",@(i),@(j)];
            NSString *subTitle = [NSString stringWithFormat:@"%@页-第%@个 副标题",@(i),@(j)];

            CPListItem *listItem = [[CPListItem alloc] initWithText:title detailText:subTitle];
            
            [list addObject:listItem];
            
            listItem.handler = ^(CPListItem *item,id obj) {
//                NSLog(@"click item %@",item);
                [self clickItem:item];
            };
        }
        
        CPListSection *sections = [[CPListSection alloc] initWithItems:list];

        CPListTemplate *listTemplate = [[CPListTemplate alloc] initWithTitle:@"首页" sections:@[sections]];
        listTemplate.tabTitle = [NSString stringWithFormat:@"%@页",@(i)];
        listTemplate.tabImage = [UIImage imageNamed:@"vojscarplay_like"];
        
        [tabList addObject:listTemplate];
    }
    
    self.tabTemplate = [[CPTabBarTemplate alloc] initWithTemplates:tabList];
    
}

- (void)clickItem:(CPListItem *)item {
    CPNowPlayingTemplate *nowTemplate = [CPNowPlayingTemplate sharedTemplate];
    [self.interfaceController pushTemplate:nowTemplate animated:YES completion:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"pushTemplate %@",error.localizedFailureReason);
    }];
}

@end
