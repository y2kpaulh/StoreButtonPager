//
//  ChannelStoreView.swift
//  ShallWeShop
//
//  Created by Inpyo Hong on 2020/07/24.
//  Copyright © 2020 Epiens Corp. All rights reserved.
//

import UIKit
import FSPagerView

class ChannelStoreView: UIView, FSPagerViewDataSource,FSPagerViewDelegate {
    

    
    fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]

 
    
    @IBOutlet weak var pagerView: FSPagerView! {
           didSet {
               self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
               self.pagerView.itemSize = FSPagerView.automaticSize
           }
       }
   // var disposeBag = DisposeBag()

     override init(frame: CGRect) {
       super.init(frame: frame)
       commonInit()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       commonInit()
     }

     func commonInit() {
       let bundle = Bundle.init(for: ChannelStoreView.self)
       if let viewsToAdd = bundle.loadNibNamed("ChannelStoreView", owner: self, options: nil), let contentView = viewsToAdd.first as? UIView {
         addSubview(contentView)
         contentView.frame = self.bounds
         contentView.autoresizingMask = [.flexibleHeight,
                                         .flexibleWidth]
        self.pagerView.isInfinite = true
        self.pagerView.automaticSlidingInterval = 3.0 - self.pagerView.automaticSlidingInterval

        self.pagerView.decelerationDistance = FSPagerView.automaticDistance
       }
     }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
       return  imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
           let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
           cell.imageView?.image = UIImage(named: self.imageNames[index])
           cell.imageView?.contentMode = .scaleAspectFill
           cell.imageView?.clipsToBounds = true
         //cell.textLabel?.text = index.description+index.description
           return cell
       }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        print(index)
    }
}
