//
//  ViewController.m
//  test
//
//  Created by yi chen on 14-8-20.
//  Copyright (c) 2014年 yi chen. All rights reserved.
//



#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "CustomMovingAnnotation.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "CustomPointAnnotation.h"
#import "StartPointAnnotation.h"
#import <MAMapKit/MATraceManager.h>

static CLLocationCoordinate2D s_coords[] =
{
    {39.97617053371078, 116.3499049793749},
//    {39.97619854213431, 116.34978804908442},
//    {39.97623045687959, 116.349674596623},
//    {39.97626931100656, 116.34955525200917},
//    {39.976285626595036, 116.34943728748914},
//    {39.97628129172198, 116.34930864705592},
    {39.976260803938594, 116.34918981582413},
//    {39.97623535890678, 116.34906721558868},
//    {39.976214717128855, 116.34895185151584},
//    {39.976280148755315, 116.34886935936889},
//    {39.97628182112874, 116.34873954611332},
//    {39.97626038855863, 116.34860763527448},
    {39.976306080391836, 116.3484658907622},
//    {39.976358252119745, 116.34834585430347},
//    {39.97645709321835, 116.34831166130878},
//    {39.97655231226543, 116.34827643560175},
//    {39.976658372925556, 116.34824186261169},
//    {39.9767570732376, 116.34825080406188},
    {39.976869087779995, 116.34825631960626},
//    {39.97698451764595, 116.34822111635201},
//    {39.977079745909876, 116.34822901510276},
//    {39.97718701787645, 116.34822234337618},
//    {39.97730766147824, 116.34821627457707},
//    {39.977417746816776, 116.34820593515043},
    {39.97753930933358, 116.34821013897107},
//    {39.977652209132174, 116.34821304891533},
//    {39.977764016531076, 116.34820923399242},
//    {39.97786190186833, 116.3482045955917},
//    {39.977958856930286, 116.34822159449203},
//    {39.97807288885813, 116.3482256370537},
    {39.978170063673524, 116.3482098441266},
//    {39.978266951404066, 116.34819564465377},
//    {39.978380693859116, 116.34820541974412},
//    {39.97848741209275, 116.34819672351216},
//    {39.978593409607825, 116.34816588867105},
//    {39.97870216883567, 116.34818489339459},
    {39.978797222300166, 116.34818473446943},
//    {39.978893492422685, 116.34817728972234},
//    {39.978997133775266, 116.34816491505472},
//    {39.97911413849568, 116.34815408537773},
//    {39.97920553614499, 116.34812908154862},
//    {39.979308267469264, 116.34809495907906},
    {39.97939658036473, 116.34805113358091},
//    {39.979491697188685, 116.3480310509613},
//    {39.979588529006875, 116.3480082124968},
//    {39.979685789111635, 116.34799530586834},
//    {39.979801430587926, 116.34798818413954},
//    {39.97990758587515, 116.3479996420353},
    {39.980000796262615, 116.34798697544538},
//    {39.980116318796085, 116.3479912988137},
//    {39.98021407403913, 116.34799204219203},
//    {39.980325006125696, 116.34798535084123},
//    {39.98042511477518, 116.34797702460183},
//    {39.98054129336908, 116.34796288754136},
    {39.980656820423505, 116.34797509821901},
//    {39.98074576792626, 116.34793922017285},
//    {39.98085620772756, 116.34792586413015},
//    {39.98098214824056, 116.3478962642899},
//    {39.98108306010269, 116.34782449883967},
//    {39.98115277119176, 116.34774758827285},
    {39.98115430642997, 116.34761476652932},
//    {39.98114590845294, 116.34749135408349},
//    {39.98114337322547, 116.34734772765582},
//    {39.98115066909245, 116.34722082902628},
//    {39.98114532232906, 116.34708205250223},
//    {39.98112245161927, 116.346963237696},
    {39.981136637759604, 116.34681500222743},
//    {39.981146248090866, 116.34669622104072},
//    {39.98112495260716, 116.34658043260109},
//    {39.9811107163792, 116.34643721418927},
//    {39.981085081075676, 116.34631638374302},
//    {39.98108046779486, 116.34614782996252},
    {39.981049089345206, 116.3460256053666},
//    {39.98104839362087, 116.34588814050122},
//    {39.9810544889668, 116.34575119741586},
//    {39.981040940565734, 116.34562885420186},
//    {39.98105271658809, 116.34549232235582},
//    {39.981052294975264, 116.34537348820508},
    {39.980956549928244, 116.3453513775533}
    
    


    
};

