//
//  LiquidFloatingCell.m
//  LiquidFloatingActionButtonOCVersion
//
//  Created by yurongde on 16/4/18.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "LiquidFloatingCell.h"

static CGFloat const internalRatio = 0.75;

@interface LiquidFloatingCell()
@property (nonatomic, assign) BOOL responsible;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIColor *originalColor;
@end
@implementation LiquidFloatingCell
- (instancetype)initCenter:(CGPoint)center radius:(CGFloat)radius color:(UIColor *)color icon:(UIImage *)icon {
    self = [super initCenter:center radius:radius color:color];
    
    if (!self) {
        return nil;
    }
    _responsible = YES;
    _originalColor = color;
    [self setup:icon];
    return self;
    
}
- (instancetype)initCenter:(CGPoint)center radius:(CGFloat)radius color:(UIColor *)color view:(UIView *)view {
    self = [super initCenter:center radius:radius color:color];
    
    if (!self) {
        return nil;
    }
    _responsible = YES;
    _originalColor = color;
    
    [self setupView:view];
    return self;
}
- (instancetype)initIcon:(UIImage *)icon {
    self = [super init];
    if (!self) {
        return nil;
    }
    _responsible = YES;
    _originalColor = [UIColor clearColor];
    
    [self setup:icon];
    
    return self;
    
}
- (void)setup:(UIImage *)icon {
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.imageView.image = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imageView.image = icon;
    self.imageView.tintColor = [UIColor whiteColor];
    [self setupView:self.imageView];
}
- (void)setupView:(UIView *)view {
    self.userInteractionEnabled = YES;
    [self addSubview:view];
    [self resizeSubviews];
}
- (void)resizeSubviews {
    //自己写图片的大小
//    CGSize size = CGSizeMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
//    self.imageView.frame = CGRectMake(self.frame.size.width - self.frame.size.width * internalRatio, self.frame.size.height - self.frame.size.height * internalRatio, size.width, size.height);

    CGSize size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.imageView.frame = CGRectMake(0, 0, size.width, size.height);
}
- (void)updateKey:(CGFloat)key open:(BOOL)open {
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[UIView class]]) {
            CGFloat ratio = MAX(2 * (key * key - 0.5), 0);
            subview.alpha = open ? ratio : -ratio;
        }
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.responsible) {
        self.originalColor = self.color;
        self.color = [self.originalColor yrd_whiteScale:0.5];
        [self setNeedsDisplay];
    }
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.responsible) {
        self.color = self.originalColor;
        [self setNeedsDisplay];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.color = self.originalColor;
    [self.actionButton didTappedCell:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self resizeSubviews];
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}
@end
