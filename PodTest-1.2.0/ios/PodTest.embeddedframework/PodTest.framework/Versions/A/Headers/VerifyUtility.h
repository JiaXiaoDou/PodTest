//
//  VerifyUtility.h
//  socianELoan
//
//  Created by 佳小豆 on 2017/11/23.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerifyUtility : NSObject

+ (BOOL)isIphoneNumber:(NSString *)str;

+ (BOOL)isPassword:(NSString *)string;

+ (BOOL)isValidateEmail:(NSString *)email;

+ (BOOL)isHaveIllegalChar:(NSString *)str;

+ (BOOL)isCompanyTelPhone:(NSString *)str;

+ (BOOL)isPureInt:(NSString*)string;

+ (BOOL)isChinese:(NSString *)string;

//+ (BOOL)isValidCardNumber:(NSString *)cardNumber;

//验证是否是空字符串
+ (BOOL)isBlankString:(NSString*)originalStr;

//验证身份证号
+ (BOOL)isCorrect:(NSString *)IDNumber;

@end