@interface ViewController ()<MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic, strong) MAMapView *mapView;

///车头方向跟随转动
@property (nonatomic, strong) MAAnimatedAnnotation *car1;
///车头方向不跟随转动
@property (nonatomic, strong) CustomMovingAnnotation *car2;

///全轨迹overlay
@property (nonatomic, strong) MAPolyline *fullTraceLine;
///走过轨迹的overlay
@property (nonatomic, strong) MAPolyline *passedTraceLine;


@property (nonatomic, assign) int passedTraceCoordIndex;

@property (nonatomic, strong) NSArray *distanceArray;
@property (nonatomic, assign) double sumDistance;

@property (nonatomic, weak) MAAnnotationView *car1View;
@property (nonatomic, weak) MAAnnotationView *car2View;

@property (nonatomic, strong) MAAnimatedAnnotation *carMoveAnnotation;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapDrivingRouteSearchRequest *searchRequest;
@property (nonatomic, strong) NSDate *lastDate;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *moveModelArray;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) int reCount;
@property (nonatomic, strong) NSTimer *moveTimer;
@property (nonatomic, assign) BOOL carIsMoving,status,otherStatus,canUse,isSearchPlan;
@property (nonatomic, assign) NSInteger times;
///走过轨迹的overlay
@property (nonatomic, strong) MAPolyline *carRunTraceLine;
@property (nonatomic, strong) MAPolyline *planTraceLine;
@property (nonatomic, strong) MATraceManager *traceManager; // 地图纠偏对象
@end

@implementation ViewController

#pragma mark - Map Delegate

- (void)mapInitComplete:(MAMapView *)mapView {
    [self initRoute];
}

- (void)initRoute {
    int count = sizeof(s_coords) / sizeof(s_coords[0]);
    
    self.fullTraceLine = [MAPolyline polylineWithCoordinates:s_coords count:count];
    [self.mapView addOverlay:self.fullTraceLine];
    
    NSMutableArray * routeAnno = [NSMutableArray array];
    for (int i = 0 ; i < count; i++) {
        MAPointAnnotation * a = [[MAPointAnnotation alloc] init];
        a.coordinate = s_coords[i];
        a.title = @"route";
        [routeAnno addObject:a];
    }
    [self.mapView addAnnotations:routeAnno];
    [self.mapView showAnnotations:routeAnno animated:NO];
    
}

//小车2走过的轨迹置灰色
- (void)updatePassedTrace {
    if(self.car2.isAnimationFinished) {
        return;
    }
    
    if(self.passedTraceLine) {
        [self.mapView removeOverlay:self.passedTraceLine];
    }
    
    int needCount = self.passedTraceCoordIndex + 2;
    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * needCount);
    
    memcpy(coords, s_coords, sizeof(CLLocationCoordinate2D) * (self.passedTraceCoordIndex + 1));
    coords[needCount - 1] = self.car2.coordinate;
    self.passedTraceLine = [MAPolyline polylineWithCoordinates:coords count:needCount];
    [self.mapView addOverlay:self.passedTraceLine];
    
    if(coords) {
        free(coords);
    }
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[CustomPointAnnotation class]]) {
        NSString *indentifier = @"CustomPointAnnotation";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:indentifier];
        if (annotationView == nil){
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:indentifier];
        }
        
        if ([annotation.title isEqualToString:@"runPlan"]) {
            annotationView.pinColor = MAPinAnnotationColorPurple;
        }else{
            annotationView.pinColor = MAPinAnnotationColorRed;
        }
        
        annotationView.canShowCallout = YES;
        
        
        return annotationView;
    }
    
    if ([annotation isKindOfClass:[StartPointAnnotation class]]) {
        NSString *indentifier = @"StartPointAnnotation";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:indentifier];
        if (annotationView == nil){
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:indentifier];
        }
        
    
        annotationView.pinColor = MAPinAnnotationColorPurple;
        annotationView.canShowCallout = YES;
        
        
        return annotationView;
    }
    
    if (annotation == self.car1 || annotation == self.carMoveAnnotation) {
        NSString *pointReuseIndetifier = @"pointReuseIndetifier1";
        
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if(!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            
            annotationView.canShowCallout = YES;
            
            UIImage *imge  =  [UIImage imageNamed:@"car1"];
            annotationView.image =  imge;
            
            self.car1View = annotationView;
        }

        return annotationView;
    } else if(annotation == self.car2) {
        NSString *pointReuseIndetifier = @"pointReuseIndetifier2";
        
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if(!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            
            annotationView.canShowCallout = YES;
            
            UIImage *imge  =  [UIImage imageNamed:@"car2"];
            annotationView.image =  imge;
            
            self.car2View = annotationView;
        }
        return annotationView;
    }else if([annotation isKindOfClass:[MAPointAnnotation class]]){
        NSString *pointReuseIndetifier = @"pointReuseIndetifier3";
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            annotationView.canShowCallout = YES;
        }
        
        if ([annotation.title isEqualToString:@"route"]) {
            annotationView.enabled = NO;
            annotationView.image = [UIImage imageNamed:@"trackingPoints"];
        }
        
        return annotationView;
    }

    
    return nil;
}

