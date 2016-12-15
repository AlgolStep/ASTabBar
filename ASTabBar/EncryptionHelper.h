//
//  EncryptionHelper.h
//  ASTabBar
//
//  Created by 王绵杰 on 2016/12/1.
//  Copyright © 2016年 PSYDemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptionHelper : NSObject
//md5
- (NSString *)md5HexDigest:(NSString *)key;
//AES
-(NSString *)aes256_encrypt:(NSString *)key;
-(NSString *)aes256_decrypt:(NSString *)key;


//SHA
- (NSString *)sha256HexDigest:(NSString *)key;

#pragma mark - HMAC_SHA1加密
- (NSString *)hmacsha1:(NSString *)text key:(NSString *)secret;
@end
