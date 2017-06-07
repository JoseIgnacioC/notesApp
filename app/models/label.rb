class Label < ApplicationRecord
	has_many :notes
	validates :title, :presence => {:message => "Usted debe ingresar un nombre para la etiqueta"}
end
