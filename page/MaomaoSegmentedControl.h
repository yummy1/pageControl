//
//  MaomaoSegmentedControl.h
//  xiuyue
//
//  Created by 毛毛 on 16/3/10.
//  Copyright © 2016年 锐拓 . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MaomaoSegmentedControlDelegate< NSObject>

@optional
/**
 外界调用获取点击下标
 */
-(void)uisegumentSelectionChange:(NSInteger)selection selectedBtn:(UIButton *)button;
@end
@interface MaomaoSegmentedControl : UIScrollView
@property (nonatomic, weak)id<MaomaoSegmentedControlDelegate>delegateSelf;
@property(nonatomic,strong)NSMutableArray *ButtonArray;/**< 对应的标题文字 */
@property(strong,nonatomic)UIColor *LFLBackGroundColor;/**< BackGround颜色 */
@property(strong,nonatomic)UIColor *titleColor;/**< 标题文字颜色 */
@property(strong,nonatomic)UIColor *selectColor;/**< 选中按钮的颜色 */
@property(strong,nonatomic)UIFont *titleFont;/**< 字体大小 */

-(void)AddSegumentArray:(NSArray *)SegumentArray;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)selectTheSegument:(NSInteger)segument;

@end
