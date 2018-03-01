//
//  WSChatLabel.h
//  WSChatLabel
//
//  Created by WebsoftProfession on 12/28/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSChatLabel : UIView
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,strong) UIColor *backColor;
@property (assign) int arrowDirectionStyle;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIImage *image;
@property (assign) int textHeight;
@property (nonatomic,strong) NSString *headerText;
@property (nonatomic,strong) NSString *footerText;
@property (assign) BOOL isSender;
@property (assign) BOOL isSent;
@property (assign) BOOL isDelivered;
@property (assign) BOOL isSeen;
@property (nonatomic,strong) NSString *sentStatusImage;
@property (nonatomic,strong) NSString *deliveredStatusImage;
@property (nonatomic,strong) NSString *seenStatusImage;
-(void)drawMessage:(NSString *)message;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *headerColor;
@property (nonatomic,strong) UIColor *footerColor;
@property (nonatomic,assign) BOOL isDrawStatus;

@end
