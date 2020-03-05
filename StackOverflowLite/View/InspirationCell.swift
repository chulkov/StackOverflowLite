import UIKit

class InspirationCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: InspirationCell.self)
  
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var imageCoverView: UIView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var timeAndRoomLabel: UILabel!
  @IBOutlet private weak var speakerLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!
    
    
    public var viewModel: QuestionsColletionViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
            timeAndRoomLabel.text = viewModel.ownerName
            var tagsLabelText = ""
            for tag in viewModel.tags{
                tagsLabelText.append("\(tag), ")
            }
            speakerLabel.text = String(tagsLabelText.dropLast(2))
            //speakerLabel.text = viewModel.language
        }
    }

  
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    
    let featuredHeight = UltravisualLayoutConstants.Cell.featuredHeight
    let standardHeight = UltravisualLayoutConstants.Cell.standardHeight
    
    let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
    
    let minAlpha: CGFloat = 0.3
    let maxAlpha: CGFloat = 0.75
    
    //imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
    let scale = max(delta, 0.9)
    titleLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
    
    avatarImageView.alpha = delta
    timeAndRoomLabel.alpha = delta
    speakerLabel.alpha = delta
  }
}
