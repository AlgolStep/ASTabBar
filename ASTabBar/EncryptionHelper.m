//
//  EncryptionHelper.m
//  ASTabBar
//
//  Created by 王绵杰 on 2016/12/1.
//  Copyright © 2016年 PSYDemo. All rights reserved.
//

#import "EncryptionHelper.h"
//常用加解密算法
#include <CommonCrypto/CommonCryptor.h>
//摘要算法
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#include <CommonCrypto/CommonKeyDerivation.h>
#include <CommonCrypto/CommonSymmetricKeywrap.h>
#include "Base64.h"
@implementation EncryptionHelper
{
    NSUInteger length;
}

/*
 要熟练掌握AES算法的使用，必须要了解其几种工作模式、初始化向量、填充模式等概念，通常情况还需要多平台保持一致的加解密结果，使用时务必多做确认。（可以使用在线网站加解密进行自我验证。）
 
 　　kCCKeySizeAES256
 　　密钥长度，枚举类型，还有128，192两种。
 
 　　kCCBlockSizeAES128
 　　块长度，固定值 16（字节，128位），由AES算法内部加密细节决定，不过哪种方式、模式，均为此。
 
 　　kCCAlgorithmAES
 　　算法名称，不区分是128、192还是258。kCCAlgorithmAES128只是历史原因，与kCCAlgorithmAES值相同。
 
 　　kCCOptionPKCS7Padding
 　　填充模式，AES算法内部加密细节决定AES的明文必须为64位的整数倍，如果位数不足，则需要补齐。kCCOptionPKCS7Padding表示，缺几位就补几个几。比如缺少3位，则在明文后补3个3。iOS种只有这一种补齐方式，其它平台方式更多，如kCCOptionPKCS5Padding，kCCOptionZeroPadding。如果要实现一致性，则此处其它平台也要使用kCCOptionPKCS7Padding。
 
 　　kCCOptionECBMode
 　　工作模式，电子密码本模式。此模式不需要初始化向量。iOS种只有两种方式，默认是CBC模式，即块加密模式。标准的AES除此外还有其它如CTR,CFB等方式。kCCOptionECBMode模式下多平台的要求不高，推荐使用。CBC模式，要求提供相同的初始化向量，多个平台都要保持一致，工作量加大，安全性更高，适合更高要求的场景使用。
 
 　　base64
 　　一种unicode到asci码的映射，由于明文和密文标准加密前后都可能是汉字或者特殊字符，故为了直观的显示，通常会对明文和密文进行base64编码
*/

/**
 *  对称密码算法－－AES
 *
 *  @param  key 加密对象
 */

-(NSString *)aes256_encrypt:(NSString *)key{
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:length];
    
    //对数据进行加密
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
    {
        NSData *result = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        //base64
        return [result base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }else
    {
        return nil;
    }
    
}

/**
 *  AES 解密过程
 *
 *  @param  key 解密对象
 */

-(NSString *)aes256_decrypt:(NSString *)key
{
    NSData *data = [[NSData alloc] initWithBase64EncodedData:[key dataUsingEncoding:NSASCIIStringEncoding]
                                                     options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    //对数据进行解密
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess)
    {
        NSData* result = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        
    }else
    {
        return nil;
    }
    
}

#pragma mark - 摘要算法
//摘要算法，具有单向不可逆的基本性质，速度快。
/**
 *  消息摘要算法MD5 加密
 *
 *  @param  key 加密对象
 */

- (NSString *)md5HexDigest:(NSString *)key
{
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cstr, (unsigned int)strlen(cstr), result);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", result[i]];
    
    return output;
    
}

#pragma mark -  安全散列算法SHA
//SHA按结果的位数分为256、484、512三种基本方式，根据对结果的要求而选择即可。通过CC_SHA256_DIGEST_LENGTH等枚举类型进行设置。
- (NSString *)sha256HexDigest:(NSString *)key
{
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

#pragma mark - HMAC_SHA1加密

+ (NSString *)hmacsha1:(NSString *)text key:(NSString *)secret {
    NSData *secretData = [secret dataUsingEncoding:NSUTF8StringEncoding];
    NSData *clearTextData = [text dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[20];
    CCHmac(kCCHmacAlgSHA1, [secretData bytes],
           [secretData length], [clearTextData bytes], [clearTextData length], result);
    char base64Result[32];
    size_t theResultLength = 32;
    Base64EncodeData(result, 20, base64Result, &theResultLength,YES);
    NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
    NSString *base64EncodedResult = [[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding];
    return base64EncodedResult;
}
@end
