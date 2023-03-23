class Turma < ApplicationRecord
    validates :sede, :dia, :horario, :valor, :professor, presence: true 
end
