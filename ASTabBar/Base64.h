//
//  Base64.h
//  ASTabBar
//
//  Created by 王绵杰 on 2016/12/1.
//  Copyright © 2016年 PSYDemo. All rights reserved.
//

#import <Foundation/Foundation.h>

//base64.h

extern size_t EstimateBas64EncodedDataSize(size_t inDataSize);
extern size_t EstimateBas64DecodedDataSize(size_t inDataSize);

extern bool Base64EncodeData(const void *inInputData, size_t inInputDataSize, char *outOutputData, size_t *ioOutputDataSize, BOOL wrapped);
extern bool Base64DecodeData(const void *inInputData, size_t inInputDataSize, void *ioOutputData, size_t *ioOutputDataSize);
