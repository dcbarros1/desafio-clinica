class Agenda < ApplicationRecord
    validates :paciente,:medico,:especialidade,:consulta,:fim_consulta, presence: true
end
