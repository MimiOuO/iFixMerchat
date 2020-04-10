//
//  ViewController.h
//  AMapPlaceChooseDemo
//
//  Created by PC on 15/9/28.
//  Copyright © 2015年 FENGSHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  AMapDelegate<NSObject>
- (void)pickAdressWithAdress:(NSString *)adress Province:(NSString *)province City:(NSString *)city District:(NSString *)district lat:(CGFloat)lat lon:(CGFloat)lon;
@end
@interface MamapVC : UIViewController
@property(nonatomic, weak)id <AMapDelegate>delegate;

@end

