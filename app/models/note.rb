class Note < ApplicationRecord
	belongs_to :label, required: false
	has_many :commenters
	validates :title, :presence => {:message => "Usted debe ingresar un nombre para la tarea"}
end