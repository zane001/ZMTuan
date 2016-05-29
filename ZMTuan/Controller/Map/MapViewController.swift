//
//  MapViewController.swift
//  ZMTuan
//
//  Created by zm on 5/19/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

let kDefaultCalloutViewMargin: CGFloat = -8
let MAPKEY = "2812f1e8b5f3c1473e8928ae9130e63d"

class MapViewController: UIViewController, MAMapViewDelegate, AMapSearchDelegate{

    var mapView: MAMapView!
    var locationBtn: UIButton?
    
//    地址转码
    var search: AMapSearchAPI!
    var currentLocation: CLLocation!
    
//    附近搜索数据
    var pois: NSMutableArray!
    var mAnnotations = NSMutableArray()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.initMapView()
        self.setNav()
        self.initControls()
        self.initSearch()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            self.getAroundMerchantData()
        }
    }

    func initMapView() {
        MAMapServices.sharedServices().apiKey = MAPKEY
        self.mapView = MAMapView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)))
        mapView.delegate = self
        mapView.compassOrigin = CGPointMake(mapView.compassOrigin.x, 22)
        mapView.scaleOrigin = CGPointMake(mapView.scaleOrigin.x, 22)
        self.view.addSubview(mapView)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .Follow
    }
    
    func setNav() {
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(15, 20, 30, 30)
        backBtn.addTarget(self, action: #selector(self.onBackBtn(_:)), forControlEvents: .TouchUpInside)
        backBtn.setImage(UIImage(named: "back"), forState: .Normal)
        self.view.addSubview(backBtn)
    }
    
    
    func initControls() {
        self.locationBtn = UIButton(type: .Custom)
        locationBtn!.frame = CGRectMake(20, CGRectGetHeight(mapView.bounds)-80, 40, 40)
        locationBtn!.autoresizingMask = [.FlexibleRightMargin, .FlexibleTopMargin]
        locationBtn!.backgroundColor = UIColor.whiteColor()
        locationBtn!.layer.cornerRadius = 5
        locationBtn!.setImage(UIImage(named: "location_no"), forState: .Normal)
        locationBtn!.addTarget(self, action: #selector(MapViewController.locateAction), forControlEvents: .TouchUpInside)
        mapView.addSubview(locationBtn!)
    }
    
    func initSearch() {
        self.search = AMapSearchAPI()
        search.delegate = self
    }
    
    
//  获取附近商家列表
    func getAroundMerchantData() {
        let urlStr = "http://api.meituan.com/group/v1/deal/select/position/39.983478,116.318049/cate/1?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=ji%2BV3hnRG9MHGaryLpiFV9Fiw5o%3D&__skno=1F082187-597D-4636-B088-B54186954C10&__skts=1436951992.642581&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&distance=2051&fields=slug%2Ccate%2Csubcate%2Crdplocs%2Cimgurl%2Ctitle%2Csmstitle%2Cprice%2Cbrandname%2Cmname%2Crating%2Crate-count%2Capplelottery%2Cid&limit=30&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-15-15-51824&mypos=39.983478%2C116.318049&offset=0&sort=defaults&ste=_b0&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGhomepage_map&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7"
        NetworkSingleton.sharedManager.sharedSingleton.getAroundMerchantResult([:], url: urlStr, successBlock: { (responseBody) in
            print("获取附近商家成功")
            let dataArray = responseBody.objectForKey("data") as? NSMutableArray
            if dataArray!.count > 0 {
                self.mapView.removeAnnotations([self.mAnnotations])
                self.mAnnotations.removeAllObjects()
                
                for i in 0 ..< dataArray!.count {
                    let maAroundM = MAroundModel.mj_objectWithKeyValues(dataArray![i])
                    let annotation = MAroundAnnotation()
                    annotation.maAroundM = maAroundM
                    annotation.title = maAroundM.mname
                    annotation.subtitle = "\(maAroundM.price)元"
                    annotation.coordinate = CLLocationCoordinate2DMake(LATITUDE_DEFAULT, LONGITUDE_DEFAULT)
                    if maAroundM.rdplocs.count > 0 {
                        let dic: NSDictionary = maAroundM.rdplocs[0] as! NSDictionary
                        let lat = dic.objectForKey("lat") as? Double
                        let lng = dic.objectForKey("lng") as? Double
                        annotation.coordinate = CLLocationCoordinate2DMake(lat!, lng!)
                    }
                    self.mAnnotations.addObject(annotation)
                }
                self.performSelectorOnMainThread(#selector(self.updateUI), withObject: self.mAnnotations, waitUntilDone: true)
            }
            }) { (error) in
                print("地图：获取附近商家失败, \(error)")
        }
    }
    
    func updateUI() {
        print("annotation个数:\(mAnnotations.count)")
        for i in 0 ..< mAnnotations.count {
            mapView.addAnnotation(mAnnotations[i] as! MAAnnotation)
        }
    }
    
//    响应事件
    func onBackBtn(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func locateAction() {
        if mapView.userTrackingMode != MAUserTrackingMode.Follow {
            mapView.setUserTrackingMode(.Follow, animated: true)
        }
        self.searchAction()
    }
    
//    逆地理编码
//    发起搜索请求
    func reGeoAction() {
        if (currentLocation != nil) {
            let request = AMapReGeocodeSearchRequest()
            request.location = AMapGeoPoint.locationWithLatitude(CGFloat(currentLocation.coordinate.latitude), longitude: CGFloat(currentLocation.coordinate.longitude))
            search.AMapReGoecodeSearch(request)
        }
    }
    
    func searchAction() {
        if currentLocation == nil || search == nil {
            print("search failed")
            return
        }
        let request = AMapPOIAroundSearchRequest()
        request.keywords = "餐饮"
        request.location = AMapGeoPoint.locationWithLatitude(CGFloat(currentLocation.coordinate.latitude), longitude: CGFloat(currentLocation.coordinate.longitude))
        search.AMapPOIAroundSearch(request)
    }
    
    
//    MAKR: MapViewDelegate
//    更新位置
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        currentLocation = userLocation.location.copy() as! CLLocation
    }
    
//    替换定位图标
    func mapView(mapView: MAMapView!, didChangeUserTrackingMode mode: MAUserTrackingMode, animated: Bool) {
        if mode == MAUserTrackingMode.None {
            locationBtn?.setImage(UIImage(named: "location_no"), forState: .Normal)
        } else {
            locationBtn?.setImage(UIImage(named: "location_yes"), forState: .Normal)
        }
    }
    
//    点击大头针
    func mapView(mapView: MAMapView!, didSelectAnnotationView view: MAAnnotationView!) {
        if view.annotation.isKindOfClass(MAUserLocation.classForCoder()) {
            self.reGeoAction()
        }
        
//        调整自定义callout的位置，使其可以完全显示
        if view.isKindOfClass(CustomAnnotationView.classForCoder()) {
            let cView = CustomAnnotationView()
            var frame: CGRect = cView.convertRect(cView.calloutView!.frame, toView: mapView)
            frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kDefaultCalloutViewMargin, kDefaultCalloutViewMargin, kDefaultCalloutViewMargin, kDefaultCalloutViewMargin))
            if !CGRectContainsRect(mapView.frame, frame) {
                let offset: CGSize = self.offsetToContainRect(frame, inRect: mapView.frame)
                var center: CGPoint = mapView.center
                center = CGPointMake(center.x-offset.width, center.y-offset.height)
                let coordinate: CLLocationCoordinate2D = mapView.convertPoint(center, toCoordinateFromView: mapView)
                mapView.setCenterCoordinate(coordinate, animated: true)
            }
        }
    }
    
//    显示大头针
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKindOfClass(MAPointAnnotation.classForCoder()) {
            let reuserIdentifier = "annotationReuseIndetifier"
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuserIdentifier) as? CustomAnnotationView
            if annotationView == nil {
                annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: reuserIdentifier)
            }
            if annotation.isKindOfClass(MAroundAnnotation.classForCoder()) {
                annotationView?.annotation = annotation as? MAroundAnnotation
            }
            annotationView?.canShowCallout = false
            annotationView?.image = UIImage(named: "icon_map_cateid_1")
            return annotationView
        }
        return nil
    }
    
