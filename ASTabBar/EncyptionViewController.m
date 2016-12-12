//
//  EncyptionViewController.m
//  ASTabBar
//
//  Created by 王绵杰 on 2016/12/1.
//  Copyright © 2016年 PSYDemo. All rights reserved.
//

#import "EncyptionViewController.h"
#import "EncryptionHelper.h"
@interface EncyptionViewController ()
{
    EncryptionHelper *encryptionHelper;
}
@property (weak, nonatomic) IBOutlet UILabel *md5Label;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UILabel *aesEncyLabel;
@property (weak, nonatomic) IBOutlet UILabel *aesUnencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *shaEncyLabel;
@end

@implementation EncyptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    encryptionHelper = [[EncryptionHelper alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)md5EncytionAction:(UIButton *)sender {
    NSString *inputString = self.inputTextField.text;
    NSString *md5Result = [encryptionHelper md5HexDigest:inputString];
    self.md5Label.text = md5Result;
}

- (IBAction)aesEncytionAction:(UIButton *)sender {
    NSString *inputString = self.inputTextField.text;
    NSString *aesEncyResult = [encryptionHelper aes256_encrypt:inputString];
    self.aesEncyLabel.text = aesEncyResult;
}

- (IBAction)aesUnencytionAction:(UIButton *)sender {
    NSString *inputString = self.aesEncyLabel.text;
    NSString *aesDeencyResult = [encryptionHelper aes256_decrypt:inputString];
    self.aesUnencyLabel.text = aesDeencyResult;
}
- (IBAction)shaEncyAction:(UIButton *)sender {
    NSString *inputString = self.inputTextField.text;
    NSString *shaEncyResult = [encryptionHelper sha256HexDigest:inputString];
    self.shaEncyLabel.text = shaEncyResult;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
