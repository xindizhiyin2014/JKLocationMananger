
import Foundation
import CoreLocation

typealias LocateSuccessBlock = (_ currentLocation:CLLocation?) -> Void
typealias LocateFailureBlock = (_ error:Error?) -> Void

@objcMembers public class JKLocationMananger: NSObject,CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager
    
    var successBlock:LocateSuccessBlock?
    
    var failureBlock:LocateFailureBlock?
    
    static let shareInstance = JKLocationMananger()
    
    
    private override init() {
        
        self.locationManager = CLLocationManager.init()
        super.init()
        if #available(iOS 8.0, *) {
          self.locationManager .requestWhenInUseAuthorization()
        }
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 5.0
        self.locationManager.delegate = self
    }
    
  public class func locate(success:((_ latitude:Double? ,_ longitude:Double?) ->Void)?,failure:((_ error:Error?) ->Void)?) ->Void{
        if CLLocationManager.locationServicesEnabled() {

            JKLocationMananger.shareInstance.failureBlock = failure
            JKLocationMananger.shareInstance.successBlock = {(_ currentLocation:CLLocation?) ->Void in
                if let success = success {
                success(currentLocation!.coordinate.latitude,currentLocation!.coordinate.longitude)
                }
            }
        JKLocationMananger.shareInstance.locationManager .startUpdatingLocation()
        }
    }
    
   public class func locate(success:((_ city:String?) ->Void)?,failure:((_ error:Error?) ->Void)?) ->Void{
        
        if CLLocationManager.locationServicesEnabled() {
            JKLocationMananger.shareInstance.failureBlock = failure
            JKLocationMananger.shareInstance.successBlock = {(_ currentLocation:CLLocation?) ->Void in
                if let success = success {
                    let geocoder = CLGeocoder.init()
                    geocoder.reverseGeocodeLocation(currentLocation!, completionHandler: { (placemarks, error) in
                        let place = placemarks!.last
                        let city = place!.locality
                        success(city)
                        
                    })
                    
                }
                
            }
        JKLocationMananger.shareInstance.locationManager .startUpdatingLocation()
        }
        
    }
    
   private func clearBlock() -> () {
        self.successBlock = nil
        self.failureBlock = nil
    }
    
    
    /// CoreLocationDelegate
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if self.failureBlock != nil {
            self.failureBlock!(error)
            self.clearBlock()
        }
       
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       self.locationManager.stopUpdatingLocation()
        if self.successBlock != nil {
            let currentLocation = locations.last
            self.successBlock!(currentLocation!)
            self.clearBlock()
        }
        
    }
    
    
}
