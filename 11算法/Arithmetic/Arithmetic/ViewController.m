//
//  ViewController.m
//  Arithmetic
//
//  Created by MisterBooo on 2018/5/5.
//  Copyright © 2018年 MisterBooo. All rights reserved.
//

#import "ViewController.h"
#import "CharReverse.h"
#import "ReverseList.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)CharReverse:(id)sender {
    NSString *string = self.label.text;
    NSInteger length = string.length;
    char ch[100];
    memcpy(ch, [string cStringUsingEncoding:NSASCIIStringEncoding], 2 * length);
    char_reverse(ch);
    NSLog(@"CharReverse result:%s",ch);
    self.label.text = [NSString stringWithCString:ch encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
}
- (IBAction)ReverseList:(id)sender {
    struct Node *head = constructList();
    printList(head);
    printf("**************ReverseList**************\n");
    struct Node *newhead = reverseList(head);
    printList(newhead);
}



@end
