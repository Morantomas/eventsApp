//
//  addEventController.swift
//  Events
//
//  Created by Tomas Moran on 01/09/2019.
//  Copyright © 2019 Tomas Moran. All rights reserved.
//

import Foundation
import UIKit

enum typeOfEvent: String {
    case isPublic = "Public"
    case isPrivate = "Private"
    case none = ""
}

enum typeAlert {
    case notIsAllCompleted
    case genericError
}

protocol ConfirmNewEventProtocol {
    func confirmNewEvent(withEvent event:EventModel?)
}

class addEventController: UIViewController {
    
    var delegate: ConfirmNewEventProtocol?
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var descriptionTextvIEW: UITextView!
    @IBOutlet weak var initialHourTextField: UITextField!
    @IBOutlet weak var endHourTextField: UITextField!
    @IBOutlet weak var participantesTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var isPublicOrPrivate: UISegmentedControl!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    var eventName: String?
    var dateString: TimeInterval?
    var descriptionString: String?
    var endHour: String?
    var initialHour: String?
    var participantes: String?
    var location: String?
    var isPublicOrPrivateSeg: UISegmentedControl?
    var hideButton: Bool!
    
    var typeOfEvent: typeOfEvent = .isPublic
    var date: Date?
    var isAllCompleted: Bool = false
    var New_Event: EventModel?
    
    var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        
        return picker
    }()
    
    var pickerViewHoursMinutes: UIPickerView = UIPickerView()
    var pickerViewNumber: UIPickerView = UIPickerView()
    let numbers = [1,2,3,4,5,6,7,8,9,10]
    var hourInitial: String? = "00"
    var minutesInitial: String? = "00"
    var hourEnd: String? = "00"
    var minutesEnd: String? = "00"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupInputViewsAndToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkIfShowEvent()
    }
    
    func setupDelegates() {
        eventNameTextField.delegate = self
        descriptionTextvIEW.delegate = self
        dateTextField.delegate = self
        initialHourTextField.delegate = self
        endHourTextField.delegate = self
        participantesTextField.delegate = self
        locationTextField.delegate = self
        
        pickerViewHoursMinutes.delegate = self
        pickerViewHoursMinutes.dataSource = self
        pickerViewNumber.delegate = self
        pickerViewNumber.dataSource = self
    }
    
    func setupInputViewsAndToolBar() {
        eventNameTextField.addToolBarWithClearAndDone()
        descriptionTextvIEW.addToolBarWithClearAndDone()
        
        dateTextField.inputView = datePicker
        dateTextField.addToolBarWithDone()
        
        initialHourTextField.inputView = pickerViewHoursMinutes
        initialHourTextField.addToolBarWithDone()
        endHourTextField.inputView = pickerViewHoursMinutes
        endHourTextField.addToolBarWithDone()
        pickerViewHoursMinutes.tag = 0
        
        participantesTextField.inputView = pickerViewNumber
        pickerViewNumber.tag = 1
        participantesTextField.addToolBarWithClearAndDone()
        locationTextField.addToolBarWithClearAndDone()
    }
    
    func checkIfShowEvent() {
        if let eventFromBack = eventName {
            eventNameTextField.text = eventFromBack
            descriptionTextvIEW.text = descriptionString ?? ""
            
            let date = Date(timeIntervalSinceReferenceDate: dateString!)
            dateTextField.text = dateFormatter.string(from: date)
            
            initialHourTextField.text = initialHour ?? ""
            endHourTextField.text = endHour ?? ""
            locationTextField.text = location ?? ""
            participantesTextField.text = participantes ?? ""
            isPublicOrPrivate.selectedSegmentIndex = isPublicOrPrivateSeg?.selectedSegmentIndex == 0 ? 0 : 1
            confirmButton.isHidden = hideButton
        }
    }
    
    @objc func datePickerChanged(_ sender: UIDatePicker) {
        dateTextField.text = dateFormatter.string(from: sender.date)
        date = dateFormatter.date(from: dateTextField.text ?? "")
        print(date?.timeIntervalSinceReferenceDate.description ?? "")
        
        print(Date(timeIntervalSinceReferenceDate: date!.timeIntervalSinceReferenceDate))
    }
    
    func checkFieldsCompleted() {
        if eventNameTextField.text != "", descriptionTextvIEW.text != "", dateTextField.text != "", initialHourTextField.text != "", endHourTextField.text != "", participantesTextField.text != "", locationTextField.text != "" {
            isAllCompleted = true
        }
    }
    
    @IBAction func confirmarAction(_ sender: Any) {
        if isAllCompleted {
            if let name = eventNameTextField.text, let desc = descriptionTextvIEW.text, let date = date, let initialDate = initialHourTextField.text, let endDate = endHourTextField.text, let location = locationTextField.text, let participantes = participantesTextField.text {
                New_Event = EventModel(eventwith: name, description: desc, date: date, initialHour: initialDate, endHour: endDate, location: location, participants: participantes, typeofEvent: typeOfEvent)
                self.delegate?.confirmNewEvent(withEvent: New_Event)
                self.dismiss(animated: true, completion: nil)
            } else {
                showSimpleAlert(with: .genericError)
            }
        } else {
            showSimpleAlert(with: .notIsAllCompleted)
        }
    }
    
    @IBAction func cancelaction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeValueEventController(_ sender: Any) {
        if let value = (sender as AnyObject).selectedSegmentIndex {
            if value == 0 {
                print("Select Public")
                typeOfEvent = .isPublic
            } else {
                print("Select Private")
                typeOfEvent = .isPrivate
            }
        }
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
    
    func setMinutes(with row:Int) -> String {
        if row == 0 {
            return "00"
        } else if row == 1 {
            return "01"
        } else if row == 2 {
            return "02"
        } else if row == 3 {
            return "03"
        } else if row == 4 {
            return "04"
        } else if row == 5 {
            return "05"
        } else if row == 6 {
            return "06"
        } else if row == 7 {
            return "07"
        } else if row == 8 {
            return "08"
        } else if row == 9 {
            return "09"
        } else {
            return row.description
        }
    }
}

extension addEventController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text ?? "")
        checkFieldsCompleted()
    }
}

extension addEventController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        print(textView.text ?? "")
        checkFieldsCompleted()
    }
}

extension addEventController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0 {
            return 2
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            switch component {
            case 0:
                return 25
            case 1:
                return 60
            default:
                return 0
            }
        }
        return numbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if pickerView.tag == 0 {
            return pickerView.frame.size.width/2
        }
        return pickerView.frame.size.width
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            if initialHourTextField.isFirstResponder {
                switch component {
                case 0:
                    hourInitial = setMinutes(with: row)
                case 1:
                    minutesInitial = setMinutes(with: row)
                default:
                    break;
                }
                initialHourTextField.text = "\(hourInitial ?? "").\(minutesInitial ?? "")hs"
            } else if endHourTextField.isFirstResponder {
                switch component {
                case 0:
                    hourEnd = setMinutes(with: row)
                case 1:
                    minutesEnd = setMinutes(with: row)
                default:
                    break;
                }
                endHourTextField.text = "\(hourEnd ?? "").\(minutesEnd ?? "")hs"
            }
            
        } else {
            participantesTextField.text = "\(numbers[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            switch component {
            case 0:
                return "\(row) Hour"
            case 1:
                return "\(row) Minute"
            case 2:
                return "\(row) Second"
            default:
                return ""
            }
        }
        return "\(numbers[row])"
    }
}
