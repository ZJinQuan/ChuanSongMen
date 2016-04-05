//
//  NSString+Extension.m
//  
//
//


#import "NSString+Extension.h"
#import <UIKit/UIKit.h>

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

/*生成UUID*/
+ (NSString*) getUUIDString {
    
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    
    NSString *uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    uuidString = [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return uuidString;
    
}


+(id)objectIsStringWithDict:(NSDictionary *)dict forKey:(NSString *)key {
    id str = [dict objectForKey:key];
    if (str == nil || [str isKindOfClass:[NSNull class]]) {
        str = @"";
    }
    return str;
}

/**
 *  获取当前国家Code
 *
 *  @return CountryCode
 */
+ (NSString *)getCountryCode {
    return [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
}

@end
