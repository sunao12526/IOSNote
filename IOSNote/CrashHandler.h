//
//  CrashHandler.h
//  iostest
//
//  Created by PF on 2024/12/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CrashHandler : NSObject
{
    BOOL ignore;
}

+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
