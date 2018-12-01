//
//  StartTableViewCell.swift
//  pressProject
//
//  Created by minsoo kim on 01/12/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit

class StartTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //TODO: 이 밑에는 날짜에 따른 시간 표현이 들어가야 한다.
    @IBOutlet weak var currentTime: UILabel!
    
}
