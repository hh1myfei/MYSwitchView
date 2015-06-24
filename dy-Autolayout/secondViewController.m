//
//  secondViewController.m
//  dy-Autolayout
//
//  Created by jzb_iOS on 15/6/15.
//  Copyright (c) 2015年 jzb_iOS. All rights reserved.
//

#import "secondViewController.h"
#import "userObject.h"
#import "RootViewController.h"
#import <ZXingObjC/ZXingObjC.h>

@interface secondViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong,nonatomic)UIImagePickerController * imagePickerController;
@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    userObject * userinfo  = [userObject shareInstance];
    [userinfo setObject:@"44" forKey:@"4"];
    [userinfo setObject:@"21" forKey:@"2"];
    self.textField.secureTextEntry = YES;
    [userinfo setObject:@"11" forKey:@"1"];
    NSMutableDictionary * dic = [userinfo.userDictionary mutableCopy];
    [dic setObject:@"55" forKey:@"5"];
    
    [self getInfoWithImage:[UIImage imageNamed:@"jianzhi.png"]];
    [self jique:@"http://a.jianzhibao.com/jobs?jobId=106&activityUrl=http://www.jianzhibao.com&activityId=102"];
    [self jiequstinrg:@"http://a.jianzhibao.com?userid=3&ddd&cc[-&&&aa=aa&jobID=pp&kk=ll&dd=dd"];
    // Do any additional setup after loading the view.
}

-(void)jiequstinrg:(NSString * )string{
    NSString * tmpString = string;
    NSRange  range;
    while (![tmpString hasPrefix:@"jobID"]) {
        range = [tmpString rangeOfString:@"&"];
        if (range.length == 0) {
            break;
        }
        tmpString = [tmpString substringFromIndex:NSMaxRange(range)];
        NSLog(@"...tmpstring  %@",tmpString);
    }
    if (range.length != 0) {
        NSRange  range1 = [tmpString rangeOfString:@"="];
        tmpString = [tmpString substringFromIndex:NSMaxRange(range1)];
        NSRange  range2 = [tmpString rangeOfString:@"&"];
        tmpString = [tmpString substringToIndex:NSMaxRange(range2)-1];
    }
    NSLog(@"...tmpstring  %@",tmpString);
}
-(void)jique:(NSString *)string{
    NSURL          * jobURL         = [NSURL URLWithString:string];
    NSString       * jobQuery       = [jobURL query];
    NSArray        * queryArray     = [jobQuery componentsSeparatedByString:@"&"];
    NSMutableDictionary * parmerDic = [NSMutableDictionary dictionary];
    for (NSString * urlParmer in queryArray) {
        NSArray      * parmerArray = [urlParmer componentsSeparatedByString:@"="];
        [parmerDic setObject:parmerArray[1] forKey:parmerArray[0]];
    }
    NSLog(@"jobqueary array %@",parmerDic);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)action:(id)sender {
    self.textField.secureTextEntry = !self.textField.secureTextEntry;
}

- (IBAction)scanerButtonClick:(UIButton *)sender {
    RootViewController * rt = [[RootViewController alloc]init];
    //[self.navigationController pushViewController:rt animated:YES];
    [self LocalPhoto];
}

-(void)getInfoWithImage:(UIImage *)img{
    UIImage *loadImage= img;
    CGImageRef imageToDecode = loadImage.CGImage;
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    ZXBinaryBitmap *bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError *error = nil;
    
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXMultiFormatReader *reader = [ZXMultiFormatReader reader];
    ZXResult *result = [reader decode:bitmap
                                hints:hints
                                error:&error];
    if (result) {
        NSLog(@"解析成功");
        NSString *contents = result.text;
        NSLog(@"相册图片contents == %@",contents);
    } else {
        NSLog(@"解析失败");
    }
}

//打开本地相册
-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"....%@",info);
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * editImage = (UIImage *)[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self.image setImage:editImage];
    NSLog(@"");
    [self getInfoWithImage:editImage];
    
}
@end
































