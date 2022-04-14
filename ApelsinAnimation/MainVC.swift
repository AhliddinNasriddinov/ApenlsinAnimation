//
//  MainVC.swift
//  ApelsinAnimation
//
//  Created by Ahliddin Nasriddinov on 13.04.2022.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var animationView: UIView!
    
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var animationViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sumLabelTopConstrant: NSLayoutConstraint!
    var lastKnowContentOfsset:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
    }
    // register tableview
    func register () {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultTableViewCell")
    }


}


// delegate tableview self
extension MainVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell", for: indexPath)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            let contentOffset = scrollView.contentOffset.y / 10
            print("contentOffset: ", contentOffset)
            self.manageAnimation(contentOffset: contentOffset)
            self.lastKnowContentOfsset = scrollView.contentOffset.y / 10
            
//            if (contentOffset > self.lastKnowContentOfsset) {
//                if contentOffset < 1.8 {
//                    UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) { [self] in
//                        animationViewHeightConstraint.constant = animationViewHeightConstraint.constant - contentOffset*57
//                        sumLabel.transform = CGAffineTransform(translationX: 30, y: -contentOffset*60)
//                        searchView.isHidden = true
////                        sumLabelTopConstrant.constant = sumLabelTopConstrant.constant - contentOffset/10
//
//                    } completion: { (_) in
//
//                    }
//                }
//                print("scrolling Down")
//                print("dragging Up")
//            } else {
////                UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) { [self] in
//////                    animationViewHeightConstraint.constant = animationViewHeightConstraint.constant + contentOffset
////                    sumLabelTopConstrant.constant = sumLabelTopConstrant.constant + contentOffset
////
////                } completion: { (_) in
////
////                }
//                print("scrolling Up")
//                print("dragging Down")
//            }
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            self.lastKnowContentOfsset = scrollView.contentOffset.y / 10
//            print("scrollViewDidEndDragging \(self.lastKnowContentOfsset)")
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastKnowContentOfsset = scrollView.contentOffset.y / 10
    }
    
    
    
}


extension MainVC {
    
    func manageAnimation(contentOffset: CGFloat){
        
        if (contentOffset > self.lastKnowContentOfsset) {
            
            self.manageViewAnimation(contentOffset: contentOffset, isUp: true)
            self.manageLabelAnimation(contentOffset: contentOffset, isUp: true)
            
            
            print("scrolling Up")
           
        } else {
            
            self.manageViewAnimation(contentOffset: contentOffset, isUp: false)
            self.manageLabelAnimation(contentOffset: contentOffset, isUp: false)
           
            print("scrolling Down")
           
        }
    }
    
    func manageViewAnimation(contentOffset : CGFloat, isUp : Bool){
       
        let height = animationViewHeightConstraint.constant
        
        if isUp {
        
            if contentOffset < 10 && height >= CGFloat(0) &&  height < CGFloat(101) {
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear) { [self] in
                    let newH = animationViewHeightConstraint.constant - contentOffset * 10
                    if newH < CGFloat(0) {
                        animationViewHeightConstraint.constant = 0
                    }else{
                        animationViewHeightConstraint.constant = newH >= CGFloat(100) ? 100 : newH
                    }
                               
                } completion: { (_) in

                }
            }
        }else{
           
            if contentOffset >=  -10 && contentOffset <= 0 && height <= CGFloat(100) {
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear) { [self] in
                    let newH = animationViewHeightConstraint.constant - contentOffset * 10
                    if newH > CGFloat(100) {
                        animationViewHeightConstraint.constant = 100
                    }else{
                        animationViewHeightConstraint.constant = newH < CGFloat(0) ? 0 : newH
                    }
                    

                } completion: { (_) in

                }
            }
        }
        
    }
    
    func manageLabelAnimation(contentOffset : CGFloat, isUp : Bool){
        if isUp {
            if contentOffset < 1.8 {
                UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) { [self] in
                    sumLabel.transform = CGAffineTransform(translationX: 30, y: -contentOffset*60)
                    searchView.isHidden = true
                } completion: { (_) in

                }
            }
        }else{
            
        }
    }

    
    
    func manageApelsinAnimation(contentOffset : CGFloat, isUp : Bool){
        if isUp {
           
        }else{
            
        }
    }
    
    
    
    
    
    
    
    
    
}
    

