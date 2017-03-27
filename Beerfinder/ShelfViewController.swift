//
//  ShelfViewController.swift
//  Beerfinder
//
//  Created by Kachi Nwaobasi on 3/25/17.
//  Copyright © 2017 Ranger Bud. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ShelfViewController : UIViewController {
    
    @IBOutlet weak var sortedLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedCellIndexPath: IndexPath!
    
    var beers: [TempBeer]!
    var collectionViewBeers: [TempBeer]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        beers = constructBeerArrayFromSeedData()
        collectionViewBeers = beers
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        beers = constructBeerArrayFromSeedData()
        collectionViewBeers = beers
    }
    
    fileprivate func constructBeerArrayFromSeedData() -> [TempBeer] {
        let path = Bundle.main.path(forResource: "seed_data", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        let topLevelJson = JSON(data: data)
        var beerArray = [TempBeer]()
        for json in topLevelJson.arrayValue {
            beerArray.append(TempBeer(json: json))
        }
        return beerArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupNavigationBar()
        self.collectionViewBeers.sort(by: {
            $0.name.lowercased() < $1.name.lowercased()
        })
        sortedLabel.text = "Sorted: Alphabetically"
    }
    
    fileprivate func configureViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    fileprivate func setupNavigationBar() {
        let sortButton = UIBarButtonItem(image: UIImage(named: "nav_bar_icon_sort")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(ShelfViewController.showSortActionSheet))
        navigationItem.rightBarButtonItem = sortButton
        
        let titleView = UINavigationBarTitleView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: navigationController!.navigationBar.frame.size))
        titleView.image.image = UIImage(named: "ab_bev_logo")!
        navigationItem.titleView = titleView
        
        titleView.image.sizeToFit()
        titleView.imageLeadingConstraints.constant = 0
        titleView.setNeedsLayout()
        navigationController!.navigationBar.layoutIfNeeded()
        let centerX = navigationController!.navigationBar.center.x
        
        titleView.imageLeadingConstraints.constant = centerX - titleView.frame.origin.x - titleView.image.frame.size.width/2
        titleView.setNeedsUpdateConstraints()
        titleView.layoutIfNeeded()
    
    }
    
    
    
    
    
    @IBAction func detailsTapped(_ sender: UIButton) {
        if let shelfCell = getLocationChatTableViewCellOf(sender), let indexPath = collectionView.indexPath(for: shelfCell) {
            selectedCellIndexPath = indexPath
            let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "BeerDetailsViewController") as! BeerDetailsViewController
            detailsViewController.beer = collectionViewBeers[selectedCellIndexPath.row]
            detailsViewController.modalPresentationStyle = .custom
            detailsViewController.transitioningDelegate = self
            present(detailsViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func orderTapped(_ sender: UIButton) {
        if let shelfCell = getLocationChatTableViewCellOf(sender), let indexPath = collectionView.indexPath(for: shelfCell) {
            let placeOrderViewCOntroller = storyboard?.instantiateViewController(withIdentifier: "PlaceOrderViewController") as! PlaceOrderViewController
            placeOrderViewCOntroller.beer = beers[indexPath.row]
            navigationController?.pushViewController(placeOrderViewCOntroller, animated: true)
        }
    }
    
    func showSortActionSheet() {
        let alert = UIAlertController(title: "Sort By", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Alphabetically", style: .default) {
            _ in
            self.collectionViewBeers.sort(by: {
                $0.name.lowercased() < $1.name.lowercased()
            })
            self.collectionView.reloadData()
                    self.sortedLabel.text = "Sorted: Alphabetically"
        })
        alert.addAction(UIAlertAction(title: "Lowest Price", style: .default) {
            _ in
            self.collectionViewBeers.sort(by: {
                $0.price < $1.price
            })
            self.collectionView.reloadData()
                    self.sortedLabel.text = "Sorted: Lowest Price"
        })
        alert.addAction(UIAlertAction(title: "Highest Price", style: .default) {
            _ in
            self.collectionViewBeers.sort(by: {
                $0.price > $1.price
            })
            self.collectionView.reloadData()
                    self.sortedLabel.text = "Sorted: Highest Price"
        })
        alert.addAction(UIAlertAction(title: "Popularity", style: .default) {
            _ in
            self.collectionViewBeers.sort(by: {
                $0.popularity > $1.popularity
            })
            self.collectionView.reloadData()
                    self.sortedLabel.text = "Sorted: Popularity"
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    fileprivate func getLocationChatTableViewCellOf(_ viewOfInterest: UIView) -> ShelfBeerCollectionCell? {
        var view: UIView? = viewOfInterest
        while view != nil && !(view is ShelfBeerCollectionCell) {
            view = view!.superview
        }
        return view as? ShelfBeerCollectionCell
    }
    
}

//MARK: UICollectionViewDataSource
extension ShelfViewController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewBeers.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShelfBeerCell", for: indexPath) as! ShelfBeerCollectionCell
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func configureCell(_ cell: ShelfBeerCollectionCell, atIndexPath indexPath: IndexPath) {
        let beer = collectionViewBeers[indexPath.row]
        cell.name.text = beer.name
        print("Image link: \(beer.sizes[0].image)")
        cell.beerImage.image = UIImage(named: beer.sizes[0].image)
        
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}


//MARK: UICollectionViewDelegate
extension ShelfViewController : UICollectionViewDelegateFlowLayout {
    
}

//MARK: UIViewControllerTransitioningDelegate
extension ShelfViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if presented is BeerDetailsViewController, let cell = collectionView.cellForItem(at: selectedCellIndexPath) as? ShelfBeerCollectionCell {
            let detailsButton = cell.detailsButton!
            let rect = createRectForDetailsModal()
            let buttonRect = view.superview!.convert(detailsButton.bounds, from: detailsButton)
            
            let transitioner = EnterFromViewTransitionAnimator(startFrame: buttonRect, endFrame: rect, presenting: true)
            return transitioner
        }
        
        return nil
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let cell = collectionView.cellForItem(at: selectedCellIndexPath) as! ShelfBeerCollectionCell
        let detailsButton = cell.detailsButton!
        
        let rect = createRectForDetailsModal()
        let helpRect = view.superview!.convert(detailsButton.bounds, from: detailsButton)
        
        let transitioner = EnterFromViewTransitionAnimator(startFrame: helpRect, endFrame: rect, presenting: false)
        return transitioner
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = EnterFromViewPresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.enterDelegate = self
        return presentationController
    }
    
    func createRectForDetailsModal() -> CGRect {
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        return CGRect(x: 15, y: statusBarHeight + 10 + navigationController!.navigationBar.frame.height, width: view.frame.width - 30, height: (view.frame.height - statusBarHeight) * 0.7)
    }
}

//MARK: EnterFromViewPresentationDelegate
extension ShelfViewController : EnterFromViewPresentationDelegate {
    func applyDetailsModalTransformationToDetailsButton() {
        let rect = createRectForDetailsModal()
        let cell = collectionView.cellForItem(at: selectedCellIndexPath) as! ShelfBeerCollectionCell
        let detailsButton = cell.detailsButton!
        let buttonRect = view.superview!.convert(detailsButton.bounds, from: detailsButton)
        
        let scale = CGAffineTransform(scaleX: rect.width/detailsButton.frame.width, y: rect.height/detailsButton.frame.height)
        let translate = CGAffineTransform(translationX: rect.midX - buttonRect.midX, y: rect.midY - buttonRect.midY)
        detailsButton.transform = scale.concatenating(translate)
        detailsButton.alpha = 0
    }
    
    func presentationTransitionDidBegin() {
        applyDetailsModalTransformationToDetailsButton()
    }
    
    func presentationTransitionDidEnd() {
        let cell = collectionView.cellForItem(at: selectedCellIndexPath) as! ShelfBeerCollectionCell
        let detailsButton = cell.detailsButton!
        detailsButton.isHidden = true
        detailsButton.transform = CGAffineTransform.identity
        detailsButton.alpha = 1
    }
    
    func dismissalTransitionWillBegin() {
        applyDetailsModalTransformationToDetailsButton()
    }
    
    func dismissalTransitionDidBegin() {
        let cell = collectionView.cellForItem(at: selectedCellIndexPath) as! ShelfBeerCollectionCell
        let detailsButton = cell.detailsButton!
        detailsButton.transform = CGAffineTransform.identity
        detailsButton.alpha = 1
    }
    
    func dismissalTransitionDidEnd() {
        let cell = collectionView.cellForItem(at: selectedCellIndexPath) as! ShelfBeerCollectionCell
        let detailsButton = cell.detailsButton!
        detailsButton.isHidden = false
    }
}
