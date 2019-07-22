class CreateAgendas < ActiveRecord::Migration[5.2]
  def change
    create_table :agendas do |t|
      t.string :paciente
      t.string :medico
      t.string :especialidade
      t.datetime :consulta
      t.datetime :fim_consulta

      t.timestamps
    end
  end
end
