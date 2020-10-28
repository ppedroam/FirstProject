//
//  CityTableViewCell.swift
//  ProjetoGuilda
//
//  Created by Pedro Menezes on 27/10/20.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    
    override var reuseIdentifier: String {
        return CityTableViewCell.className
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func passData(title: String) {
        self.labelTitle.text = title
    }

}

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
