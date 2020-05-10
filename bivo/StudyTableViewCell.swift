//
//  StudyTableViewCell.swift
//  bivo
//
//  Created by vamsi on 5/8/20.
//  Copyright © 2020 com.vamsi. All rights reserved.
//

import UIKit

protocol StudyAcceptDelegate {
    func didTapAcceptStudy(index:Int)
}

class StudyTableViewCell: UITableViewCell {

    @IBOutlet weak var university: UILabel!
    @IBOutlet weak var research_type: UILabel!
    @IBOutlet weak var coin_value: UILabel!
    @IBOutlet weak var details: UIButton!
    
    var index : Int = 0;
    
    var delegate:StudyAcceptDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    @IBAction func acceptedStudy(_ sender: Any) {
//        print("my dick")
//        delegate?.didTapAcceptStudy(index: index)
//    }
//    @IBAction func buttonPressed(_ sender: UIButton) {
//        print("my dick")
//        delegate?.didTapAcceptStudy(index: index)
//    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        print("my dick")
        delegate?.didTapAcceptStudy(index: index)
    }
}
