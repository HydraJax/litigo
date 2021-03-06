class Injury < ActiveRecord::Base

	INJURY_TYPE = ['Truama','Open Wound', 'Strain/Sprain', 'Soft Tissue Tear', 'Concussion', 'Dislocation', 'Nerve Damage', 'Fracture', 'Amputation', 'Paralysis', 'Death']
	REGION_TYPE = ['Skull', 'Face', 'Head', 'Neck', 'Back', 'Thorax', 'Shoulder', 'Arm', 'Arm - wrist', 'Arm - elbow', 'Hand', 'Fingers', 'Pelvis/Hip', 'Femur', 'Knee', 'Lower Leg', 'Ankle', 'Foot', 'Toes', 'Internal']
	SURGERY_TYPE = ['Arthoscopic', 'Open']

	belongs_to :medical
	belongs_to :firm

	validates :injury_type, presence: true
end
