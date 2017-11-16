//
//  ViewController.swift
//  StageCoach
//
//  Created by Nami Shah on 14/11/2017.
//  Copyright © 2017 Nami Shah. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Alamofire
import SwiftyJSON
import SwiftOverlays
import Spruce
import Eureka

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var destinationOutlet: UISegmentedControl!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func searchButton(_ sender: Any) {
        POSTrequest()
    }
    
    var tableData = [String: Any]()
    var locationManager: CLLocationManager!
    let isoFormatter = DateFormatter()
    var animations: [StockAnimation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        tableView.register(timeCell.self, forCellReuseIdentifier: "idCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.'000Z'"
        isoFormatter.locale = Locale(identifier: "en_US_POSIX")
        self.animations = [.slide(.up, .severely), .fadeIn]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func POSTrequest(){
        var newRequest = true
        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        let lat = locValue.latitude
        let long = locValue.longitude

        let date = isoFormatter.string(from: datePicker.date)

        //To Warwick University
        var destination = [
            "Destination":[
                [
                    "DestinationPlace":[
                        "Name":"University Of Warwick (Coventry), Warwickshire",
                        "LocalityId":"ZYX25595"
                    ],
                    "AllowWalk":true
                ]
            ]
        ]
        //To Leamington Spa
        if destinationOutlet.selectedSegmentIndex == 1 {
            destination = [
                "Destination":[
                    [
                        "DestinationPlace":[
                            "Name":"Regent Street, Royal Leamington Spa",
                            "Geocode":[
                                "Grid":[
                                    "value":"WGS84"
                                ],
                                "Longitude":-1.5371027744554284,
                                "Latitude":52.290255061239606
                            ]
                        ],
                        "AllowWalk":true
                    ]
                ]
            ]
        }
        
        let headers = [ "Content-Type" : "application/json", "DNT": "1", "X-SC-apiKey": "ukbusprodapi_7k8K536tNsPH#!", "X-SC-securityMethod":"API"]
        
        let parameters: [String: Any] = [
            "Origins":[
                "Origin":[
                    [
                        "OriginPlace":[
                            "Name":"Use my current location",
                            "Geocode":[
                                "Latitude":lat,
                                "Longitude":long
                            ]
                        ],
                        "AllowWalk":true
                    ]
                ]
            ],
            "Destinations": destination,
            "GenericDayPattern":"targetDateOnly",
            "Departure":[
                "TargetDepartureTime":[
                    "value":date
                ],
                "LatestDepartureLeeway":"PT120M"
            ],
            "ResponseCharacteristics":[
                "MaxLaterItineraries":[
                    "value":500
                ],
                "CreateTimetableRows":true,
                "ItineraryOrdering":"timeliness",
                "CollateItineraries":true,
                "IncludeDaysOfOperation":true,
                "IncludeSituations":true
            ],
            "SearchVariations":[
                "SearchVariation":[
                    [
                        "SearchVariationId":"Balanced",
                        "Walking":[
                            "AllWalkLegs":[
                                "WalkCostMultiplier":4
                            ]
                        ],
                        "Transfers":[
                            "MaximumTransfers":2,
                            "TransferFixedCost":900
                        ]
                    ]
                ]
            ],
            "RequestId":"itinerary-query-stagecoach"
        ]
        
        Alamofire.request("https://api.stagecoachbus.com/tis/v3/itinerary-query", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {
            (response) in
            //self.showWaitOverlay()
            let json = JSON(data: response.data!)
            self.tableData = [String: Any]()
            for (key,subJson):(String, JSON) in json["Itineraries"]["Itinerary"] {
                // Do something you want
                var departStop = subJson["Legs"]["Leg"][1]["LegBoard"]["Name"]
                var depart = subJson["Legs"]["Leg"][1]["LegBoard"]["ScheduledDepartureTime"]["value"]
                var arriveStop = subJson["Legs"]["Leg"][1]["LegAlight"]["Name"]
                var arrive = subJson["Legs"]["Leg"][1]["LegAlight"]["ScheduledArrivalTime"]["value"]
                var service = subJson["Legs"]["Leg"][1]["Trip"]["Service"]["ServiceNumber"]
                if service == JSON.null {
                    self.showMessage(message: "Please select a destination further away", forTime: 3)
                    newRequest = false
                    break;
                } else {
                    self.tableData[key] = [service.string!,departStop.string!,depart.string!,arriveStop.string!, arrive.string!]
                }
            }
            let animation = SpringAnimation(duration: 0.7)
            DispatchQueue.main.async {
                self.tableView?.spruce.animate(self.animations, animationType: animation, sortFunction: LinearSortFunction(direction: .topToBottom, interObjectDelay: 0.05))
            }
            if(self.tableData.count < 1 && newRequest){
                self.showMessage(message: "Oh oh! There are no buses at this time!", forTime: 3)
            }
            self.tableView.reloadData()
            //self.removeAllOverlays()
        }
    }
    
    func showMessage(message: String, forTime: Double){
        SwiftOverlays.showTextOverlay(self.view, text: message)
        DispatchQueue.main.asyncAfter(deadline: .now() + forTime, execute: {
            self.removeAllOverlays()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        let cell: timeCell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as! timeCell
        let service = (tableData["\(indexPath.row)"]! as! [String])[0]
        let departStop = (tableData["\(indexPath.row)"]! as! [String])[1]
        let depart = isoFormatter.date(from: (tableData["\(indexPath.row)"]! as! [String])[2])
        let arriveStop = (tableData["\(indexPath.row)"]! as! [String])[3]
        let arrival = isoFormatter.date(from: (tableData["\(indexPath.row)"]! as! [String])[4])
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let departHour = formatter.string(from: depart!)
        let arrivalHour = formatter.string(from: arrival!)
        cell.setLabels(service: "\(service)", departTime: "\(departHour)", arriveTime: "\(arrivalHour)", departStop: "\(departStop)", arriveStop: "\(arriveStop)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.white//UIColor(red: 231/255, green: 189/255, blue: 81/255, alpha: 0.2)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.white//UIColor(red: 231/255, green: 189/255, blue: 81/255, alpha: 0.2)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cellToDeSelect:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        cellToDeSelect.contentView.backgroundColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return tableData.count
    }
}

