//
//  WSChatView.m
//  WSChatView
//
//  Created by WebsoftProfession on 1/3/18.
//  Copyright © 2018 WebsoftProfession. All rights reserved.
//

#import "WSChatView.h"
#import "WSChatTableViewCell.h"

@implementation WSChatView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (!self.chatEnvironment) {
        self.chatEnvironment = [[[NSBundle mainBundle] loadNibNamed:@"WSChatEnvironment" owner:self options:nil] lastObject];
        self.chatEnvironment.frame = self.bounds;
        [self addSubview:self.chatEnvironment];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)];
        [self.chatEnvironment.list addGestureRecognizer:tap];
    }
    
    [self.chatEnvironment.list registerNib:[UINib nibWithNibName:@"WSChatTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"messageCell"];
    self.chatEnvironment.list.delegate = self;
    self.chatEnvironment.list.dataSource = self;
    [self setupInitialProperties];
    [self.chatEnvironment.list reloadData];
}

-(void)loadChat{
    [self.chatEnvironment.list reloadData];
    [self showMostRecentMessage];
}

-(void)showMostRecentMessage{
    if (headerArray.count>0) {
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:[self getMessageForSection:headerArray.count-1].count-1 inSection:headerArray.count-1];
        [self.chatEnvironment.list scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionNone animated:true];
    }
}

-(void)setupInitialProperties{
    
    if (!self.senderBackgroundColor) {
        self.senderBackgroundColor = [UIColor colorWithRed:215.0f/255 green:255.0f/255 blue:160.0f/255 alpha:1.0];
    }
    
    if (!self.receiverBackgroundColor) {
        self.receiverBackgroundColor = [UIColor whiteColor];
    }
    
    if (!self.senderTextColor) {
        self.senderTextColor = [UIColor blackColor];
    }
    
    if (!self.receiverTextColor) {
        self.receiverTextColor = [UIColor blackColor];
    }
    
    if (!self.senderHeaderColor) {
        self.senderHeaderColor = [UIColor blackColor];
    }
    
    if (!self.senderFooterColor) {
        self.senderFooterColor = [UIColor blueColor];
    }
    
    if (!self.receiverHeaderColor) {
        self.receiverHeaderColor = [UIColor blackColor];
    }
    
    if (!self.receiverFooterColor) {
        self.receiverFooterColor = [UIColor blueColor];
    }
    
    if (!self.font) {
        self.font = [UIFont fontWithName:@"Arial" size:14];
    }
}

-(NSString *)getHeaderDateStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFM = [[NSDateFormatter alloc] init];
    [dateFM setDateFormat:@"MMM dd, YYYY"];
    return [dateFM stringFromDate:date];
}

-(NSArray *)getMessageForSection:(NSInteger)section{
    NSArray *chatArray = [self.chatDelegate numberOfChats];
    WSChatMessage *message = [headerArray objectAtIndex:section];
    NSDate *startDate = [self beginningOfDay:message.messageDate];
    NSDate *endDate = [self endOfDay:message.messageDate];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(self.messageDate >= %@) AND (self.messageDate <= %@)", startDate, endDate];
    return [chatArray filteredArrayUsingPredicate:predicate];
}

-(NSDate *)beginningOfDay:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay) fromDate:date];
    
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [cal dateFromComponents:components];
}

