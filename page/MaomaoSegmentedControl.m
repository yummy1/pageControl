//
//  MaomaoSegmentedControl.h
//  xiuyue
//
//  Created by 毛毛 on 16/3/10.
//  Copyright © 2016年 锐拓 . All rights reserved.
//

#import "MaomaoSegmentedControl.h"


@interface MaomaoSegmentedControl ()<MaomaoSegmentedControlDelegate>

@property (nonatomic, assign)NSInteger selectSeugment;
@property (nonatomic, strong)UIView* buttonDown;
@end

@implementation MaomaoSegmentedControl

- (NSMutableArray *)ButtonArray
{
    if (!_ButtonArray) {
        _ButtonArray = [NSMutableArray array];
    }
    return _ButtonArray;
}

-(void)AddSegumentArray:(NSArray *)SegumentArray
{
 
    CGFloat x = 0;
    for (int i = 0; i < SegumentArray.count; i++) {
        NSString *buttonText = SegumentArray[i];
        CGFloat length = [buttonText length];
        CGFloat margin = 5;
        CGFloat width = length * 20;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, width, 30)];
        [button setTitle:SegumentArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:self.selectColor forState:UIControlStateSelected];
        [button setTag:i];
        
        [button addTarget:self action:@selector(changeTheSegument:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.ButtonArray addObject:button];
        
        if (i==0) {
            _buttonDown = [[UIView alloc] initWithFrame:CGRectMake(x+3, button.frame.origin.y+button.frame.size.height+1, width - 8, 3)];
            _buttonDown.backgroundColor = [UIColor redColor];
            [self addSubview:_buttonDown];
            
            [_buttonDown setBackgroundColor:[UIColor redColor]];
            [self addSubview:_buttonDown];
        }
        x = x + width + margin;
    }
    self.contentSize = CGSizeMake(x-10, 30);
    [[self.ButtonArray firstObject] setSelected:YES];
}
-(void)changeTheSegument:(UIButton*)button
{
    [self selectTheSegument:button.tag];
    [self setContentOffset:CGPointMake(button.frame.origin.x, button.frame.origin.y)];
}
-(void)selectTheSegument:(NSInteger)segument
{
    if (_selectSeugment!=segument) {
        [self.ButtonArray[_selectSeugment] setSelected:NO];
        [self.ButtonArray[segument] setSelected:YES];
        UIButton *selectedBtn = self.ButtonArray[segument];
        NSString *buttonText = selectedBtn.titleLabel.text;
        CGFloat length = [buttonText length];
        CGFloat width = length * 20;
        [UIView animateWithDuration:0.1 animations:^{
            [_buttonDown setFrame:CGRectMake(selectedBtn.frame.origin.x+3, selectedBtn.frame.origin.y+selectedBtn.frame.size.height+1, width - 8, 3)];
        }];
        _selectSeugment=segument;
        [self.delegateSelf uisegumentSelectionChange:_selectSeugment selectedBtn:selectedBtn];
    }
    
}
/**
 34 ---默认高度,可以根据项目需求自己更改
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    _selectSeugment=0;
    self.ButtonArray=[NSMutableArray arrayWithCapacity:_ButtonArray.count];
    self.titleFont=[UIFont systemFontOfSize:14.0];
    self=[super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 34)];
    self.LFLBackGroundColor = [UIColor whiteColor];
    self.titleColor = [UIColor blackColor];
    self.selectColor=[UIColor redColor];
    //    整体背景颜色
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

@end
