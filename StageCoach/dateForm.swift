//
//  dateForm.swift
//  StageCoach
//
//  Created by Nami Shah on 15/11/2017.
//  Copyright © 2017 Nami Shah. All rights reserved.
//

import Foundation
import Eureka

class dateForm: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let section = Section("")
        let row = DateInlineRow("Departure Time"){ row in
            row.title = "Departure Time"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            dateFormatter.locale = Locale(identifier: "en_US")
            let dateString = dateFormatter.string(from: Date())
            row.value = dateFormatter.date(from: dateString)
            }.cellUpdate({ (cell, row) in
                cell.textLabel?.textColor = UIColor.blue
            })
        section.append(row)
        form.append(section)
    }
}
