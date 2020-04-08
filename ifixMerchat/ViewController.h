//
//  ViewController.h
//  AMapPlaceChooseDemo
//
//  Created by PC on 15/9/28.
//  Copyright © 2015年 FENGSHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  AMapDelegate<NSObject>
- (void)pickAdressWithAdress:(NSString *)adress City:(NSString *)city lat:(CGFloat)lat lon:(CGFloat)lon;
@end
@interface ViewController : UIViewController
@property(nonatomic, weak)id <AMapDelegate>delegate;

@end

