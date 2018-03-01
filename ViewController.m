//
//  ViewController.m
//  WSChatView
//
//  Created by Praveen on 01/03/18.
//  Copyright © 2018 WebsoftProfession. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *chatArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -10;
    NSDate *previousDate = [theCalendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    
    
    WSChatMessage *message1 = [[WSChatMessage alloc] initWithSenderId:@"1" senderDisplayName:@"UserA" date:previousDate text:@"Hello" mediaImage:nil];
    WSChatMessage *message2 = [[WSChatMessage alloc] initWithSenderId:@"2" senderDisplayName:@"UserB" date:previousDate text:@"Hello" mediaImage:nil];
    WSChatMessage *message3 = [[WSChatMessage alloc] initWithSenderId:@"1" senderDisplayName:@"UserA" date:previousDate text:@"How are you?" mediaImage:nil];
    WSChatMessage *message4 = [[WSChatMessage alloc] initWithSenderId:@"2" senderDisplayName:@"UserB" date:previousDate text:@"I am fine and you?" mediaImage:nil];
    WSChatMessage *message5 = [[WSChatMessage alloc] initWithSenderId:@"1" senderDisplayName:@"UserA" date:previousDate text:@"also fine" mediaImage:nil];
    WSChatMessage *message6 = [[WSChatMessage alloc] initWithSenderId:@"1" senderDisplayName:@"UserA" date:[NSDate date] text:@"Please check this image" mediaImage:[UIImage imageNamed:@"sample.jpg"]];
    WSChatMessage *message7 = [[WSChatMessage alloc] initWithSenderId:@"2" senderDisplayName:@"UserB" date:[NSDate date] text:@"Ok" mediaImage:nil];
    chatArray = [[NSMutableArray alloc] initWithObjects:message1,message2,message3,message4,message5,message6,message7, nil];
    
    // Sender Properties
    chatView.senderBackgroundColor = [UIColor colorWithRed:1.0f/255 green:125.0f/255 blue:236.0f/255 alpha:1.0];
    chatView.senderTextColor = [UIColor whiteColor];
    chatView.senderHeaderColor = [UIColor whiteColor];
    chatView.senderFooterColor = [UIColor whiteColor];
    
    // Receiever Properties
    chatView.receiverBackgroundColor = [UIColor colorWithRed:238.0f/255 green:238.0f/255 blue:238.0f/255 alpha:1.0];
    chatView.receiverTextColor = [UIColor blackColor];
    chatView.receiverHeaderColor = [UIColor blackColor];
    chatView.receiverFooterColor = [UIColor blackColor];
    chatView.font = [UIFont fontWithName:@"Arial" size:12];
    //    chatView.isDrawStatus = true;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark WSChatViewDelegate methods
- (NSArray *)numberOfChats{
    return chatArray;
}

- (ArrowDirectionStyle)messageArrowStyleForChat:(WSChatMessage *)message{
    if ([message.senderId isEqualToString:@"1"]) {
        return ArrowDirectionLeftTop;
    }
    return ArrowDirectionRightTop;
}

- (NSString *)headerTextForChat:(WSChatMessage *)message{
//    return message.senderName;
    return @"";
}

- (NSString *)footerTextForChat:(WSChatMessage *)message{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH:mm a"];
    return [format stringFromDate:message.messageDate];
}

- (void)didTapAddButton:(UIButton *)btnSend{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select a picture" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take a picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Choose a picture" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }]];
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)didSendMessage:(NSString *)message withSendButton:(UIButton *)btnSend{
    if (message.length>0) {
        WSChatMessage *chatMessage = [[WSChatMessage alloc] initWithSenderId:@"2" senderDisplayName:@"" date:[NSDate date] text:message mediaImage:nil];
        [chatArray addObject:chatMessage];
        [chatView loadChat];
    }
}

- (void)didTapOnMessage:(WSChatMessage *)message{
    
}

@end
