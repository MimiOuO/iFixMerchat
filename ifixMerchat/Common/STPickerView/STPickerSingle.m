//
//  STPickerSingle.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/16.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "STPickerSingle.h"

@interface STPickerSingle()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 1.选中的字符串 */
@property (nonatomic, strong, nullable)NSString *selectedTitle;

@property (nonatomic, strong) NSString *selectIndex;

@end

@implementation STPickerSingle

#pragma mark - --- init 视图初始化 ---
- (void)setupUI
{
    [super setupUI];

    _titleUnit = @"";
    _arrayData = @[].mutableCopy;
    _heightPickerComponent = 44;
    _widthPickerComponent = ksWidth;
    
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 1;
    }else if (component == 1){
        return self.arrayData.count;
    }else {
        return 1;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.heightPickerComponent;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    if (component == 0) {
        return (self.st_width-self.widthPickerComponent)/2;
    }else if (component == 1){
        return self.widthPickerComponent;
    }else {
        return (self.st_width-self.widthPickerComponent)/2;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedTitle = self.arrayData[row];
    self.selectIndex = [NSString stringWithFormat:@"%ld",(long)row + 1];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    //设置分割线的颜色
    [pickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.frame.size.height <=1) {
            obj.backgroundColor = self.borderButtonColor;
        }
    }];
    
    if (component == 0) {
        return nil;
    }else if (component == 1){
        UILabel *label = [[UILabel alloc]init];
        [label setText:self.arrayData[row]];
        [label setTextAlignment:NSTextAlignmentCenter];
        return label;
    }else {
        UILabel *label = [[UILabel alloc]init];
        [label setText:self.titleUnit];
        [label setTextAlignment:NSTextAlignmentLeft];
        return label;
    }
}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    if ([self.delegate respondsToSelector:@selector(pickerSingle:selectedTitle:selectIndex:)]) {
        [self.delegate pickerSingle:self selectedTitle:self.selectedTitle selectIndex:self.selectIndex];
    }
    
    [super selectedOk];
}

#pragma mark - --- private methods 私有方法 ---

#pragma mark - --- setters 属性 ---

- (void)setArrayData:(NSMutableArray<NSString *> *)arrayData
{
    _arrayData = arrayData;
    _selectedTitle = arrayData.firstObject;
    _selectIndex = @"1";
    [self.pickerView reloadAllComponents];
}

- (void)setTitleUnit:(NSString *)titleUnit
{
    _titleUnit = titleUnit;
    [self.pickerView reloadAllComponents];
}

#pragma mark - --- getters 属性 ---
@end

