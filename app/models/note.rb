class Note < ApplicationRecord
	belongs_to :label, required: false
	validates :title, :presence => {:message => "Usted debe ingresar un nombre para la tarea"}
end