- (MAPolylineRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if(overlay == self.fullTraceLine) {
        MAPolylineRenderer *polylineView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 6.f;
        polylineView.strokeColor = [UIColor colorWithRed:0 green:0.47 blue:1.0 alpha:0.9];
        
        return polylineView;
    } else if(overlay == self.passedTraceLine) {
        MAPolylineRenderer *polylineView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 6.f;
        polylineView.strokeColor = [UIColor grayColor];
        
        return polylineView;
    }else if (overlay == self.carRunTraceLine){
        MAPolylineRenderer *polylineView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 6.f;
        polylineView.strokeColor = [UIColor blueColor];
        
        return polylineView;
    }else if (overlay == self.planTraceLine){
        MAPolylineRenderer *polylineView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 6.f;
        polylineView.strokeColor = [UIColor redColor];
        
        return polylineView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    NSLog(@"cooridnate :%f, %f", view.annotation.coordinate.latitude, view.annotation.coordinate.longitude);
}

#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.times = 1;
    self.canUse = YES;
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.frame];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
//    self.coordinate = CLLocationCoordinate2DMake(s_coords[0].latitude, s_coords[0].longitude);
    self.reCount = 0;
    
    [self setUpTimerMethod];
    
    [self setUpMoveTimer];
    
//    [self setUpBtn];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setUpTimerMethod{
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}



//timer 方法
- (void)timerAction:(NSTimer *)timer{
    
    _lastDate = [NSDate date];
    
    
    if (self.coordinate.latitude < 1) {
        self.coordinate = CLLocationCoordinate2DMake(s_coords[self.reCount].latitude, s_coords[self.reCount].longitude);
    }else{
        CLLocationCoordinate2D endCoordinate = CLLocationCoordinate2DMake(s_coords[self.reCount].latitude, s_coords[self.reCount].longitude);
        
        [self tracePointWithStart:self.coordinate end:endCoordinate];
        
//        NSLog(@"规划前的起点lati == %f,lon == %f",self.coordinate.latitude,self.coordinate.longitude);
//        NSLog(@"规划前的终点lati == %f,lon == %f",endCoordinate.latitude,endCoordinate.longitude);
        
        self.coordinate = CLLocationCoordinate2DMake(s_coords[self.reCount].latitude, s_coords[self.reCount].longitude);
        
    }
    self.reCount += 1;
    
}

- (NSMutableArray *)moveModelArray{
    if (_moveModelArray == nil) {
        _moveModelArray = [NSMutableArray array];
    }
    return _moveModelArray;
}

- (MAAnimatedAnnotation *)carMoveAnnotation{
    if (_carMoveAnnotation == nil) {
        _carMoveAnnotation = [[MAAnimatedAnnotation alloc] init];
        _carMoveAnnotation.title = @"自定义小车";
        [self.mapView addAnnotation:_carMoveAnnotation];
    }
    return _carMoveAnnotation;
}

- (AMapDrivingRouteSearchRequest *)searchRequest{
    if (_searchRequest == nil) {
        _searchRequest = [[AMapDrivingRouteSearchRequest alloc] init];
        _searchRequest.strategy = 2;
    }
    return _searchRequest;
}

- (AMapSearchAPI *)search{
    if (_search == nil) {
        _search = [[AMapSearchAPI alloc] init];
        [_search setDelegate:(id<AMapSearchDelegate>) self];
    }
    return _search;
}

#pragma  #######################   开始驾驶路径规划  ####################################

/**
 驾车路径规划
 
 @param startCoordinate 起点经纬度
 @param endCoordiante 终点经纬度
 */
