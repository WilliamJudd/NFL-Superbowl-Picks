//
//  PickVerificationViewController.swift
//  NFL Superbowl Picks
//
//  Created by William Judd on 10/5/15.
//  Copyright © 2015 William Judd. All rights reserved.
//

import UIKit

class PickVerificationViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
//    @IBOutlet var pageControl: UIPageControl!
    var recordRef: Firebase!
    var pageImages = [UIImage]()
    var pageViews: [UIImageView?] = []
    var finalPick: UIButton!
    var finalPicks2: UIButton!
    var finalPicks3: UIButton!
    var finalPicks4: UIButton!
    var finalPicks5: UIButton!
    var finalPicks6: UIButton!
    var finalPicks7: UIButton!
    var finalPicks8: UIButton!
    var finalPicks9: UIButton!
    var finalPicks10: UIButton!
    var afcPicks : NSMutableArray = NSMutableArray()
    var afcPicks2 : NSMutableArray = NSMutableArray()
    var nfcPicks : NSMutableArray = NSMutableArray()
    var nfcPicks2 : NSMutableArray = NSMutableArray()
    
    
    @IBOutlet weak var finalPicks11: UIButton!
    
    @IBOutlet weak var finalPicks1: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the image you want to scroll & zoom and add it to the scroll view
        print(nfcPicks)
        pageImages.append(UIImage(named: "exibitScroll1")!)
        pageImages.append(UIImage(named: "exhibitScroll2")!)
        pageImages.append(UIImage(named: "exhibitScroll3")!)
        pageImages.append(UIImage(named: "exhibitScroll4")!)
//            UIImage(named:"photo4.png")!,
//            UIImage(named:"photo5.png")!]
        
        let pageCount = pageImages.count
//      
        
        let image = nfcPicks2[0] as! UIImage
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: (view.bounds.width - 150) / 2 - 300, y: (view.bounds.height - 100) / 2 - 260, width: 150, height: 150)
        view.addSubview(imageView)
        
        let image2 = nfcPicks2[1] as! UIImage
        let imageView2 = UIImageView(image: image2)
        imageView2.frame = CGRect(x: (view.bounds.width - 150) / 2 - 150, y: (view.bounds.height - 100) / 2 - 260, width: 150, height: 150)
        view.addSubview(imageView2)
        
        let image3 = nfcPicks2[2] as! UIImage
        let imageView3 = UIImageView(image: image3)
        imageView3.frame = CGRect(x: (view.bounds.width - 150) / 2 - 0, y: (view.bounds.height - 100) / 2 - 260, width: 150, height: 150)
        view.addSubview(imageView3)
        
        let image4 = nfcPicks2[3] as! UIImage
        let imageView4 = UIImageView(image: image4)
        imageView4.frame = CGRect(x: (view.bounds.width - 150) / 2 + 150, y: (view.bounds.height - 100) / 2 - 260, width: 150, height: 150)
        view.addSubview(imageView4)
        
        let image5 = nfcPicks2[4] as! UIImage
        let imageView5 = UIImageView(image: image5)
        imageView5.frame = CGRect(x: (view.bounds.width - 150) / 2 + 300, y: (view.bounds.height - 100) / 2 - 260, width: 150, height: 150)
        view.addSubview(imageView5)
        
        let image6 = afcPicks2[0] as! UIImage
        let imageView6 = UIImageView(image: image6)
        imageView6.frame = CGRect(x: (view.bounds.width - 150) / 2 - 300, y: (view.bounds.height - 100) / 2 - 100, width: 150, height: 150)
        view.addSubview(imageView6)
        
        let image7 = afcPicks2[1] as! UIImage
        let imageView7 = UIImageView(image: image7)
        imageView7.frame = CGRect(x: (view.bounds.width - 150) / 2 - 150, y: (view.bounds.height - 100) / 2 - 100, width: 150, height: 150)
        view.addSubview(imageView7)
        
        let image8 = afcPicks2[2] as! UIImage
        let imageView8 = UIImageView(image: image8)
        imageView8.frame = CGRect(x: (view.bounds.width - 150) / 2 - 0, y: (view.bounds.height - 100) / 2 - 100, width: 150, height: 150)
        view.addSubview(imageView8)
        
        let image9 = afcPicks2[3] as! UIImage
        let imageView9 = UIImageView(image: image9)
        imageView9.frame = CGRect(x: (view.bounds.width - 150) / 2 + 150, y: (view.bounds.height - 100) / 2 - 100, width: 150, height: 150)
        view.addSubview(imageView9)
        
        let image10 = afcPicks2[4] as! UIImage
        let imageView10 = UIImageView(image: image10)
        imageView10.frame = CGRect(x: (view.bounds.width - 150) / 2 + 300, y: (view.bounds.height - 100) / 2 - 100, width: 150, height: 150)
        view.addSubview(imageView10)
        
        
        
        
//        
//        _ = NSTimer.scheduledTimerWithTimeInterval(8.0, target: self, selector: "timeToMoveOn", userInfo: nil, repeats: false)
        
        
        
        // Set up the array to hold the views for each page
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        // Set up the content size of the scroll view
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), pagesScrollViewSize.height)
        
        
       

        
        // Load the initial set of pages that are on screen
        loadVisiblePages()
    }
    
    func loadPage(page: Int) {
        
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Load an individual page, first checking if you've already loaded it
        if let pageView = pageViews[page] {
            // Do nothing. The view is already loaded.
        } else {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            frame = CGRectInset(frame, 10.0, 0.0)
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            
            
            scrollView.addSubview(newPageView)
            pageViews[page] = newPageView
        }
    }
    
    func purgePage(page: Int) {
        
        
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
        
    }
    
    func loadVisiblePages() {
        UIView.animateWithDuration(8) {
            self.scrollView.setContentOffset(CGPointMake(400, 0), animated: true)
            
            
        }
        // First, determine which page is currently visible
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        // Update the page control
//        pageControl.currentPage = page
        
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 3
        
        
        // Purge anything before the first page
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        // Load pages in our range
        for var index = firstPage; index <= lastPage; ++index {
            loadPage(index)
        }
        
        // Purge anything after the last page
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // Load the pages that are now on screen
        loadVisiblePages()
        
    
    }
    
  
    func timeToMoveOn() {
        self.performSegueWithIdentifier("unwindToContainerVC", sender: self)
    
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

