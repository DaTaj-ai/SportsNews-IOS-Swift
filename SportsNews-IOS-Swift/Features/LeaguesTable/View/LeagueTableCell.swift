import UIKit
import Kingfisher

class LeagueTableCell: UITableViewCell {
    
    @IBOutlet weak var LeagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    
    private enum Constants {
            static let borderWidth: CGFloat = 0.5
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            setupCellAppearance()
        }
        
        func configure(with title: String, image: String) {
            leagueName.text = title
            
            let placeholder = UIImage(named: "ball")
            
            guard let url = URL(string: image), !image.isEmpty else {
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
            
            // Ensure image is square if not set in storyboard
            LeagueImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                LeagueImage.widthAnchor.constraint(equalTo: LeagueImage.heightAnchor)
            ])
            
            // Image styling
            LeagueImage.contentMode = .scaleAspectFit
            LeagueImage.clipsToBounds = true
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
            
            // Make image circular
            LeagueImage.layer.cornerRadius = LeagueImage.frame.width / 2
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
