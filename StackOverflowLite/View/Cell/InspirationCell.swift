import UIKit

class InspirationCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate{

    static let reuseIdentifier = String(describing: InspirationCell.self)
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var tags = [String]()
    
    @IBOutlet weak var tagColletionView: UICollectionView!
    
    @IBOutlet weak var tagCollectionViewHeightConstraint: NSLayoutConstraint!
    public var viewModel: QuestionsColletionViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
            authorNameLabel.text = viewModel.ownerName
            //tagsLabel.text = viewModel.tags
            avatarImageView.imageFromServerURL(urlString: viewModel.profileImageURL)
            
            tags = viewModel.tagsArray
            tagColletionView.dataSource = self
            tagColletionView.delegate = self
            
            let cellNib = UINib(nibName: "TagCell", bundle: nil)
            self.tagColletionView.register(cellNib, forCellWithReuseIdentifier: "TagCell")
            self.tagColletionView.backgroundColor = UIColor.clear
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        self.configureCell(cell: cell, forIndexPath: indexPath as NSIndexPath)
        return cell

    }
    func configureCell(cell: TagCell, forIndexPath indexPath: NSIndexPath) {
        
      let tag = tags[indexPath.row]
        cell.tagLabel.text = tag
        
        var height = tagColletionView.collectionViewLayout.collectionViewContentSize.height
        tagCollectionViewHeightConstraint.constant = height
    }
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
        let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
        
        let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
        
        let scale = max(delta, 0.9)
        titleLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        avatarImageView.alpha = delta
        authorNameLabel.alpha = delta
        
        tagColletionView.alpha = delta
        

    }
}
