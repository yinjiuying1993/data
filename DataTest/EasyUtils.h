//
//  EasyUtils.h
//  EasyBlueTooth
//
//  Created by nf on 2016/8/14.
//  Copyright © 2016年 chenSir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EasyUtils : NSObject

/**
 将NSData转为16进制的字符串
 */
+ (NSString *)convertDataToHexStr:(NSData *)data;
/**
 十六进制转换为普通字符串的
 */
+ (NSString *)convertHexStringToString:(NSString *)hexString;

/**
 普通字符串转换为十六进制
 */
+ (NSString *)convertStringToHexString:(NSString *)string;

 /**
  将16进制的字符串转换成NSData
  */
+ (NSMutableData *)convertHexStrToData:(NSString *)str ;


//int转data
+(NSData *)convertIntToData:(int)i;

//data转int
+(int)convertDataToInt:(NSData *)data;

//将 int 转 16进制字符串
+(NSString *)toHex:(long long int)tmpid;



@end
