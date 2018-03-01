//
//  WSChatEnvironment.m
//  WSChatView
//
//  Created by Praveen on 27/02/18.
//  Copyright © 2018 ds. All rights reserved.
//

#import "WSChatEnvironment.h"
#import "WSChatView.h"

@implementation WSChatEnvironment

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (previousRect.size.width==0) {
        previousRect = CGRectMake(10, 10, 0, 0);
    }
}


#pragma mark UITextViewDelegate Methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    if ([textView.text isEqualToString:@"Type Message"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    return true;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Type Message";
        textView.textColor = [UIColor lightGrayColor];
    }
    return true;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self keyboardDidHide:activeNotification];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return true;
}

- (void)textViewDidChange:(UITextView *)textView{
    UITextPosition* pos = textView.endOfDocument;//explore others like beginningOfDocument if you want to customize the behaviour
    CGRect currentRect = [textView caretRectForPosition:pos];
    
    if (currentRect.origin.y > previousRect.origin.y){
        //new line reached, write your code
        NSLog(@"new line reached");
        lineCount++;
        if (lineCount<5 && lineCount>0) {
            textContainerHeightConstraint.constant += 12;
        }
    }
    else{
        if (previousRect.origin.y != 10 && currentRect.origin.y<previousRect.origin.y) {
            NSLog(@"back pressed");
            if (lineCount>0 && lineCount<5) {
                textContainerHeightConstraint.constant -= 12;
            }
            lineCount--;
        }
    }
    previousRect = currentRect;
}

- (void)keyboardDidShow: (NSNotification *) notif{
    // Do something here
    activeNotification = notif;
    WSChatView *chatView = (WSChatView *)self.superview;
    CGSize keyboardSize = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    if (chatView.superview.frame.size.height==[UIScreen mainScreen].bounds.size.height) {
        [UIView animateWithDuration:0.01 animations:^{
            chatView.superview.frame = CGRectMake(chatView.superview.frame.origin.x, chatView.superview.frame.origin.y, chatView.superview.frame.size.width, chatView.superview.frame.size.height-keyboardSize.height);
        } completion:^(BOOL finished) {
            [chatView loadChat];
        }];
    }
}

- (void)keyboardDidHide: (NSNotification *) notif{
    // Do something here
    WSChatView *chatView = (WSChatView *)self.superview;
    CGSize keyboardSize = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    if (chatView.superview.frame.size.height!=[UIScreen mainScreen].bounds.size.height) {
        chatView.superview.frame = CGRectMake(chatView.superview.frame.origin.x, chatView.superview.frame.origin.y, chatView.superview.frame.size.width, chatView.superview.frame.size.height+keyboardSize.height);
    }
}


- (IBAction)btnAddAction:(id)sender {
    WSChatView *chatView = (WSChatView *)self.superview;
    if ([chatView.chatDelegate respondsToSelector:@selector(didTapAddButton:)]) {
        [chatView.chatDelegate didTapAddButton:sender];
    }
}

- (IBAction)btnSendAction:(id)sender {
    WSChatView *chatView = (WSChatView *)self.superview;
    if ([chatView.chatDelegate respondsToSelector:@selector(didSendMessage:withSendButton:)]) {
        NSString *message = self.WSChatTextView.text;
        if ([self.WSChatTextView.text isEqualToString:@"Type Message"]) {
            message = @"";
        }
        else{
            self.WSChatTextView.text = @"";
            textContainerHeightConstraint.constant = 60;
            lineCount = 0;
            previousRect = CGRectMake(10, 10, 0, 0);
        }
        [chatView.chatDelegate didSendMessage:message withSendButton:sender];
    }
}

@end