-(NSDate *)endOfDay:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay ) fromDate:date];
    
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    
    return [cal dateFromComponents:components];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    headerArray = [[NSMutableArray alloc] init];
    if ([self.chatDelegate respondsToSelector:@selector(numberOfChats)]) {
        NSArray *chatArray = [self.chatDelegate numberOfChats];
        NSMutableArray *tempArray = [[self.chatDelegate numberOfChats] mutableCopy];
        for (WSChatMessage *message in chatArray) {
            
            NSDate *startDate = [self beginningOfDay:message.messageDate];
            NSDate *endDate = [self endOfDay:message.messageDate];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(self.messageDate >= %@) AND (self.messageDate <= %@)", startDate, endDate];
            
//            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.messageDate == %@", message.messageDate];
            messageArray = [tempArray filteredArrayUsingPredicate:predicate];
            if (messageArray.count>0) {
                [headerArray addObject:message];
//                [NSPredicate predicateWithFormat:@"!(self.messageDate < %@) AND !(self.messageDate > %@)", startDate, endDate]
//                [NSPredicate predicateWithFormat:@"self.messageDate != %@", message.messageDate]
                [tempArray removeObjectsInArray:messageArray];
            }
        }
    }
    return headerArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (headerArray.count>0) {
        WSChatMessage *message = [headerArray objectAtIndex:section];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
        headerView.backgroundColor = [UIColor clearColor];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake((headerView.frame.size.width/2)-headerView.frame.size.width/8, 10, headerView.frame.size.width/4, 20)];
        lblTitle.clipsToBounds = true;
        lblTitle.layer.masksToBounds = true;
        lblTitle.layer.cornerRadius = 5;
        lblTitle.layer.shadowColor = [UIColor blackColor].CGColor;
        lblTitle.layer.shadowOpacity = 0.5;
        lblTitle.textAlignment = NSTextAlignmentCenter;
        lblTitle.text = [self getHeaderDateStringFromDate:message.messageDate];
        lblTitle.font = self.font;
        lblTitle.backgroundColor = self.receiverBackgroundColor;
        lblTitle.textColor = self.receiverTextColor;
        [headerView addSubview:lblTitle];
        return headerView;
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self getMessageForSection:section].count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // provide the actual width of your WSChatBubbleView
    
    WSChatMessage *message = [[self getMessageForSection:indexPath.section] objectAtIndex:indexPath.row];
    
    UIImage *img = message.mediaImage;
    CGFloat imgHeight = 0;
    if (img) {
        imgHeight = 200;
    }
    return imgHeight + [self heightForMessage:message.message containerWidth:tableView.frame.size.width withImage:img];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = (WSChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    WSChatBubbleView *bubbleView = [cell viewWithTag:100];
    bubbleView.backgroundColor = [UIColor clearColor];

    bubbleView.senderBackgroundColor = self.senderBackgroundColor;
    bubbleView.receiverBackgroundColor = self.receiverBackgroundColor;
    bubbleView.senderTextColor = self.senderTextColor;
    bubbleView.senderTextColor = self.senderTextColor;
    bubbleView.font = self.font;
    bubbleView.senderHeaderColor = self.senderHeaderColor;
    bubbleView.senderFooterColor = self.senderFooterColor;
    bubbleView.receiverHeaderColor = self.receiverHeaderColor;
    bubbleView.receiverFooterColor = self.receiverFooterColor;
    
    bubbleView.font = [UIFont fontWithName:@"Arial" size:14];
    
    bubbleView.sentStatusImage = self.sentStatusImage;
    bubbleView.deliveredStatusImage = self.deliveredStatusImage;
    bubbleView.seenStatusImage = self.seenStatusImage;
    bubbleView.isDrawStatus = self.isDrawStatus;
    
    WSChatMessage *message = [[self getMessageForSection:indexPath.section] objectAtIndex:indexPath.row];
    bubbleView.message = message.message;
    bubbleView.image = message.mediaImage;
    bubbleView.arrowDirectionStyle = [self.chatDelegate messageArrowStyleForChat:message];
    
    bubbleView.headerText = [self.chatDelegate headerTextForChat:message];
    bubbleView.footerText = [self.chatDelegate footerTextForChat:message];

//    bubbleView.message = [self.chatDelegate messageForChatAt:indexPath.row];
//    bubbleView.image = [self.chatDelegate imageForChatAt:indexPath.row];
//    bubbleView.arrowDirectionStyle = [self.chatDelegate messageArrowStyleAt:indexPath.row];
//
//    bubbleView.headerText = [self.chatDelegate headerTextForChatAt:indexPath.row];
//    bubbleView.footerText = [self.chatDelegate footerTextForChatAt:indexPath.row];
    
    tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg.jpg"]];
    [bubbleView setNeedsDisplay];
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    WSChatBubbleView *bubble = [cell viewWithTag:100];
//
//    if ([self.chatDelegate respondsToSelector:@selector(didTapOnMessageWithIndex:)]) {
//        bubble.WSChatLabel.isTapImage = false;
//        [self.chatDelegate didTapOnMessageWithIndex:indexPath.row];
//    }
//}

-(void) didTapOnTableView:(UIGestureRecognizer*) recognizer {
    CGPoint tapLocation = [recognizer locationInView:self.chatEnvironment.list];
    NSIndexPath *indexPath = [self.chatEnvironment.list indexPathForRowAtPoint:tapLocation];
    [self endEditing:true];
    if (indexPath) { //we are in a tableview cell, let the gesture be handled by the view
        recognizer.cancelsTouchesInView = NO;
        UITableViewCell *cell = [self.chatEnvironment.list cellForRowAtIndexPath:indexPath];
        WSChatBubbleView *bubble = [cell viewWithTag:100];
        
        tapLocation = [self.chatEnvironment.list convertPoint:tapLocation toView:bubble.WSChatLabel];
        if (bubble.image && !CGRectContainsPoint(CGRectMake(20, bubble.WSChatLabel.frame.origin.y, bubble.WSChatLabel.frame.size.width, bubble.WSChatLabel.frame.size.height), tapLocation)) {
            return;
        }
        if ([self.chatDelegate respondsToSelector:@selector(didTapOnMessage:)]) {
            [self.chatDelegate didTapOnMessage:[[self getMessageForSection:indexPath.section] objectAtIndex:indexPath.row]];
        }
        
    } else { // anywhere else, do what is needed for your case
        NSLog(@"no index path");
    }
}

-(CGFloat)heightForMessage:(NSString *)msg containerWidth:(CGFloat)width withImage:(UIImage *)image{
    
    if (!self.font) {
        self.font = [UIFont fontWithName:@"Arial" size:14];
    }
    
    CGFloat textContainerWidth = width-width*0.30;
    if (image) {
        textContainerWidth = 220;
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: self.font};
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    CGRect textRect = [msg boundingRectWithSize:CGSizeMake(textContainerWidth, CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes
                                        context:nil];
    
    CGFloat minimumHeight = 50.0;
    minimumHeight = minimumHeight + textRect.size.height;
    return minimumHeight;
}



@end
