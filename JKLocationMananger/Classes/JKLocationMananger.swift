
import Foundation
import CoreLocation
typealias LocateSuccessBlock = (_ currentLocation:CLLocation) -> Void
typealias LocateFailureBlock = (_ error:Error) -> Void
class JKLocationMananger: NSObject,CLLocationManagerDelegate {
    var locationManager:CLLocationManager
    var successBlock:LocateSuccessBlock?
    var failureBlock:LocateFailureBlock?
      static let shareInstance = JKLocationMananger()
    
    
    private override init() {
      super.init()
        self.locationManager = CLLocationManager.init()
        self.locationManager.delegate = self
        if #available(iOS 8.0, *) {
          self.locationManager .requestWhenInUseAuthorization()
        }
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 5.0
    }
    
    class func locate(success:@escaping (_ latitude:Double? ,_ longitude:Double?) ->Void,failure:@escaping (_ error:Error?) ->Void) ->Void{
        if CLLocationManager.locationServicesEnabled() {
            JKLocationMananger.shareInstance.locationManager.stopUpdatingLocation()
            JKLocationMananger.shareInstance.failureBlock = failure
            JKLocationMananger.shareInstance.successBlock = {(_ currentLocation:CLLocation?) ->Void in
                if success != nil {
                    success(currentLocation?.coordinate.latitude,currentLocation?.coordinate.longitude)
                }
            }
            JKLocationMananger.shareInstance.locationManager .startUpdatingLocation()
        }
    }
    
    class func locate(success:@escaping (_ city:String) ->Void,failure:@escaping (_ error:Error?) ->Void) ->Void{
        if CLLocationManager.locationServicesEnabled() {
            JKLocationMananger.shareInstance.failureBlock = failure
            JKLocationMananger.shareInstance.successBlock = {(_ currentLocation:CLLocation?) ->Void in
                if success != nil {
                    let geocoder = CLGeocoder.init()
                    geocoder.reverseGeocodeLocation(currentLocation!, completionHandler: { (placemarks, error) in
                        let place = placemarks!.last
                        let city = place!.locality
                        success(city ?? "")
                        
                    })
                    
                }
                
            }
            JKLocationMananger.shareInstance.locationManager .startUpdatingLocation()
        }
        
    }
    
    func clearBlock() -> () {
        self.successBlock = nil
        self.failureBlock = nil
    }
    
    
    /// CoreLocationDelegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if self.failureBlock != nil {
            self.failureBlock!(error)
            self.clearBlock()
        }
       
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       self.locationManager.stopUpdatingLocation()
        if self.successBlock != nil {
            let currentLocation = locations.last
            self.successBlock!(currentLocation!)
            self.clearBlock()
        }
        
    }
    
    
}
