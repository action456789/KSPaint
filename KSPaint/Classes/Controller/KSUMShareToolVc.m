//
//  KSUMShareToolVc.m
//  KSPaint
//
//  Created by KeSen on 15/9/23.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import "KSUMShareToolVc.h"
#import "UMSocial.h"
#import "KSPaint.h"
#import "MBProgressHUD+KS.h"

@interface KSUMShareToolVc () <UMSocialDataDelegate, UMSocialUIDelegate>

@end


@implementation KSUMShareToolVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)shareImage:(UIImage *)image text:(NSString *)text target:(id)target {
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    NSArray *snsNames = [NSArray arrayWithObjects:UMShareToSina, UMShareToWechatTimeline, UMShareToQzone, UMShareToQQ, nil];
    
    [UMSocialSnsService presentSnsIconSheetView:target
                                         appKey:@"5601fdf967e58e5731001bbd"
                                      shareText:text
                                     shareImage:image
                                shareToSnsNames:snsNames
                                       delegate:self];
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    
    // 根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess) {
        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);

        [MBProgressHUD showSuccess:@"分享成功"];
    }else {
        [MBProgressHUD showError:@"分享失败"];
    }
}

- (void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response {
    
    NSLog(@"didFinishGetUMSocialDataResponse");
}

@end

