//
//  NSString+Extension.h
//  
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/*获取需要设置的size*/
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
/*生成UUID*/
+ (NSString*) getUUIDString;
/**
 *  检查返回值是否为空
 *
 *  @param dict 返回的字典
 *  @param key  key
 *
 *  @return value
 */
+(id)objectIsStringWithDict:(NSDictionary *)dict forKey:(NSString *)key;


/**
 *  获取当前国家Code
 *
 *  @return CountryCode
 */
+ (NSString *)getCountryCode;
@end
