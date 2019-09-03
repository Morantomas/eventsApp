//
//  EventCell.swift
//  Events
//
//  Created by Tomas Moran on 31/08/2019.
//  Copyright © 2019 Tomas Moran. All rights reserved.
//

import Foundation
import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var horarioLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(withData data:EventModel) {
        self.eventNameLabel.text = data.eventName
        self.locationLabel.text = data.location
        self.participantsLabel.text = data.participants
        self.horarioLabel.text = "\(data.initialHour ?? "") / \(data.endHour ?? "")"
    }
    
}
