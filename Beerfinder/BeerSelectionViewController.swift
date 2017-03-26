//
//  BeerSelectionViewController.swift
//  Beerfinder
//
//  Created by Henry Dinhofer on 3/25/17.
//  Copyright © 2017 Ranger Bud. All rights reserved.
//

import UIKit

class BeerSelectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var beerCollectionView: UICollectionView!
    
    let reuseID = "beerCell"
    let filterReuseID = "filterHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.56, green: 0.12, blue: 0.16, alpha: 1.0) //255.0
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.56, green: 0.12, blue: 0.16, alpha: 1.0) //255.0

        let ABInBevLogo = UIImageView.init(image:#imageLiteral(resourceName: "ABInBevlogo"))
        ABInBevLogo.frame = CGRect(x: 0, y: 0, width: 320, height: 44)
        ABInBevLogo.contentMode = .scaleAspectFit
        navigationItem.titleView = ABInBevLogo
        
        let headerView = UIView(frame: CGRect(x: 0, y: 44, width: view.frame.size.width, height: 80))
        
        
        
        //let myView = Bundle.loadView(fromNib: "FilterHeader", withType: FilterHeader.self)

        
        
        beerCollectionView.delegate = self
        beerCollectionView.dataSource = self
        
        beerCollectionView.register(UINib(nibName: "FilterHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: filterReuseID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        
        return 5
//        if section == 0 { return 1 }
//        else { return 5 } //imagearray.count }
       
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath)
        cell.contentView.backgroundColor = UIColor.red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview : UICollectionReusableView? = nil
        
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView : FilterHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: filterReuseID, for: indexPath) as! FilterHeader
            
            //headerview.foo()
            //headerView.backgroundColor = UIColor.blue
            reusableview = headerView
        }
       
        return reusableview!
    }
}
extension Bundle {
    
    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        
        fatalError("Could not load view with type " + String(describing: type))
    }
}
