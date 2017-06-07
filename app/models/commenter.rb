class Commenter < ApplicationRecord
	belongs_to :note, required: false
	validates :message, :presence => {:message => "Usted debe ingresar un comentario"}
end