- (void)searchRoutePlanningDriveWithStartCoordinate:(CLLocationCoordinate2D)startCoordinate
                                      endCoordiante:(CLLocationCoordinate2D)endCoordiante{
    
    /* 出发点. */
    self.searchRequest.origin = [AMapGeoPoint locationWithLatitude:startCoordinate.latitude
                                           longitude:startCoordinate.longitude];
    /* 目的地. */
    self.searchRequest.destination = [AMapGeoPoint locationWithLatitude:endCoordiante.latitude
                                                longitude:endCoordiante.longitude];
    
    [self.search AMapDrivingRouteSearch:self.searchRequest];
}

#pragma mark ---------------------------AMapSearchDelegate--------------------------

- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response{
    NSLog(@"路径规划成功");
    if (response.route == nil){
        return;
    }
    AMapRoute *route = response.route;
    
    NSArray *paths = route.paths;
    AMapPath *path = (AMapPath *)paths.firstObject;
    
    NSArray<AMapStep *> *steps = path.steps;
    
    
    [self createPathFromPathSteps:steps withTime:1];
    
    
}

- (void)search:(id)searchRequest error:(NSString *)errInfo{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [searchRequest class], errInfo);
}

/**
 根据规划步骤进行划线
 
 @param steps 规划步骤
 @param time 耗时
 */

- (void)createPathFromPathSteps:(NSArray<AMapStep *>*)steps withTime:(long)time{
    
    if (steps.count <= 0) {
        return ;
    }
    
    
    NSString *polyStr;
    for (NSInteger i = 0; i < steps.count; i++) {
        AMapStep *step = steps[i];
        if (polyStr == nil) {
            polyStr = [NSString stringWithString:step.polyline];
        }else{
            polyStr = [polyStr stringByAppendingString:[NSString stringWithFormat:@";%@",step.polyline]];
        }
        
    }
    
    
//    NSInteger duration = [self timeIntervalFromLastTime:self.lastDate ToCurrentTime:[NSDate date]] * 4;
    NSInteger duration = 1;
    NSDictionary *t_dic = @{@"polyline":polyStr,@"duration":[NSNumber numberWithInteger:duration]};
    [self.moveModelArray addObject:t_dic];
    
//    NSLog(@"规划的路径点集合 ====  %@ ,此时的数据源数组 = %@",polyStr,self.moveModelArray);
    
}

/**
 计算时间差

 @param lastTime 上次时间
 @param currentTime 到当前时间
 @return 两个时间的时间差
 */
- (NSInteger)timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    
    return intevalTime;
}

- (void)moveAnimationWithDictionary:(NSDictionary *)moveDictionary{
    
    NSString *polyline = [moveDictionary objectForKey:@"polyline"];
    CGFloat duration = [[moveDictionary objectForKey:@"duration"] floatValue];

    NSArray *polyArray = [polyline componentsSeparatedByString:@";"];
    CLLocationCoordinate2D *coords = malloc([polyArray count] * sizeof(CLLocationCoordinate2D));
    for (NSUInteger j = 0; j < polyArray.count; j++) {
        NSString *t_latAndLon = polyArray[j];
        NSArray *t_latAndLonArray = [t_latAndLon componentsSeparatedByString:@","];
        
        CLLocation *t_location = [[CLLocation alloc] initWithLatitude:[t_latAndLonArray.lastObject floatValue] longitude:[t_latAndLonArray.firstObject floatValue]];
        coords[j] = [t_location coordinate];
    }
    
    self.carIsMoving = YES;
    self.carMoveAnnotation.coordinate = coords[0];
    NSLog(@"开始进行平滑移动");
    __weak typeof (self) weakSelf = self;
    [self.carMoveAnnotation addMoveAnimationWithKeyCoordinates:coords
                                                         count:polyArray.count
                                                  withDuration:duration
                                                      withName:nil
                                              completeCallback:^(BOOL isFinished) {
                                                  if (isFinished) {
                                                      NSLog(@"小车移动结束");
                                                      weakSelf.carIsMoving = NO;
                                                  }
                                                  
                                                  
                                              }];
    
}

- (void)setUpMoveTimer{
    self.moveTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(carMoveAction:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.moveTimer forMode:NSRunLoopCommonModes];
}

