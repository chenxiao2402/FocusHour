//
//  ZCircleSlider.m
//  LoadingView
//
//  Created by ZhangBob on 24/05/2017.
//  Copyright © 2017 JixinZhang. All rights reserved.
//

import UIKit

class CircleSlider: UIView {
    private let TWO_PI: CGFloat = CGFloat(2 * Double.pi)
    private let circleBorderWidth: CGFloat = 5.0
    private let thumbRadius: CGFloat = 12.0
    private let thumbExpandRadius: CGFloat = 25.0
    private let sliderBackgroundColor: UIColor = UIColor.lightGray
    private let sliderProgressColor: UIColor = UIColor.blue

    var radius: CGFloat = 0.0           //半径

    var alphaAngle: CGFloat = 0.0            // 移动点相对于起始点顺时针扫过的角度(弧度)
    var drawCenter: CGPoint!       //绘制圆的圆心
    var startPoint: CGPoint! //thumb起始位置
    var currentPoint: CGPoint!        //滑块的实时位置
    var loadProgress: CGFloat = 0.0
    
    var lockClockwise: Bool = false       //禁止顺时针转动
    var lockAntiClockwise: Bool = false   //禁止逆时针转动
    var interaction: Bool = true
    
    var thumbView: UIImageView!
    
    deinit {
        self.removeObserver(self, forKeyPath: "angle")
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    
    func setup() {
        print("Set up running")
        self.backgroundColor = UIColor(red: 255.0/255, green: 255.0/255, blue: 224.0/255, alpha: 1.0)
        self.drawCenter = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
        self.radius = 120.0
        self.loadProgress = 0.75
        self.alphaAngle = loadProgress * TWO_PI

        thumbView = UIImageView()
        thumbView.frame = CGRect(x: 0, y: 0, width: self.thumbRadius, height: self.thumbRadius)
        thumbView.image = UIImage(named: "thumbSilder")
        thumbView.layer.masksToBounds = true
        thumbView.isUserInteractionEnabled = false;

        self.addObserver(self, forKeyPath: "angle", context: nil)
    }
    
//    #pragma mark - getter
//
//    - (UIImageView *)thumbView {
//    if (!_thumbView) {
//    _thumbView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
//    _thumbView.image = [UIImage imageNamed:@"thumbSlider"];
//    _thumbView.layer.masksToBounds = YES;
//    _thumbView.userInteractionEnabled = NO;
//
//    }
//    return _thumbView;
//    }
    
//    #pragma mark - setter
//
//    - (void)setValue:(float)value {
//    if (value < 0.25) {
//    self.lockClockwise = NO;
//    } else {
//    self.lockAntiClockwise = NO;
//    }
//    _value = MIN(MAX(value, 0.0), 0.997648);
//    [self setNeedsDisplay];
//    }
//
//    - (void)setLoadProgress:(float)loadProgress {
//    _loadProgress = loadProgress;
//    [self setNeedsDisplay];
//    }
//
//    - (void)setCanRepeat:(BOOL)canRepeat {
//    _canRepeat = canRepeat;
//    [self setNeedsDisplay];
//    }
//
//    - (void)setThumbRadius:(CGFloat)thumbRadius {
//    _thumbRadius = thumbRadius;
//    self.thumbView.frame = CGRectMake(0, 0, thumbRadius * 2, thumbRadius * 2);
//    self.thumbView.layer.cornerRadius = thumbRadius;
//
//    [self setNeedsDisplay];
//    }
//
//    - (void)setThumbExpandRadius:(CGFloat)thumbExpandRadius {
//    _thumbExpandRadius = thumbExpandRadius;
//    [self setNeedsDisplay];
//    }
//
//    - (void)setCircleRadius:(CGFloat)circleRadius {
//    _circleRadius = circleRadius;
//    self.circleStartPoint = CGPointMake(self.drawCenter.x, self.drawCenter.y - self.circleRadius);
//    [self setNeedsDisplay];
//    }
//
//    - (void)setCircleBorderWidth:(CGFloat)circleBorderWidth {
//    _circleBorderWidth = circleBorderWidth;
//    [self setNeedsDisplay];
//    }
//
//    - (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
//    _minimumTrackTintColor = minimumTrackTintColor;
//    [self setNeedsDisplay];
//    }
//
//    - (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
//    _maximumTrackTintColor = maximumTrackTintColor;
//    [self setNeedsDisplay];
//    }
//
//    - (void)setThumbTintColor:(UIColor *)thumbTintColor {
//    _thumbTintColor = thumbTintColor;
//    self.thumbView.backgroundColor = thumbTintColor;
//    [self setNeedsDisplay];
//    }
    
    // pragma mark - drwRect
    
    override func draw(_ rect: CGRect) {
        print("drawRect")
//        self.circleStartPoint = CGPoint(x: self.drawCenter.x, y: self.drawCenter.y - self.circleRadius)
    
        let ctx = UIGraphicsGetCurrentContext();

        // 设置背景，画一个空的圆环
        ctx?.setFillColor(UIColor.clear.cgColor)
        ctx?.setShouldAntialias(true)
        ctx?.setStrokeColor(self.sliderBackgroundColor.cgColor)
        ctx?.setLineWidth(self.circleBorderWidth)
        ctx?.addArc(center: self.drawCenter, radius: self.radius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: false)
        ctx?.drawPath(using: CGPathDrawingMode.fillStroke)
    

        // 根据进度条的数值画相应的slider长度
        let circlePath: UIBezierPath = UIBezierPath()
        let startAngle: CGFloat = CGFloat(-Double.pi / 2)
        let currentAngle: CGFloat = startAngle + CGFloat(2 * Double.pi) * loadProgress;
        circlePath.addArc(withCenter: self.drawCenter, radius: self.radius, startAngle: startAngle, endAngle: currentAngle, clockwise: true)
        ctx?.saveGState()
        ctx?.setShouldAntialias(true)
        ctx?.setLineWidth(self.circleBorderWidth)
        ctx?.setStrokeColor(self.sliderProgressColor.cgColor);
        ctx?.addPath(circlePath.cgPath);
        ctx?.drawPath(using: CGPathDrawingMode.fillStroke)
        ctx?.restoreGState()
        
        /*
         * 计算移动点的位置
         * alphaAngle = 移动点相对于起始点顺时针扫过的角度(弧度)
         * x = r * sin(alpha) + 圆心的x坐标, sin在0-PI之间为正，PI-2*PI之间为负
         * y = r * cos(alpha) + 圆心的y坐标
         */
        let x: CGFloat = self.drawCenter.x + self.radius * CGFloat(sin(self.alphaAngle))
        let y: CGFloat = self.drawCenter.y - self.radius * CGFloat(cos(self.alphaAngle))
        self.currentPoint = CGPoint(x: x, y: y)
        self.thumbView.center = self.currentPoint
        self.addSubview(thumbView)
    }
    
//    #pragma mark - UIControl methods
//
//    //点击开始
//    - (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
//    [super beginTrackingWithTouch:touch withEvent:event];
//    CGPoint starTouchPoint = [touch locationInView:self];
//
//    //如果点击点和上一次点击点的距离大于44，不做操作。
//    double touchDist = [ZCircleSlider distanceBetweenPointA:starTouchPoint pointB:self.lastPoint];
//    if (touchDist > 44) {
//    self.interaction = NO;
//    [self sendActionsForControlEvents:UIControlEventValueChanged];
//    return YES;
//    }
//    //如果点击点和圆心的距离大于44，不做操作。
//    //以上两步是用来限定滑块的点击范围，距离滑块太远不操作，距离圆心太远或太近不操作
//    double dist = [ZCircleSlider distanceBetweenPointA:starTouchPoint pointB:self.drawCenter];
//    if (fabs(dist - self.radius) > 44) {
//    self.interaction = NO;
//    [self sendActionsForControlEvents:UIControlEventValueChanged];
//    return YES;
//    }
//    self.thumbView.center = self.lastPoint;
//    //点击后滑块放大及动画
//    CGFloat expandRate = self.thumbExpandRadius / self.thumbRadius;
//    __weak typeof (self)weakSelf = self;
//    [UIView animateWithDuration:0.15
//    animations:^{
//    weakSelf.thumbView.transform = CGAffineTransformMakeScale(1.0f * expandRate, 1.0f * expandRate);
//    }];
//    [self moveHandlerWithPoint:starTouchPoint];
//    [self sendActionsForControlEvents:UIControlEventValueChanged];
//    return YES;
//    }
//
//    //拖动过程中
//    - (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
//    [super continueTrackingWithTouch:touch withEvent:event];
//    CGPoint starTouchPoint = [touch locationInView:self];
//
//    double touchDist = [ZCircleSlider distanceBetweenPointA:starTouchPoint pointB:self.lastPoint];
//    if (touchDist > 44) {
//    [self sendActionsForControlEvents:UIControlEventValueChanged];
//    return YES;
//    }
//    double dist = [ZCircleSlider distanceBetweenPointA:starTouchPoint pointB:self.drawCenter];
//    if (fabs(dist - self.radius) > 44) {
//    [self sendActionsForControlEvents:UIControlEventValueChanged];
//    return YES;
//    }
//    [self moveHandlerWithPoint:starTouchPoint];
//    [self sendActionsForControlEvents:UIControlEventValueChanged];
//    return YES;
//    }
//
//    //拖动结束
//    - (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
//    [super endTrackingWithTouch:touch withEvent:event];
//    self.thumbView.center = self.lastPoint;
//    __weak typeof (self)weakSelf = self;
//    [UIView animateWithDuration:0.15
//    animations:^{
//    weakSelf.thumbView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
//    }];
//
//    CGPoint starTouchPoint = [touch locationInView:self];
//
//    double touchDist = [ZCircleSlider distanceBetweenPointA:starTouchPoint pointB:self.lastPoint];
//    if (touchDist > 44) {
//    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
//    return;
//    }
//    double dist = [ZCircleSlider distanceBetweenPointA:starTouchPoint pointB:self.drawCenter];
//    if (fabs(dist - self.radius) > 44) {
//    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
//    return;
//    }
//    [self moveHandlerWithPoint:starTouchPoint];
//    [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
//    }
//
//    #pragma mark - Handle move
//
//    - (void)moveHandlerWithPoint:(CGPoint)point {
//    self.interaction = YES;
//    CGFloat centerX = self.drawCenter.x;
//    CGFloat centerY = self.drawCenter.y;
//
//    CGFloat moveX = point.x;
//    CGFloat moveY = point.y;
//
//    if (!self.canRepeat) {
//    //到300度，禁止移动到第一，二，三象限
//    if (self.lockClockwise) {
//    if ((moveX >= centerX && moveY <= centerY) ||
//    (moveX >= centerX && moveY >= centerY) ||
//    (moveX <= centerX && moveY >= centerY)) {
//    return;
//    }
//    }
//
//    //小于60度的时候，禁止移动到第二，三，四象限
//    if (self.lockAntiClockwise) {
//    if ((moveX <= centerX && moveY >= centerY) ||
//    (moveX <= centerX && moveY <= centerY) ||
//    (moveX >= centerX && moveY >= centerY)) {
//    return;
//    }
//    }
//    }
//
//    double dist = sqrt(pow((moveX - centerY), 2) + pow(moveY - centerY, 2));
//    if (fabs(dist - self.radius) > 44) {
//    return;
//    }
//    /*
//     * 计算移动点的坐标
//     * sinAlpha = 亮点在x轴上投影的长度 ／ 距离
//     * xT = r * sin(alpha) + 圆心的x坐标
//     * yT 算法同上
//     */
//    double sinAlpha = (moveX - centerX) / dist;
//    double xT = self.radius * sinAlpha + centerX;
//    double yT = sqrt((self.radius * self.radius - (xT - centerX) * (xT - centerX))) + centerY;
//    if (moveY < centerY) {
//    yT = centerY - fabs(yT - centerY);
//    }
//    self.lastPoint = self.thumbView.center = CGPointMake(xT, yT);
//
//    CGFloat angle = [ZCircleSlider calculateAngleWithRadius:self.radius
//    center:self.drawCenter
//    startCenter:self.circleStartPoint
//    endCenter:self.lastPoint];
//    if (angle >= 300) {
//    //当当前角度大于等于300度时禁止移动到第一、二、三象限
//    self.lockClockwise = YES;
//    } else {
//    self.lockClockwise = NO;
//    }
//
//    if (angle <= 60.0) {
//    //当当前角度小于等于60度时，禁止移动到第二、三、四象限
//    self.lockAntiClockwise = YES;
//    } else {
//    self.lockAntiClockwise = NO;
//    }
//    self.angle = angle;
//    self.value = angle / 360;
//    }
//
//    #pragma mark - Util
//
//    /**
//     计算圆上两点间的角度
//
//     @param radius 半径
//     @param center 圆心
//     @param startCenter 起始点坐标
//     @param endCenter 结束点坐标
//     @return 圆上两点间的角度
//     */
//    + (CGFloat)calculateAngleWithRadius:(CGFloat)radius
//    center:(CGPoint)center
//    startCenter:(CGPoint)startCenter
//    endCenter:(CGPoint)endCenter {
//    //a^2 = b^2 + c^2 - 2bccosA;
//    CGFloat cosA = (2 * radius * radius - powf([ZCircleSlider distanceBetweenPointA:startCenter pointB:endCenter], 2)) / (2 * radius * radius);
//    CGFloat angle = 180 / M_PI * acosf(cosA);
//    if (startCenter.x > endCenter.x) {
//    angle = 360 - angle;
//    }
//    return angle;
//    }
//
//    /**
//     两点间的距离
//
//     @param pointA 点A的坐标
//     @param pointB 点B的坐标
//     @return 两点间的距离
//     */
//    + (double)distanceBetweenPointA:(CGPoint)pointA pointB:(CGPoint)pointB {
//    double x = fabs(pointA.x - pointB.x);
//    double y = fabs(pointA.y - pointB.y);
//    return hypot(x, y);//hypot(x, y)函数为计算三角形的斜边长度
//    }
//
//    #pragma mark - KVO
//
//    //对angle添加KVO，有时候手势过快在continueTrackingWithTouch方法中不能及时限定转动，所以需要通过KVO对angle做实时监控
//    - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    ZCircleSlider *circleSlider = (ZCircleSlider *)object;
//    NSNumber *newAngle = [change valueForKey:@"new"];
//    if ([keyPath isEqualToString:@"angle"]) {
//    if (newAngle.doubleValue >= 300 ||
//    circleSlider.angle >= 300) {
//    self.lockClockwise = YES;
//    } else {
//    self.lockClockwise = NO;
//    }
//
//    if (newAngle.doubleValue <= 60 ||
//    circleSlider.angle <= 60) {
//    self.lockAntiClockwise = YES;
//    } else {
//    self.lockAntiClockwise = NO;
//    }
//    }
//    }
}
