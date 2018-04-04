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
        label.numberOfLines = 1
        let attributedText = NSMutableAttributedString(string: "10:30", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        label.attributedText = attributedText
        return label
    }()
    
    var serviceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        let attributedText = NSMutableAttributedString(string: "U1", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 231/255, green: 189/255, blue: 81/255, alpha: 1), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        label.attributedText = attributedText
        return label
    }()
    
    var arriveLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        let attributedText = NSMutableAttributedString(string: "10:30", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        label.attributedText = attributedText
        return label
    }()
    
    var dStopLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        let attributedText = NSMutableAttributedString(string: "Leamington Spa, Regent Street", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        label.attributedText = attributedText
        return label
    }()
    
    var aStopLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        let attributedText = NSMutableAttributedString(string: "Kirby Corner, Interchange (Stop UW3)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        label.attributedText = attributedText
        return label
    }()
    
    
    /*var departLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        let attributedText = NSMutableAttributedString(string: "10:30", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: "\nLeamington Spa, Regent Street\nKirby Corner, Interchange (Stop UW3)", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        label.attributedText = attributedText
        return label
    }()
    
    var arriveLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        let attributedText = NSMutableAttributedString(string: "11:00", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: "\nU1", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        label.attributedText = attributedText
        return label
    }()
    */
    
    func setLabels(service: String, departTime: String, arriveTime: String, departStop: String, arriveStop: String){
       
        var attributedText = NSMutableAttributedString(string: "\(departStop)", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)])
        
        dStopLabel.attributedText = attributedText
        dStopLabel.textAlignment = .left
        
        attributedText = NSMutableAttributedString(string: "\(arriveStop)", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)])
        
        aStopLabel.attributedText = attributedText
        aStopLabel.textAlignment = .left
        
        attributedText = NSMutableAttributedString(string: "\(arriveTime)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        arriveLabel.attributedText = attributedText
        arriveLabel.textAlignment = .right
        
        attributedText = NSMutableAttributedString(string: "\(departTime)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        departLabel.attributedText = attributedText
        departLabel.textAlignment = .left
        
        attributedText = NSMutableAttributedString(string: "\(service)", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 231/255, green: 189/255, blue: 81/255, alpha: 1), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        serviceLabel.attributedText = attributedText
        serviceLabel.textAlignment = .center
        
        
    }
    
    func setupViews(){
        backgroundColor = UIColor.white
        addSubview(departLabel)
        addSubview(arriveLabel)
        addSubview(serviceLabel)
        addSubview(aStopLabel)
        addSubview(dStopLabel)
        self.accessoryType = .none
        
        addConstraintsWithFormat(format: "H:|-8-[v0][v1(==v0)][v2(==v0)]-8-|", views: departLabel, serviceLabel, arriveLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: dStopLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: aStopLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0]-2-[v1][v2]-8-|", views: departLabel, dStopLabel, aStopLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0]-2-[v1][v2]-8-|", views: serviceLabel, dStopLabel, aStopLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0]-2-[v1][v2]-8-|", views: arriveLabel, dStopLabel, aStopLabel)
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
        if self.count > length {
            return String(self.prefix(length)) + trailing
        } else {
            return self
        }
    }
}
