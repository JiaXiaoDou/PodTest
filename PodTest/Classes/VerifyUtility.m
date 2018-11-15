//
//  VerifyUtility.m
//  socianELoan
//
//  Created by 佳小豆 on 2017/11/23.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "VerifyUtility.h"

@implementation VerifyUtility

+ (BOOL)isIphoneNumber:(NSString *)str
{
    NSString *pattern = @"^1([3456789])\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

//是否为邮箱
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//是否含有特殊符号
+ (BOOL)isHaveIllegalChar:(NSString *)str
{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"\\/:*?\"<|'%>&@#"];//“‘'\"，;；#*+=\\|~$%^*?？+ ！#￥/!&<@>、
    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
    return range.location<str.length;
}

//判断是不是单位电话
+ (BOOL)isCompanyTelPhone:(NSString *)str
{
    
    NSString * fristStr = [str componentsSeparatedByString:@"-"].firstObject;
    NSString * seconStr = [str componentsSeparatedByString:@"-"].lastObject;
    
    if ([str componentsSeparatedByString:@"-"].count==2&&fristStr.length>2&&fristStr.length<5&&seconStr.length<9&&seconStr.length>6&&[self isPureInt:fristStr]&&[self isPureInt:seconStr])
    {
        //以“-”分割 去前部分做判断
        return YES;
    }
    else
    {
        return NO;
    }
}
//判断是否为纯数字
+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断只为汉字
+ (BOOL)isChinese:(NSString *)string
{
    NSString *match = @"(^[\u4e00-\u9fa5]+[·•]?[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isPassword:(NSString *)string
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

//验证银行卡
+ (BOOL)isValidCardNumber:(NSString *)cardNumber
{
    if([VerifyUtility isBlankString:cardNumber])
    {
        return NO;
    }
    //奇数求和
    int oddsum = 0;
    //偶数求和
    int evensum = 0;
    int allsum = 0;
    int cardNoLength = (int)[cardNumber length];
    int lastNum = [[cardNumber substringFromIndex:cardNoLength-1] intValue];
    cardNumber = [cardNumber substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--)
    {
        NSString *tmpString = [cardNumber substringWithRange:NSMakeRange(i-1, 1)];
        
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 == 1 )
        {
            if((i % 2) == 0)
            {
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }
            else
            {
                oddsum += tmpVal;
            }
            
        }
        else
        {
            if((i % 2) == 1)
            {
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
                
            }
            else
            {
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    
    if((allsum % 10) == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//验证是否是空字符串
+(BOOL)isBlankString:(NSString*)originalStr
{
    if([originalStr isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if([originalStr isEqual:[NSNull null]])
    {
        return YES;
    }
    if (originalStr == nil)
    {
        return YES;
    }
    if([originalStr isEqualToString:@""] || [originalStr isEqualToString:@"null"] || [originalStr isEqualToString:@"<null>"])
    {
        return YES;
    }
    if([originalStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isCorrect:(NSString *)IDNumber
{
    if (IDNumber.length < 15)
    {
        return NO;
    }
    
    if (IDNumber.length == 15)
    {
        return [self isIDCardNum:IDNumber];
    }
    
    if (IDNumber.length < 18)
    {
        return NO;
    }
    
    NSMutableArray *IDArray = [NSMutableArray array];
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i < 18; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [IDNumber substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @"2"];
    // 余数数组
    NSArray *remainderArray = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i <17; i++)
    {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
    // 身份证号码最后一位
    NSString *string = [IDNumber substringFromIndex:17];
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    return [str isEqualToString:string];
}

#pragma mark - 验证身份证号
+ (BOOL)isIDCardNum:(NSString *)string
{
    BOOL isMatch = NO;
    
    if (string==nil)
    {
        return isMatch;
    }
    
    if(string.length!=15&&string.length!=18)
    {
        return isMatch;
    }
    
    NSString *cardNo = [NSString stringWithFormat:@"%@",string];
    
    NSString *idCodeRegex = @"((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])| (5[0-4])|(6[1-5])|71|(8[12])|91)";
    NSPredicate *idCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", idCodeRegex];
    
    if (![idCodeTest evaluateWithObject:[cardNo substringToIndex:2]])
    {
        return isMatch;
    }
    
    NSArray *strJiaoYan = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5",
                           @"4", @"3", @"2", nil];
    
    NSArray *arr = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    
    if (cardNo.length == 15)
    {
        NSString *ereg = @"";
        
        if (([[cardNo substringWithRange:NSMakeRange(6, 2)]intValue]+1900)%4 == 0
            || (([[cardNo substringWithRange:NSMakeRange(6, 2)]intValue]+1900)%100 == 0
                && ([[cardNo substringWithRange:NSMakeRange(6, 2)]intValue]+1900)%4 == 0))
        {
            // 测试出生日期的合法性
            ereg = @"[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}";
        }
        else
        {
            // 测试出生日期的合法性
            ereg = @"[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}";
        }
        
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ereg];
        isMatch = [pred evaluateWithObject:cardNo];
        if (isMatch == NO)
        {
            return isMatch;
        }
        isMatch = NO;
        cardNo = [NSString stringWithFormat:@"%@19%@",[cardNo substringToIndex:6],[cardNo substringWithRange:NSMakeRange(6, 9)]];
        
        int intTemp = 0;
        
        for (int i = 0; i<17; i++)
        {
            intTemp = intTemp + ([[cardNo substringWithRange:NSMakeRange(i, 1)]intValue] * [[arr objectAtIndex:i]intValue]);
        }
        
        intTemp = intTemp % 11;
        cardNo = [NSString stringWithFormat:@"%@%@",cardNo,[strJiaoYan objectAtIndex:intTemp]];
    }
    if (cardNo.length == 18)
    {
        NSString *ereg1 = @"";
        if (([[cardNo substringWithRange:NSMakeRange(6, 4)]intValue])%4 == 0
            || (([[cardNo substringWithRange:NSMakeRange(6, 4)]intValue])%100 == 0
                && ([[cardNo substringWithRange:NSMakeRange(6, 4)]intValue])%4 == 0))
        {
            // 闰年出生日期的合法性正则表达式
            ereg1 = @"[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]";
        }
        else
        {
            // 平年出生日期的合法性正则表达式
            ereg1 = @"[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]";
        }
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ereg1];
        isMatch = [pred evaluateWithObject:cardNo];
        if (isMatch == NO)
        {
            return isMatch;
        }
        isMatch = NO;
        
        int intTemp = 0;
        
        for (int i = 0; i<17; i++)
        {
            intTemp = intTemp + ([[cardNo substringWithRange:NSMakeRange(i, 1)]intValue] * [[arr objectAtIndex:i]intValue]);
        }
        
        intTemp = intTemp % 11;
        
        NSString *last = [strJiaoYan objectAtIndex:intTemp];// 判断校验位
        
        if (!([last compare:[cardNo substringWithRange:NSMakeRange(17, 1)] options:NSCaseInsensitiveSearch] == NSOrderedSame))
        {
            return isMatch;
        }
        
    }
    isMatch = YES;
    return isMatch;
}


@end
