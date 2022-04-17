//
//  MainVC.swift
//  ApelsinAnimation
//
//  Created by Ahliddin Nasriddinov on 13.04.2022.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var sliderView: UIView!
    
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
     
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            self.lastKnowContentOfsset = scrollView.contentOffset.y / 10
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastKnowContentOfsset = scrollView.contentOffset.y / 10
    }

}


extension MainVC {
    
    func manageAnimation(contentOffset: CGFloat){
         
        let isUp = contentOffset > self.lastKnowContentOfsset
        self.manageViewAnimation(contentOffset: contentOffset, isUp: isUp)
        self.manageLabelAnimation(contentOffset: contentOffset, isUp: isUp)
        manageApelsinAnimation(contentOffset: contentOffset, isUp: isUp)
       
        
        if isUp {
            print("scrolling Up")
        } else {
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
                } completion: { (_) in  }
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
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear) { [self] in
//                sumLabelTopConstrant.constant = 120 - contentOffset*60
//                searchView.isHidden = true
                } completion: { (_) in

                }
            }
        }else if sumLabelTopConstrant.constant < 120 {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear) { [self] in
//                sumLabel.transform =  .identity
            } completion: { (_) in
                
            }
            // CGAffineTransform(translationX: 30, y: -contentOffset*60)
//            sumLabelTopConstrant.constant = contentOffset*60
//                searchView.isHidden = true
        }
    }

    
    
func manageApelsinAnimation(contentOffset : CGFloat, isUp : Bool) {
    print("manageApelsinAnimation \(contentOffset)")
    if isUp {
        
        if contentOffset < 1.8 && contentOffset > 0 {
            
            UIView.animate(withDuration: 0.01, delay: 0, options: .curveLinear) { [self] in
                
                sliderView.transform = CGAffineTransform(translationX: 50, y: 0)
            
            } completion: { [self] (_) in
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear) { [self] in
                    sliderView.transform = CGAffineTransform(translationX: 50, y: -contentOffset*60)
                } completion: {  (_) in

                }
            }
        }
                    
    }else if contentOffset <= 0 {
        UIView.animate(withDuration: 0.01, delay: 0, options: .curveLinear) { [self] in
            
            sliderView.transform = CGAffineTransform(translationX: 100, y: 0)
           
        } completion: { [self] (_) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear) { [self] in
                sliderView.transform = .identity
            } completion: {  (_) in

            }
        }
//        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) { [self] in
//            sliderView.transform = .identity
//        } completion: { (_) in
//
//        }
    }
}
    
}
    