- (void)carMoveAction:(NSTimer *)timer{
    
    if (self.carIsMoving == NO) {
        
        
        if (self.moveModelArray.count >= self.times) {
            
//            NSLog(@"小车开始移动前的数据源 = %@",self.moveModelArray);
            NSString *polyline;
            CGFloat duration;
            
            NSUInteger count = self.moveModelArray.count;
            for (NSInteger i = 0; i < count; i++) {
                NSDictionary *dic = self.moveModelArray[i];
                NSString *t_polyline = [dic objectForKey:@"polyline"];
                CGFloat t_duration = [[dic objectForKey:@"duration"] floatValue];
                if (polyline == nil) {
                    polyline = [NSString stringWithString:t_polyline];
                    duration += t_duration;
                }else{
                    polyline = [polyline stringByAppendingString:[NSString stringWithFormat:@";%@",t_polyline]];
                    duration += t_duration;
                }
            }

            for (NSInteger i = 0; i < count; i++) {
                [self.moveModelArray removeObjectAtIndex:0];
            }

            NSDictionary *t_dic = @{@"polyline":polyline,@"duration":[NSNumber numberWithInteger:duration]};
            [self moveAnimationWithDictionary:t_dic];
            
//            NSLog(@"小车开始移动时的数据源 = %@,时长 = %f",self.moveModelArray,duration);
            
        }
        
    }
    
}

//- (void)setUpBtn{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(50, 50, 50, 50);
//    [btn setTitle:@"start" forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:btn];
//    
//    [btn addTarget:self action:@selector(handBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    
//}
//
//- (void)handBtnAction{
//
//    if (self.carIsMoving == NO) {
//        self.times++;
//        [self.mapView removeAnnotations:self.mapView.annotations];
//        self.canUse = YES;
//        self.isSearchPlan = NO;
//        self.otherStatus = NO;
//        self.status = NO;
//        _carMoveAnnotation = nil;
//
//    }
//    
//}

- (void)tracePointWithStart:(CLLocationCoordinate2D )startCoordinate end:(CLLocationCoordinate2D )endCoordinate{

    //轨迹纠偏
    __weak typeof (self) weakSelf = self;
    [self traceCorrectWithFirstPoint:startCoordinate andSecondPoint:endCoordinate finishBlock:^(NSArray *points, BOOL success) {
        if (success) {
//            NSLog(@"纠偏数组 = %@",points);
            
            if (points.count > 1) {
                MATracePoint *point0 = (MATracePoint *)[points firstObject];
                MATracePoint *point1 = (MATracePoint *)[points lastObject];
                CLLocationCoordinate2D start = CLLocationCoordinate2DMake(point0.latitude, point0.longitude);
                CLLocationCoordinate2D end = CLLocationCoordinate2DMake(point1.latitude, point1.longitude);
                [weakSelf searchRoutePlanningDriveWithStartCoordinate:start endCoordiante:end];
            }
            
        }
    }];
}


#pragma mark====对上次位置的点和这次位置的两个进行轨迹纠偏====
- (void)traceCorrectWithFirstPoint:(CLLocationCoordinate2D)firstPoint andSecondPoint:(CLLocationCoordinate2D)secondPoint finishBlock:(void (^)(NSArray* points, BOOL success ))finshBlock{
    
    NSMutableArray *mArr = [NSMutableArray array]; // 存放纠偏对象的数组
    
    MATraceLocation *loc_first = [[MATraceLocation alloc] init]; // 实例化司机最新位置的纠偏对象
    loc_first.loc = firstPoint;
    
    MATraceLocation *loc_second = [[MATraceLocation alloc] init]; // 实例化司机最上一次位置的纠偏对象
    loc_second.loc = secondPoint;
    
    [mArr addObject:loc_first];
    [mArr addObject:loc_second];
    
    // 开始纠偏
    [self.traceManager queryProcessedTraceWith:mArr type:-1 processingCallback:^(int index, NSArray<MATracePoint *> *points) {
//        NSLog(@"纠偏分组 = %d,分组数组 = %@",index,points);
    } finishCallback:^(NSArray<MATracePoint *> *points, double distance) {
//        NSLog(@"两点距离 = %f,分组数组 = %@",distance,points);
        finshBlock(points, YES); // 纠偏成功回调
        
    } failedCallback:^(int errorCode, NSString *errorDesc) {
        NSLog(@"error = %d,出错详情 = %@",errorCode,errorDesc);
        finshBlock(nil, false);
    }];
    
}

- (MATraceManager *)traceManager {
    
    if (_traceManager == nil) {
        
        _traceManager = [[MATraceManager alloc] init];
        
    }
    return _traceManager;
    
}


@end
