import UIKit
import Kingfisher

class LeagueTableCell: UITableViewCell {
    
    @IBOutlet weak var LeagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    
    // Constants for design
    private enum Constants {
        static let imageSize: CGFloat = 40
        static let cornerRadius: CGFloat = 20
        static let borderWidth: CGFloat = 0.5
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellAppearance()
    }
    
    func configure(with title: String, image: String) {
        leagueName.text = title
        
        // Use system image as placeholder if URL is invalid
        let placeholder = UIImage(systemName: "photo.circle.fill")?
            .withTintColor(.systemGray3, renderingMode: .alwaysOriginal)
        
        guard let url = URL(string: image) else {
            LeagueImage.image = placeholder
            return
        }
        
        LeagueImage.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [.transition(.fade(0.3))]
        )
    }
    
    private func setupCellAppearance() {
        // Cell container styling
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
    
        LeagueImage.heightAnchor.constraint(lessThanOrEqualToConstant: 68).isActive = true
        LeagueImage.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    
        // Image styling
        LeagueImage.contentMode = .scaleAspectFit
        LeagueImage.layer.masksToBounds = true
        LeagueImage.layer.cornerRadius = Constants.cornerRadius
        LeagueImage.layer.borderWidth = Constants.borderWidth
        LeagueImage.layer.borderColor = UIColor.systemGray4.cgColor
        LeagueImage.backgroundColor = .systemBackground
        LeagueImage.tintColor = .systemGray3
        
        // Title styling
        leagueName.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        leagueName.textColor = .label
        leagueName.numberOfLines = 2
        leagueName.adjustsFontSizeToFitWidth = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Add contentView padding
        let verticalInset: CGFloat = 6
        let horizontalInset: CGFloat = 16
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(
            top: verticalInset,
            left: horizontalInset,
            bottom: verticalInset,
            right: horizontalInset
        ))
        
        // Ensure image maintains aspect ratio
        LeagueImage.layer.cornerRadius = Constants.cornerRadius
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        LeagueImage.image = nil
        LeagueImage.kf.cancelDownloadTask()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            self.contentView.alpha = selected ? 0.9 : 1.0
            self.contentView.transform = selected ?
                CGAffineTransform(scaleX: 0.97, y: 0.97) : .identity
        }
    }
}
