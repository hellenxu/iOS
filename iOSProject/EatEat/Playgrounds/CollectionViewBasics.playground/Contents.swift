import UIKit
import PlaygroundSupport

class CollectionViewController: UIViewController, UICollectionViewDataSource {
    
    var collectionView: UICollectionView?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoxCell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
    }
    
    func initCollectionView () {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: UICollectionViewLayout())
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .blue
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "BoxCell")
        view.addSubview(collectionView!)
    }

}

PlaygroundPage.current.liveView = CollectionViewController()
