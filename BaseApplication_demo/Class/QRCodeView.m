//
//  QRCodeView.m
//  BaseApplication_demo
//
//  Created by FeZo on 17/1/5.
//  Copyright © 2017年 FezoLsp. All rights reserved.
//

#import "QRCodeView.h"

@interface QRCodeView ()

@property (strong, nonatomic) UILabel   *contentLabel;
@property (strong, nonatomic) UIImageView   *qrLine;
@property (nonatomic) CGFloat  qrLine_y;

@end
@implementation QRCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        //将取景框对准二维码\n即可自动扫描
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.contentLabel.textColor = [UIColor whiteColor];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.text = @"将取景框对准二维码\n即可自动扫描";
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.contentLabel];
        //移动的线
        
        self.qrLine  = [[UIImageView alloc] initWithFrame:CGRectZero];
        UIImage*qrImage = [UIImage imageNamed:@"qr_scan_line"];
        
        qrImage = [qrImage resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch];
        self.qrLine.image = qrImage;
        self.qrLine.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.qrLine];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentLabel.frame = CGRectMake(0, 320, self.frame.size.width, 50);
    self.qrLine.frame = CGRectMake(self.frame.size.width / 2 - self.transparentArea.width / 2-20, 60, self.transparentArea.width+40, 2);
    [self startDownAnimation];

    
}


- (void)startUpAnimation
{
    [UIView animateWithDuration:2 animations:^{
        self.qrLine.frame = CGRectMake(self.frame.size.width / 2 - self.transparentArea.width / 2-20, 60, self.transparentArea.width+40, 2);
    }completion:^(BOOL finished) {
        [self startDownAnimation];
    }];
}
- (void)startDownAnimation
{
    [UIView animateWithDuration:2 animations:^{
        self.qrLine.frame = CGRectMake(self.frame.size.width / 2 - self.transparentArea.width / 2-20, 60+self.transparentArea.height-2, self.transparentArea.width+40, 2);
    }completion:^(BOOL finished) {
        [self startUpAnimation];
    }];
}

- (void)drawRect:(CGRect)rect {
    
    //整个二维码扫描界面的颜色
    CGSize screenSize =[UIScreen mainScreen].bounds.size;
    CGRect screenDrawRect =CGRectMake(0, 0, screenSize.width,screenSize.height);
    //中间清空的矩形框
    CGRect clearDrawRect = CGRectMake(
                                      screenDrawRect.size.width / 2 - self.transparentArea.width / 2,
                                      60,
                                      self.transparentArea.width,
                                      self.transparentArea.height);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self addScreenFillRect:ctx rect:screenDrawRect];
    
    [self addCenterClearRect:ctx rect:clearDrawRect];
    
    [self addWhiteRect:ctx rect:clearDrawRect];
    
    [self addCornerLineWithContext:ctx rect:clearDrawRect];
    
    
}

- (void)addScreenFillRect:(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextSetRGBFillColor(ctx, 40 / 255.0,40 / 255.0,40 / 255.0,0.5);
    CGContextFillRect(ctx, rect);   //draw the transparent layer
}

- (void)addCenterClearRect :(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextClearRect(ctx, rect);  //clear the center rect  of the layer
}

- (void)addWhiteRect:(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextStrokeRect(ctx, rect);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextSetLineWidth(ctx, 0.8);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
}

- (void)addCornerLineWithContext:(CGContextRef)ctx rect:(CGRect)rect{
    CGFloat length = 15;
    CGFloat pLenght = 0.7;
    CGFloat move = 1;
    //画四个边角
    CGContextSetLineWidth(ctx, 5);
    CGContextSetRGBStrokeColor(ctx, 83 /255.0, 239/255.0, 111/255.0, 1);//绿色
    
    //左上角
    CGPoint poinsTopLeftA[] = {
        CGPointMake(rect.origin.x+pLenght, rect.origin.y+move),
        CGPointMake(rect.origin.x+pLenght , rect.origin.y + length)
    };
    
    CGPoint poinsTopLeftB[] = {CGPointMake(rect.origin.x+move, rect.origin.y +pLenght),CGPointMake(rect.origin.x + length, rect.origin.y+pLenght)};
    [self addLine:poinsTopLeftA pointB:poinsTopLeftB ctx:ctx];
    
    //左下角
    CGPoint poinsBottomLeftA[] = {CGPointMake(rect.origin.x+ pLenght, rect.origin.y + rect.size.height - length-move),CGPointMake(rect.origin.x + pLenght,rect.origin.y + rect.size.height-move)};
    CGPoint poinsBottomLeftB[] = {CGPointMake(rect.origin.x+move, rect.origin.y + rect.size.height - pLenght) ,CGPointMake(rect.origin.x+pLenght +length, rect.origin.y + rect.size.height - pLenght)};
    [self addLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:ctx];
    
    //右上角
    CGPoint poinsTopRightA[] = {CGPointMake(rect.origin.x+ rect.size.width - length, rect.origin.y+pLenght),CGPointMake(rect.origin.x-move + rect.size.width,rect.origin.y +pLenght )};
    CGPoint poinsTopRightB[] = {CGPointMake(rect.origin.x+ rect.size.width-pLenght, rect.origin.y+move),CGPointMake(rect.origin.x + rect.size.width-pLenght, rect.origin.y + length +pLenght )};
    [self addLine:poinsTopRightA pointB:poinsTopRightB ctx:ctx];
    
    //右下角
    CGPoint poinsBottomRightA[] = {CGPointMake(rect.origin.x+ rect.size.width -pLenght , rect.origin.y+rect.size.height -length),CGPointMake(rect.origin.x-pLenght + rect.size.width,rect.origin.y +rect.size.height-move )};
    CGPoint poinsBottomRightB[] = {CGPointMake(rect.origin.x+ rect.size.width - length , rect.origin.y + rect.size.height-pLenght),CGPointMake(rect.origin.x + rect.size.width-move,rect.origin.y + rect.size.height - pLenght )};
    [self addLine:poinsBottomRightA pointB:poinsBottomRightB ctx:ctx];
    CGContextStrokePath(ctx);
}

- (void)addLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)ctx {
    CGContextAddLines(ctx, pointA, 2);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextAddLines(ctx, pointB, 2);
}

@end
