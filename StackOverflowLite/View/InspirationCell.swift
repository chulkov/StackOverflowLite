import UIKit

class InspirationCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: InspirationCell.self)
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    public var viewModel: QuestionsColletionViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
            authorNameLabel.text = viewModel.ownerName
            tagsLabel.text = viewModel.tags
            avatarImageView.imageFromServerURL(urlString: viewModel.profileImageURL)
        }
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
        tagsLabel.alpha = delta
    }
}
