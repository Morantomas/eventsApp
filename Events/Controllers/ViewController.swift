//
//  ViewController.swift
//  Events
//
//  Created by Tomas Moran on 31/08/2019.
//  Copyright © 2019 Tomas Moran. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "eventoCell"
    
    var datesArray = [TimeInterval]()
    var eventsByDatesDict = [TimeInterval: [EventModel]]()
    var modelToShow: EventModel?
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func showSimpleAlert(with type: typeAlert) {
        let alert = UIAlertController(title: "Error", message: type == typeAlert.genericError ? "Hubo un error al obtener los datos" : "Por favor completa todos los campos" , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? addEventController {
            destination.delegate = self
            if let toSend = modelToShow {
                destination.eventName = toSend.eventName ?? ""
                destination.descriptionString = toSend.description ?? ""
                destination.dateString = toSend.eventDate
                destination.initialHour = toSend.initialHour ?? ""
                destination.endHour = toSend.endHour ?? ""
                destination.location = toSend.location ?? ""
                destination.participantes = toSend.participants ?? ""
                destination.isPublicOrPrivateSeg?.selectedSegmentIndex = toSend.typeofEvent == .isPublic ? 0 : 1
                destination.hideButton = true
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Date(timeIntervalSinceReferenceDate: datesArray[section])
        return dateFormatter.string(from: date)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsByDatesDict[datesArray[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let eventData = eventsByDatesDict[datesArray[indexPath.section]]?[indexPath.row] else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! EventCell
        cell.configureCell(withData: eventData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let eventModelSection = eventsByDatesDict[datesArray[indexPath.section]]?[indexPath.row] {
            modelToShow = eventModelSection
            self.performSegue(withIdentifier: "showEventDetail", sender: self)
        }
    }
    
}

extension ViewController: ConfirmNewEventProtocol {
    func confirmNewEvent(withEvent event: EventModel?) {
        
        if let eventUnwrapped = event, let dateEvent = eventUnwrapped.eventDate {
            
            if eventsByDatesDict[dateEvent] == nil {
                eventsByDatesDict[dateEvent] = [eventUnwrapped]
            } else {
                eventsByDatesDict[dateEvent]?.append(eventUnwrapped)
            }
            
            datesArray.removeAll(keepingCapacity: false)
            datesArray = eventsByDatesDict.keys.sorted()
            tableView.reloadData()
            
        } else {
            showSimpleAlert(with: .genericError)
        }
    }
}
