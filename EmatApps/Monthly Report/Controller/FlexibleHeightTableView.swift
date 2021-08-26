//
//  FlexibleHeightTableView.swift
//  EmatApps
//
//  Created by Dian Dinihari on 26/08/21.
//

import UIKit

class FlexibleHeightTableView: UITableView {

    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
      
      override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
      }
      
      override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
      }

}