//    MARK: AMapSearchDelegate
    
//    搜索失败
    func AMapSearchRequest(request: AnyObject!, didFailWithError error: NSError!) {
        print("request: \(request), error: \(error)")
    }
    
//    逆地址编码
    func onReGeocodeSearchDone(request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        print("response: \(response)")
        var title = response.regeocode.addressComponent.city
        if title.characters.count == 0 {
            title = response.regeocode.addressComponent.province
        }
        mapView.userLocation.title = title
        mapView.userLocation.subtitle = response.regeocode.formattedAddress
    }
    
//    地址搜索回调
    func onPOISearchDone(request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        print("地址搜索request \(request)")
        mapView.removeAnnotations([mAnnotations])
        mAnnotations.removeAllObjects()
        pois.removeAllObjects()
        
        if response.pois.count > 0 {
            pois = NSMutableArray(array: response.pois)
            for i in 0 ..< pois.count {
                let poi: AMapPOI = pois[i] as! AMapPOI
                let annotation = MAPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(Double(poi.location.latitude), Double(poi.location.longitude))
                annotation.title = poi.name
                annotation.subtitle = poi.address
                
                mAnnotations.addObject(annotation)
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    func offsetToContainRect(innerRect: CGRect, inRect outerRect: CGRect) -> CGSize {
        let nudgeRight = fmaxf(0, Float(CGRectGetMinX(outerRect) - CGRectGetMinX(innerRect)))
        let nudgeLeft = fminf(0, Float(CGRectGetMaxX(outerRect) - CGRectGetMaxX(innerRect)))
        let nudgeBottom = fmaxf(0, Float(CGRectGetMinY(outerRect) - CGRectGetMinY(innerRect)))
        let nudgeTop = fminf(0, Float(CGRectGetMaxY(outerRect) - CGRectGetMaxY(innerRect)))
        return CGSizeMake(CGFloat(nudgeLeft), CGFloat(nudgeTop))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
