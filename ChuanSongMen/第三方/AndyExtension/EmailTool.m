//
//  EmailTool.m
//  BuyAi
//
//  Created by apple on 15/12/14.
//  Copyright © 2015年 femto. All rights reserved.
//

#import "EmailTool.h"

@interface EmailTool()<MFMailComposeViewControllerDelegate>

@end
@implementation EmailTool
+(instancetype)shareEmailTool
{
    static EmailTool *tool = nil;
    if (tool == nil) {
        tool = [[EmailTool alloc] init];
    }
    return tool;
}
- (void)displayMailPickerWithVC:(UIViewController *)vc
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        NSLog(@"nooo");
        return;
    }
    if (![mailClass canSendMail]) {
        NSLog(@"You need to set up email account");
        [self launchMailAppOnDevice];
        return;
    }
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"Feedback To buyAi"];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObjects: @"service@buyai.com", nil];
    [mailPicker setToRecipients: toRecipients];
    //    //添加抄送
    //    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //    [mailPicker setCcRecipients:ccRecipients];
    //    //添加密送
    //    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
    //    [mailPicker setBccRecipients:bccRecipients];
    
    //    // 添加一张图片
    //    UIImage *addPic = [UIImage imageNamed: @"Icon@2x.png"];
    //    NSData *imageData = UIImagePNGRepresentation(addPic);            // png
    //    //关于mimeType：http://www.iana.org/assignments/media-types/index.html
    //    [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"Icon.png"];
    
    //    //添加一个pdf附件
    //    NSString *file = [self fullBundlePathFromRelativePath:@"高质量C++编程指南.pdf"];
    
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //    NSString *filePath = [paths objectAtIndex:0];//stringByAppendingPathComponent:[NSString stringWithFormat:@"list3.jpg"]];   // 保存文件的名称
    
    //    UIImage *tempImage = [UIImage imageWithContentsOfFile:filePath];
    //    NSLog(@"%@", tempImage);
    
    //    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documentDir = [documentPaths objectAtIndex:0];
    //    NSError *error = nil;
    //    NSArray *fileList = [[NSArray alloc] init];
    //    fileList = [fileManager contentsOfDirectoryAtPath:documentDir error:&error];
    //    NSLog(@"%@", fileList);
    //
    //    if (!fileList.count) {
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂无表格，请先填写表格。" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
    //        [alertView show];
    //        return;
    //    }
    //
    //    for (NSString *str in fileList) {
    //        NSString *path = [documentDir stringByAppendingPathComponent:str];
    //        NSLog(@"%@", path);
    //
    //        NSData *pdf = [NSData dataWithContentsOfFile:path];
    //        [mailPicker addAttachmentData: pdf mimeType: @"" fileName: str];
    //    }
    //    [self presentModalViewController: mailPicker animated:YES];
    [vc presentViewController:mailPicker animated:YES completion:^{
        
    }];
}
-(void)launchMailAppOnDevice
{
    //    NSString *recipients = @"mailto:first@example.com&subject=my email!";
    //    NSString *body = @"&body=email body!";
    NSString *email = [NSString stringWithFormat:@"service@buyai.com"];
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
   
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
        {
            msg = @"用户点击发送，将邮件放到队列中，还没发送";
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentDir = [documentPaths objectAtIndex:0];
            
            [fileManager removeItemAtPath:documentDir error:nil];
        }
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
    
    //关闭邮件发送窗口
    //    [self dismissModalViewControllerAnimated:YES];
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
