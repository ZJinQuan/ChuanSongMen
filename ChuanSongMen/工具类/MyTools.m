//
//  MyTools.m
//  ERenovate
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 Peter. All rights reserved.
//

#import "MyTools.h"

@implementation MyTools

//当前时间戳减去已有的时间戳,传入已有时间就行了
+ (NSString *)getHayMenosTiempoTimestampSelloActual:(NSString *)timeStr
{
//    //获取系统当前的时间戳
//    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval a=[dat timeIntervalSince1970];
//    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    //获取系统的时间
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    date = [formatter stringFromDate:datenow];
    
    //时间转时间戳的方法: //现在是现在时间
    NSString * timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    //这是计算获得到的时间的时间戳
    NSString * str = timeStr;
    NSDate * doworkDate = [formatter dateFromString:str];
    NSString * timeSps = [NSString stringWithFormat:@"%ld", (long)[doworkDate timeIntervalSince1970]];
    NSInteger years = [timeSp floatValue] - [timeSps floatValue];
    NSLog(@"%zd", years);
    NSString * downDate;
    if (years <= 60) {
        
        /*"LSsecond" = "秒前";
         "LSminute" = "分钟前";
         "LShour" = "小时前";
         "LSyesterday" = "昨天";
         "LSbeforeYesterday" = "前天";
         "LSTwodaysago" = "两天前";
         "LSThreedaysago" = "三天前";*/
        downDate = [NSString stringWithFormat:@"%zd秒前",years];
    } else if (years > 60 && years <= 3600) {
        downDate = [NSString stringWithFormat:@"%zd分钟前", years/60];
    } else if (years > 3600 && years <= 86400) {
        downDate = [NSString stringWithFormat:@"%zd小时前", years/3600];
    } else if (years > 86400 && years <= 172800) {
        downDate = [NSString stringWithFormat:@"昨天"];
    }else if (years > 172800 && years <= 259200) {
        downDate = [NSString stringWithFormat:@"前天"];
    }else if(259200 < years && years <= 345600 ){
        downDate = [NSString stringWithFormat:@"两天前"];
    }else{
        downDate = [NSString stringWithFormat:@"三天前"];
    }
    return downDate;
}


+(NSString *)getCurrentTime{
    
    NSDate *nowUTC = [NSDate dateWithTimeIntervalSinceNow:0];;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *str = [dateFormatter stringFromDate:nowUTC];
    
    NSDate *date = [dateFormatter dateFromString:str];
    NSString *dateStr = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]*1000];
    return dateStr;
    
}

/**
 *  时间戳转date,根据时间来显示：刚刚，今天，昨天，日期
 *
 *  @param timestamp 时间戳的字符串
 *
 *  @return 格式化后的时间字符串
 */
+ (NSString *)timestampChangeDate:(NSString *)timestamp {
    // 设置日期格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    
    NSDate *newDate = [dateFormatter dateFromString:timestamp];
    
    
//    // 把时间戳转换成日期
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]/1000];
    // 把日期根据上面的日期格式转成日期字符串
    //    NSString *confromTimespStr = [dateFormatter stringFromDate:confromTimesp];
    NSString *timeStr = [MyTools formateDate:newDate withFormate:@"HH:mm:ss dd-MM-YYYY"];
    return timeStr;
}

/**
 *  时间转换显示，
 *
 *  @param date       时间
 *  @param formate    时间格式
 *
 *  @return 转换后对应显示的时间
 */
+ (NSString *)formateDate:(NSDate *)date withFormate:(NSString *) formate {
    
    @try {
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        [dateFormatter setDateFormat:formate];
        
        NSDate * nowDate = [NSDate date];
        
        /////  将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = date;
        /////  取当前时间和转换时间两个日期对象的时间间隔
        /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        
        //// 再然后，把间隔的秒数折算成天数和小时数：
        
        NSString *dateStr = @"";
        
        if (time <= 60) {  //// 1分钟以内的
            dateStr = [NSString stringWithFormat:@"%dz秒前", (int)time/1];
        }else if(time <= 60 * 60){  ////  一个小时以内的
            
            int mins = time / 60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
            
        }else if(time <= 60 * 60 * 24){   //// 在两天内的
            
            [dateFormatter setDateFormat:@"YYYY/MM/dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:needFormatDate]];
            }else{
                ////  昨天
                dateStr = [NSString stringWithFormat:@"昨天%@", [dateFormatter stringFromDate:needFormatDate]];
            }
            
//            int cha = time / 3600;
//            dateStr = [NSString stringWithFormat:@"%d小时前",cha];
            
        }else {
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                ////  在同一年
                [dateFormatter setDateFormat:@"MM.dd "];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"MM/dd, yyyy"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        
        return dateStr;
    }
    @catch (NSException *exception) {
        return @"";
    }
}

@end
