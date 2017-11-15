//
//  timeCell.swift
//  StageCoach
//
//  Created by Nami Shah on 14/11/2017.
//  Copyright © 2017 Nami Shah. All rights reserved.
//

import Foundation
import UIKit

class timeCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var departLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: "10:30", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: "\nLeamington Spa, Regent Street", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        label.attributedText = attributedText
        return label
    }()
    
    var arriveLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: "11:00", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: "\nKirby Corner, Interchange (Stop UW3)", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        label.attributedText = attributedText
        return label
    }()
    
    func setLabels(service: String, departTime: String, arriveTime: String, departStop: String, arriveStop: String){
        var label = UILabel()
        label.numberOfLines = 2
        var attributedText = NSMutableAttributedString(string: "\(departTime)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: "\n\(departStop.truncate(length: 40))", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)]))
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        label.attributedText = attributedText
        departLabel.attributedText = attributedText
        departLabel.textAlignment = .left
        
        label = UILabel()
        label.numberOfLines = 2
        attributedText = NSMutableAttributedString(string: "\(arriveTime)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: "\n\(service)", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)]))
        
        paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        label.attributedText = attributedText
        label.textAlignment = .right
        arriveLabel.attributedText = attributedText
        arriveLabel.textAlignment = .right
    }
    
    func setupViews(){
        backgroundColor = UIColor.white
        addSubview(departLabel)
        addSubview(arriveLabel)
        self.accessoryType = .none
        addConstraintsWithFormat(format: "H:|-8-[v0]-[v1]-8-|", views: departLabel, arriveLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: departLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: arriveLabel)
    }
    
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for(index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension String {
    /**
     Truncates the string to the specified length number of characters and appends an optional trailing string if longer.
     
     - Parameter length: A `String`.
     - Parameter trailing: A `String` that will be appended after the truncation.
     
     - Returns: A `String` object.
     */
    func truncate(length: Int, trailing: String = "…") -> String {
        if self.characters.count > length {
            return String(self.characters.prefix(length)) + trailing
        } else {
            return self
        }
    }
}
