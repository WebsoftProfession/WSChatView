//
//  WSChatView.h
//  WSChatView
//
//  Created by WebsoftProfession on 1/3/18.
//  Copyright © 2018 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSChatBubbleView.h"
#import "WSChatMessage.h"
#import "WSChatEnvironment.h"

@protocol WSChatViewDelegate<NSObject>


-(NSArray *)numberOfChats;
-(NSString *)headerTextForChat:(WSChatMessage *)message;
-(NSString *)footerTextForChat:(WSChatMessage *)message;
-(ArrowDirectionStyle)messageArrowStyleForChat:(WSChatMessage *)message;
-(void)didTapOnMessage:(WSChatMessage *)message;
-(void)didSendMessage:(NSString *)message withSendButton:(UIButton *)btnSend;
-(void)didTapAddButton:(UIButton *)btnSend;
@end

@interface WSChatView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    WSChatBubbleView *bubbleView;
    NSArray *messageArray;
    NSMutableArray *headerArray;
}
@property (nonatomic,strong) IBOutlet id<WSChatViewDelegate> chatDelegate;
@property (nonatomic,strong) NSString *sentStatusImage;
@property (nonatomic,strong) NSString *deliveredStatusImage;
@property (nonatomic,strong) NSString *seenStatusImage;
@property (nonatomic,strong) UIColor *senderBackgroundColor;
@property (nonatomic,strong) UIColor *receiverBackgroundColor;
@property (nonatomic,strong) UIColor *senderTextColor;
@property (nonatomic,strong) UIColor *receiverTextColor;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIColor *senderHeaderColor;
@property (nonatomic,strong) UIColor *receiverHeaderColor;
@property (nonatomic,strong) UIColor *senderFooterColor;
@property (nonatomic,strong) UIColor *receiverFooterColor;
@property (nonatomic,strong) WSChatEnvironment *chatEnvironment;
@property (nonatomic,assign) BOOL isDrawStatus;
-(void)loadChat;
-(void)showMostRecentMessage;

@end
